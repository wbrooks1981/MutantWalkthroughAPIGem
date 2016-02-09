module MutantSchoolAPIModel
  class Resource
    def self.base_url
      "https://mutant-school.herokuapp.com/api/v1"
    end

    def self.resource_name
      self.name.split('::').last.downcase
    end

    def initialize(attr = {})
      # set instance variables from the things in the hash
      @url = self.class.url
      update_attributes(attr)
    end

    def update_attributes(attr = {})
      attr.each do |name, value|
        if self.class.attribute_names.include? name.to_sym
          instance_variable_set("@#{name}", value)
        end
      end
    end

    def self.url
      base_url + "/#{resource_name}s"
    end

    def self.all
      response = HTTP.get(url)
      return false if response.code != 200
      JSON.parse(response.to_s).map do |attributes_hash|
        self.new attributes_hash
      end
    end

    def self.find(id)
      response = HTTP.get(self.url + "/#{id}")
      return false if response.code != 200
      self.new JSON.parse(response.to_s)
    end

    def save
      if persisted?
        response = HTTP.put(url + "/#{@id}", json: payload)
        return false if response.code != 200
      else
        response = HTTP.post(url, json: payload)
        return false if response.code != 201
      end
      update_attributes JSON.parse(response.to_s)
    end

    def destroy
      return false unless persisted?
      response = HTTP.delete(url)
      return false if response.code != 204
      @id = nil
      @url = self.class.url
      true
    end

    def to_h
      attribute_collection = {}
      self.class.attribute_names.each do |name|
        attribute_collection[name] = send(name)
      end
      attribute_collection
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