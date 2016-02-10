module MutantSchoolAPIModel
  class Mutant < Resource

    has_many :enrollments

    def self.model_specific_attribute_names
      [:mutant_name,
       :real_name,
       :power,
       :eligibility_begins_at,
       :eligibility_ends_at,
       :may_advise_beginning_at,
       :advisor]
    end

    def self.read_only_attribute_names
     super << :advisor
    end

    attr_accessor *(self.attribute_names - self.read_only_attribute_names)
    attr_reader *self.read_only_attribute_names

  end
end