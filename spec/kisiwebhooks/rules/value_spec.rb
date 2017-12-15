# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kisiwebhooks::Rules::Value do
  subject(:rule) { described_class.new(value) }

  context 'singular value' do
    let(:value) { 'Lock' }

    it { is_expected.to be_triggered('Lock') }
    it { is_expected.not_to be_triggered('Stock') }
  end

  context 'multiple values' do
    let(:value) { ['Lock', 'Stock', 'Barrel'] }

    it { is_expected.not_to be_triggered('Load') }
    it { is_expected.to be_triggered('Stock') }
  end
end
