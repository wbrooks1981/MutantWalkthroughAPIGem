require 'test_helper'

describe MutantSchoolAPIModel::Term do
  before do
    @fall2016 = TermFactory.build(:fall2016)
  end

  after do
    @fall2016.destroy if @fall2016.persisted?
  end

  describe '#save' do
    it 'creates a new term' do
      actual = Term.new(@fall2016.save)
      _(actual && actual.to_h).must_equal(@fall2016.to_h)
    end

    it 'updates an existing term' do
      @fall2016.save
      @fall2016.ends_at = '2050-05-25'

      # Ensure that `save` returns a Hash
      saved = @fall2016.save
      _(saved).must_be_instance_of(Hash)

      # Make a Term out of that Hash
      actual = Term.new(saved)

      # Ensure the new Term is the same as the old
      _(actual.to_h).must_equal(@fall2016.to_h)
    end
  end

  describe '#find' do
    it 'should retrieve the term that was just created' do
      @fall2016.save

      actual = Term.find(@fall2016.id)
      _(actual.to_h).must_equal(@fall2016.to_h)
    end

    it 'should return false if we look for a record that was just deleted' do
      @fall2016.save
      id = @fall2016.id

      @fall2016.destroy
      actual = Term.find(id)
      _(actual).must_equal false
      # _(actual).must_be_instance_of(Array)
      # _(actual.empty?).must_equal true
    end
  end

  describe '#all' do
    it 'should return an array of terms' do
      # Create a term, so there will be at least one.
      @fall2016.save

      # Make sure `all` returns an Array.
      actual = Term.all
      _(actual).must_be_instance_of Array

      # Make sure the first item in the Array is a Term.
      _(actual.first).must_be_instance_of Term
    end
  end

  describe '#enrollments' do
    it 'should return an Array of Enrollment instances if the term has enrollments' do
      actual = Term.find(2).enrollments
      _(actual).must_be_instance_of Array
      _(actual.first).must_be_instance_of Enrollment
    end
  end
end