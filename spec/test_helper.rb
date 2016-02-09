$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "mutant_school_api_model"
require "minitest/reporters"
require 'minitest/autorun'
require "factories/mutant_factory"

MiniTest::Reporters.use!

include MutantSchoolAPIModel