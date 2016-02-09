require "mutant_school_api_model/resource"

module MutantSchoolAPIModel
  class Enrollment < MutantSchoolAPIModel::Resource

    def self.model_specific_attribute_names
      [
          :student,
          :term
      ]
    end

    def self.related_object_mappings
      {
          student: Mutant,
          term: Term
      }
    end

  end
end