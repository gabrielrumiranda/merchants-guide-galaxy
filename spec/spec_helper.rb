# frozen_string_literal: true
Bundler.require(:default, :test)
require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

require_relative '../app/line'
require_relative '../app/token'
require_relative '../app/calculator'
require_relative '../app/dictionary'
require_relative '../app/parser'
require_relative '../app/input_repository'
require_relative '../app/token_validator.rb'
