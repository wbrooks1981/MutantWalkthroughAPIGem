module MutantSchoolAPIModel
  class Mutant < Resource

    belongs_to :advisor, class_name: "Mutant"
    has_many :enrollments
    attribute_names :mutant_name, :real_name, :power, :eligibility_begins_at, :eligibility_ends_at,
                    :may_advise_beginning_at
  end
end