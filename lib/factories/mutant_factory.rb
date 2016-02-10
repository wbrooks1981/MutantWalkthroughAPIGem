require "mutant_school_api_model/mutant"
module MutantSchoolAPIModel
  module Factories
    class MutantFactory
      include MutantSchoolAPIModel

      def self.build(mutant_name = :wolverine)
        Mutant.new(MUTANT_ATTRIBUTES[mutant_name])
      end

      def self.create(mutant_name = :wolverine)
        mutant = build(mutant_name)
        mutant.save
        mutant
      end

      MUTANT_ATTRIBUTES = {
          wolverine: {
              mutant_name:             'Wolverine',
              real_name:               'Logan',
              power:                   'SNIKT',
              eligibility_begins_at:   '1976-06-11',
              eligibility_ends_at:     '2050-05-03',
              may_advise_beginning_at: '1990-09-25' },

          pheonix:   {
              mutant_name: 'Phoenix',
              real_name:   'Jean Grey',
              power:       'All of it' }
      }
    end
  end
end
