require 'test_helper'

describe MutantSchoolAPIModel::Mutant do
  before do
    @wolverine = MutantFactory.build(:wolverine)
  end

  after do
    @wolverine.destroy
  end

  describe '#save' do
    it 'creates a new mutant' do
      actual = Mutant.new(@wolverine.save)
      _(actual.to_h).must_equal(@wolverine.to_h)
    end
  end

  describe '#find' do
    it 'should retrieve the mutant that was just created' do
      @wolverine.save
      actual = Mutant.find(@wolverine.id)
      _(actual.to_h).must_equal(@wolverine.to_h)
    end

    it 'should return false if there is no such record' do
      @wolverine.save
      id = @wolverine.id
      @wolverine.destroy
      actual = Mutant.find(id)
      _(actual).must_equal false
    end
  end

  describe "#All" do
    it "should retrieve an array of mutants" do
      @wolverine.save
      actual = Mutant.all
      _(actual).must_be_instance_of(Array)
      _(actual.first).must_be_instance_of(Mutant)
    end
  end
end

