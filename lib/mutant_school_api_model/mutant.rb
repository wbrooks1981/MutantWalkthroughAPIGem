module MutantSchoolAPIModel
  class Mutant < Resource
    def self.attribute_names
      [
          :id,
          :mutant_name,
          :real_name,
          :power,
          :eligibility_begins_at,
          :eligibility_ends_at,
          :may_advise_beginning_at,
          :url,
          :created_at,
          :updated_at,
          :advisor
      ]
    end

    def self.read_only_attribute_names
      [
          :id,
          :url,
          :created_at,
          :updated_at,
          :advisor
      ]
    end

    attr_accessor *(self.attribute_names - self.read_only_attribute_names)
    attr_reader *self.read_only_attribute_names
  end
end