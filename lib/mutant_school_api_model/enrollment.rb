require "mutant_school_api_model/resource"

module MutantSchoolAPIModel
  class Enrollment < MutantSchoolAPIModel::Resource
    belongs_to :term
    belongs_to :student, class_name: 'Mutant'
    attribute_names :term_id, :student_id
  end
end