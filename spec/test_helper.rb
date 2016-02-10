$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "mutant_school_api_model"
require "minitest/reporters"
require 'minitest/autorun'
require 'mocha/mini_test'
require "factories/mutant_factory"
require "factories/term_factory"

MiniTest::Reporters.use!

include MutantSchoolAPIModel
include MutantSchoolAPIModel::Factories


# def with_phoney_response(&block)
#   json_response = "{\"id\":600,\"mutant_name\":\"Wolverine\",\"power\":\"Healing\",\"real_name\":\"James \\\"Logan\\\" Howlett\",\"created_at\":\"2016-02-08T02:42:05.565Z\",\"updated_at\":\"2016-02-08T02:42:05.565Z\",\"eligibility_begins_at\":\"1974-10-01T00:00:00.000Z\",\"eligibility_ends_at\":null,\"may_advise_beginning_at\":\"1974-10-01T00:00:00.000Z\",\"url\":\"https://mutant-school.herokuapp.com/api/v1/mutants/600\"}"
#   HTTP.stubs(:post).returns(
#       stub(code: 200, to_s: json_response)
#   )
#   HTTP.stubs(:get).returns(
#       stub(code: 200, to_s: json_response)
#   )
#   yield
# end