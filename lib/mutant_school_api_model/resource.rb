module MutantSchoolAPIModel
  class Resource
    def self.resource_name
      self.name.split('::').last.downcase
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
      response = HTTP.get(url(parent: options[:parent]))
      return false if response.code != 200

      JSON.parse(response.to_s).map do |attributes_hash|
        self.new attributes_hash
      end
    end

    # Retrieve a single resource, identified by `id`.
    def self.find(id)
      response = HTTP.get(self.url + "/#{id}")
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
        if self.class.attribute_names.include? name.to_sym
          instance_variable_set("@#{name}", value)
        end
      end

      # Some endpoints do not include url in the response.
      update_url unless attr['url'] || attr[:url]

      return to_h
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