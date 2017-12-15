# frozen_string_literal: true

require 'date'

module Kisiwebhooks::Rules
  class Time
    attr_reader :start_time, :end_time

    def initialize(start_time, end_time)
      @start_time = parse_time(start_time)
      @end_time = parse_time(end_time)
      raise "Should have start or end time!" unless self.start_time || self.end_time
    end

    def triggered?(created_at)
      created_at_as_datetime = parse_time(created_at)
      raise "Invalid time: #{created_at}" unless created_at_as_datetime
      (start_time.nil? || start_time <= created_at_as_datetime) &&
        (end_time.nil? || created_at_as_datetime <= end_time)
    end

    private

    def parse_time(some_time)
      if some_time
        DateTime.parse(some_time) unless some_time.is_a?(DateTime)
      end
    end
  end
end
