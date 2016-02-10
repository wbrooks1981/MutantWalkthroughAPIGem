module MutantSchoolAPIModel
  module Factories
    class EnrollmentFactory
      include MutantSchoolAPIModel

      def self.build(enrollment = :fall2016)
        Enrollment.new(ENROLLMENT_ATTRIBUTES[enrollment])
      end

      def self.create(enrollment = :fall2016)
        enrollment = build(enrollment)
        enrollment.save
        enrollment
      end

      ENROLLMENT_ATTRIBUTES = {
          wolverine_spring2016: {
              begins_at: '2016-08-08',
              ends_at:   '2016-12-16'
          },
          spring2000:           {
              begins_at: '2000-01-15',
              ends_at:   '2000-05-25'
          }
      }
    end
  end
end
