require_relative "../spec/test_helper"

describe MutantSchoolAPIModel do
  it 'has a version number' do
    _(::MutantSchoolAPIModel::VERSION).wont_be_nil
  end

end