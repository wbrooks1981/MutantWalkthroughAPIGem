module MutantSchoolAPIModel
  class Term < Resource
    def self.attribute_names
      [
          :id,
          :begins_at,
          :ends_at,
          :url,
          :created_at,
          :updated_at,
      ]
    end

    def self.read_only_attribute_names
      [
          :id,
          :url,
          :created_at,
          :updated_at,
      ]
    end

    attr_accessor *(self.attribute_names - self.read_only_attribute_names)
    attr_reader *self.read_only_attribute_names
  end
end
