# frozen_string_literal: true

module Kisiwebhooks::Rules
  class Value
    attr_reader :valid_values

    def initialize(valid_values)
      @valid_values = [*valid_values]
    end

    def triggered?(value)
      valid_values.include? value
    end
  end
end
