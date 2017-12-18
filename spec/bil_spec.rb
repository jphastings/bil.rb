require 'spec_helper'

describe BIL do
  describe '.pack' do
    subject(:described_method) { described_class.pack(*array) }

    {
      [] => 'Y',
      [0] => 'Yz',
      [1] => 'Ya',
      [15] => 'Yu',
      [16] => 'YAz',
      [255] => 'YUu',
      [0, 0] => 'Yzz',
      [1977, 9, 5] => 'YGPjje',

      [1.1] => 'Ya',
      [1.9] => 'Ya',
      ['1'] => 'Ya',
    }.each do |array, packed|
      context "when the given array is #{array}" do
        let(:array) { array }

        it { should eq packed }
      end
    end

    context 'when a negative number is included' do
      let(:array) { [0, 2, -1, 255] }

      it 'should raise an exception' do
        expect { described_method }.to raise_error(ArgumentError)
      end
    end

    [ nil, 'one', '1.1' ].each do |disallowed|
      context "when the item '#{disallowed.inspect}' is included" do
        let(:array) { [0, 1, disallowed] }

        it 'should raise an exception' do
          expect { described_method }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe '.unpack' do
    subject(:described_method) { described_class.unpack(string) }

    {
      'Y' => [],
      'Yz' => [0],
      'Ya' => [1],
      'Yu' => [15],
      'YAz' => [16],
      'YUu' => [255],
      'Yzz' => [0, 0],
      'YGPjje' => [1977, 9, 5],

      'a' => [1],
      'YA' => [16],
      'Y~a' => [1],
      'YaYa' => [1],
    }.each do |string, unpacked|
      context "when the given string is #{string}" do
        let(:string) { string }

        it { should eq unpacked }
      end
    end

    context 'when a non-string is sent' do
      let(:string) { 1234 }

      it 'should raise an exception' do
        expect { described_method }.to raise_error(TypeError)
      end
    end
  end
end
