# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kisiwebhooks::Rules::Time do
  subject(:rule) { described_class.new("#{start_time} | #{end_time}") }

  shared_context 'with start_time' do
    let(:start_time) { '2017-10-12' }
  end

  shared_context 'with end_time' do
    let(:end_time) { '2017-12-12' }
  end

  let(:start_time) { nil }
  let(:end_time) { nil }

  it 'raises error with invalid times' do
    expect { rule }.to raise_error("Should have start or end time!")
  end

  describe 'triggered?' do
    context 'created_at inside bounds' do
      let(:created_at) { '2017-11-12' }

      context 'start_time only' do
        include_context 'with start_time'

        it { is_expected.to be_triggered(created_at) }
      end

      context 'end_time only' do
        include_context 'with end_time'

        it { is_expected.to be_triggered(created_at) }
      end

      context 'between both start and end times' do
        include_context 'with start_time'
        include_context 'with end_time'

        it { is_expected.to be_triggered(created_at) }
      end
    end

    context 'created_at outside bounds' do
      context 'less than start_time' do
        let(:created_at) { '2016-11-12' }

        context 'start_time only' do
          include_context 'with start_time'

          it { is_expected.not_to be_triggered(created_at) }
        end

        context 'both' do
          include_context 'with start_time'
          include_context 'with end_time'

          it { is_expected.not_to be_triggered(created_at) }
        end
      end

      context 'more than end_time' do
        let(:created_at) { '2018-11-12' }

        context 'end_time only' do
          include_context 'with end_time'

          it { is_expected.not_to be_triggered(created_at) }
        end

        context 'both' do
          include_context 'with start_time'
          include_context 'with end_time'

          it { is_expected.not_to be_triggered(created_at) }
        end
      end
    end
  end
end
