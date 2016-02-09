class TermFactory
  include MutantSchoolAPIModel

  def self.build(term_name = :fall2016)
    Term.new(TERM_ATTRIBUTES[term_name])
  end

  def self.create(term_name = :fall2016)
    term = build(term_name)
    term.save
    term
  end

  TERM_ATTRIBUTES = {
      fall2016: {
          begins_at: '2016-08-08',
          ends_at: '2016-12-16'
      },
      spring2000: {
          begins_at: '2000-01-15',
          ends_at: '2000-05-25'
      }
  }
end