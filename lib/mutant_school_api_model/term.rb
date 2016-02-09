module MutantSchoolAPIModel
  class Term < Resource

    def self.model_specific_attribute_names
      [:begins_at,
       :ends_at]
    end

    attr_accessor *(self.attribute_names - self.read_only_attribute_names)
    attr_reader *self.read_only_attribute_names
  end
end
