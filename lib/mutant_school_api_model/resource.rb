module MutantSchoolAPIModel
  class Resource
    def self.resource_name
      self.name.split('::').last.downcase
    end

    def self.belongs_to(name, options = {})
      class_name = options[:class_name] || name.to_s.capitalize
      var_name   = "@#{name}"
      @relations ||= {}
      @relations[name] = class_name
    end

    def self.relations
      @relations ||= {}
    end

    # 'has_many :enrollments' would generate the following method:
    # def enrollments
    #   @enrollments ||= Enrollment.all(parent: self)
    # end
    def self.has_many(name)
      class_name = name.to_s.capitalize.chomp('s')
      var_name = "@#{name}"
      define_method(name) do
        klass = Object::const_get(class_name)
        if instance_variable_defined?(var_name)
          instance_variable_get(var_name)
        else
          instance_variable_set(var_name, klass.all(parent: self))
        end
      end

      define_method "#{name}=" do |value|
        if value.is_a?(Array)
          instance_variable_set(var_name, value)
        end
          raise TypeError("#{name} must be an Array")
      end
    end

    def self.base_url
      'https://mutant-school.herokuapp.com/api/v1'
    end

    def self.url(options = {})
      parent = options[:parent]
      base = (parent && parent.url) || base_url
      "#{base}/#{resource_name}s"
    end

    def self.base_attribute_names
      [
          :id,
          :url,
          :created_at,
          :updated_at
      ]
    end

    def self.model_specific_attribute_names
      []
    end

    def self.attribute_names
      base_attribute_names + model_specific_attribute_names
    end

    def self.read_only_attribute_names
      base_attribute_names
    end

    # Retrieve all records of the current resource type
    def self.all(options = {})
      response = HTTP.get(url(options))
      return false if response.code != 200

      JSON.parse(response.to_s).map do |attributes_hash|
        self.new attributes_hash
      end
    end

    # Retrieve a single resource, identified by `id`.
    def self.find(id, options = {})
      response = HTTP.get(url(options) + "/#{id}")
      return false if response.code != 200
      self.new JSON.parse(response.to_s)
    end

    def initialize(attr = {})
      create_attribute_accessors
      @url = self.class.url
      # set instance variables from the things in the hash
      update_attributes(attr)
    end

    def create_attribute_accessors
      self.class.send :attr_accessor, *(self.class.attribute_names - self.class.read_only_attribute_names)
      self.class.send :attr_reader, *self.class.read_only_attribute_names
    end

    def update_attributes(attr={})
      attr.each do |name, value|
        value = instantiate_if_related_object(name, value)
        if self.class.attribute_names.include? name.to_sym
          instance_variable_set("@#{name}", value)
        end
      end

      # Some endpoints do not include url in the response.
      update_url unless attr['url'] || attr[:url]

      return to_h
    end

    def instantiate_if_related_object(name, value)
      if self.class.relations.keys.include? name.to_sym
        klass = Object::const_get(self.class.relations[name.to_sym])
        value = klass.new(value)
      end
      value
    end

    def update_url
      @url = self.class.url + "/#{@id}" if persisted?
    end

    def save
      if persisted?
        # Update
        response = HTTP.put(url, json: payload)
        return false if response.code != 200
      else
        # Create
        response = HTTP.post(url, json: payload)
        return false if response.code != 201
      end
      update_attributes JSON.parse(response.to_s)
    end

    def to_h
      attribute_collection = {}
      self.class.attribute_names.each do |name|
        attribute_collection[name] = send(name)
      end
      attribute_collection
    end

    def destroy
      return false unless persisted?
      response = HTTP.delete(url)
      return false if response.code != 204
      @id = nil
      @url = self.class.url
      true
    end

    def persisted?
      !!@id
    end

    private

    def payload
      permitted_attributes = to_h

      # Remove read-only attributes from the hash
      permitted_attributes.keys.each do |key|
        if self.class.read_only_attribute_names.include? key
          permitted_attributes.delete(key)
        end
      end

      return { self.class.resource_name => permitted_attributes }
    end
  end
end
