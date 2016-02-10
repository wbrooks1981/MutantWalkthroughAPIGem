module MutantSchoolAPIModel
  class Term < Resource
    has_many :enrollments
    attribute_names :begins_at, :ends_at
  end
end
