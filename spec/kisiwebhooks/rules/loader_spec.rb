# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kisiwebhooks::Rules::Loader do
  let(:yaml) do
    <<~YAML
      rules:
        unlocks:
          subscribers:
            - daniel@getkisi.com
          triggers:
            created_at:
              value: 2017-01-01 | 2017-03-01,2017-05-01 | 2017-08-01
              type: time
            action: unlock
            object_type: Lock
            success: false
YAML
  end

  subject(:rules) { described_class.from_yaml(yaml) }

  context 'valid yaml' do
    subject(:unlocks) { rules['unlocks'] }

    it { is_expected.to respond_to(:triggers) }

    describe 'triggers' do
      subject(:triggers) { unlocks.triggers }

      it { is_expected.to include('action' => a_kind_of(Kisiwebhooks::Rules::Value)) }
      it { is_expected.to include('created_at' => a_kind_of(Kisiwebhooks::Rules::Time)) }

      describe 'default value type' do
        subject(:action) { triggers['action'].valid_values }

        it { is_expected.to eq(['unlock']) }
      end

    end
  end
end
