require 'test_helper'

describe MutantSchoolAPIModel::Mutant do
  before do
    @wolverine = MutantFactory.build(:wolverine)
  end

  after do
    @wolverine.destroy if @wolverine.persisted?
  end

  describe '#save' do
    it 'creates a new mutant' do
      actual = Mutant.new(@wolverine.save)
      _(actual.to_h).must_equal(@wolverine.to_h)
    end

    it 'updates an existing mutant' do
      @wolverine.save
      @wolverine.power = 'new power'

      # Ensure that `save` returns a Hash
      saved = @wolverine.save
      _(saved).must_be_instance_of(Hash)

      # Make a Mutant out of that Hash
      actual = Mutant.new(saved)

      # Ensure the new Term is the same as the old
      _(actual.to_h).must_equal(@wolverine.to_h)
    end
  end

  describe '#find' do
    it 'should invoke HTTP.get with the correct URL' do
      @wolverine.save
      HTTP.expects(:get)
          .with(Mutant.url + "/#{@wolverine.id}")
          .returns(stub(code: 200, to_s: @wolverine.to_h.to_json))
      Mutant.find(@wolverine.id)
    end

    it 'should retrieve the mutant that was just created' do
      @wolverine.save

      actual = Mutant.find(@wolverine.id)
      _(actual.to_h).must_equal(@wolverine.to_h)
    end

    it 'should return false if we look for a record that was just deleted' do
      @wolverine.save
      id = @wolverine.id

      @wolverine.destroy
      actual = Mutant.find(id)
      _(actual).must_equal false
      # _(actual).must_be_instance_of(Array)
      # _(actual.empty?).must_equal true
    end
  end

  describe '#all' do
    it 'should return an array of mutants' do
      # Create a mutant, so there will be at least one.
      @wolverine.save

      # Make sure `all` returns an Array.
      actual = Mutant.all
      _(actual).must_be_instance_of Array

      # Make sure the first item in the Array is a Mutant.
      _(actual.first).must_be_instance_of Mutant
    end
  end

  describe '#enrollments' do
    it 'should return an Array of Enrollment instances if the mutant has enrollments' do
      actual = Mutant.find(1).enrollments
      _(actual).must_be_instance_of Array
      _(actual.first).must_be_instance_of Enrollment
    end
  end
end