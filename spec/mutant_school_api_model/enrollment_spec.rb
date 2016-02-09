require 'test_helper'

describe MutantSchoolAPIModel::Enrollment do
  # before do
  #   @wolverine = MutantFactory.build(:wolverine)
  #   @wolverine_fall2016 = TermFactory.build(:wolverine_fall2016)
  #   @wolverine_fall2016 = Enrollment.new
  # end
  #
  # after do
  #   @wolverine_fall2016.destroy if @wolverine_fall2016.persisted?
  # end
  #
  # describe '#save' do
  #   it 'creates a new enrollment' do
  #     actual = Enrollment.new(@wolverine_fall2016.save)
  #     _(actual && actual.to_h).must_equal(@wolverine_fall2016.to_h)
  #   end
  #
  #   it 'updates an existing enrollment' do
  #     @wolverine_fall2016.save
  #     @wolverine_fall2016.ends_at = '2050-05-25'
  #
  #     # Ensure that `save` returns a Hash
  #     saved = @wolverine_fall2016.save
  #     _(saved).must_be_instance_of(Hash)
  #
  #     # Make a Enrollment out of that Hash
  #     actual = Enrollment.new(saved)
  #
  #     # Ensure the new Enrollment is the same as the old
  #     _(actual.to_h).must_equal(@wolverine_fall2016.to_h)
  #   end
  # end
  #
  describe '#find' do
    it 'should retrieve the enrollment if we know the id and student' do
      # @wolverine_fall2016.save
      #
      # actual = Enrollment.find(@wolverine_fall2016.id)
      # _(actual.to_h).must_equal(@wolverine_fall2016.to_h)

      actual = Enrollment.find(1, parent: Mutant.find(1))
      _(actual).must_be_instance_of(Enrollment)
    end

    # it 'should return false if we look for a record that was just deleted' do
    #   @wolverine_fall2016.save
    #   id = @wolverine_fall2016.id
    #
    #   @wolverine_fall2016.destroy
    #   actual = Enrollment.find(id)
    #   _(actual).must_equal false
    #   # _(actual).must_be_instance_of(Array)
    #   # _(actual.empty?).must_equal true
    # end
  end

  describe '#all' do
    it 'should return an array of enrollments' do
      # Create a enrollment, so there will be at least one.
      # @wolverine_fall2016.save

      # Make sure `all` returns an Array.
      actual = Enrollment.all(parent: Mutant.find(1))
      _(actual).must_be_instance_of Array

      # Make sure the first item in the Array is a Enrollment.
      _(actual.first).must_be_instance_of Enrollment
    end
  end
end