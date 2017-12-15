# frozen_string_literal: true

require 'yaml'
require 'ostruct'

module Kisiwebhooks::Rules
  class Loader
    def self.from_yaml(yaml)
      Loader.new(yaml).from_yaml
    end

    attr_reader :yaml

    def initialize(yaml)
      @yaml = yaml
    end

    def from_yaml
      @yaml = YAML.safe_load(yaml)
      make_rules(yaml['rules'])
    end

    def make_rules(rules_hash)
      rules_hash.each_with_object({}) do |(rule_name, rule), hash|
        hash[rule_name] = OpenStruct.new({ triggers:
          rule.delete('triggers').transform_values do |rule_value|
            rule_parameters = if rule_value.is_a?(Hash)
                                rule_value
                              else
                                {
                                  'value' => rule_value
                                }
                              end
            make_rule(rule_parameters)
          end }.merge(rule))
      end
    end

    def make_rule(rule_parameters)
      type = rule_parameters.delete('type') || 'value'

      Kisiwebhooks::Rules.const_get(type.capitalize).new(rule_parameters['value'])
    end
  end
end
