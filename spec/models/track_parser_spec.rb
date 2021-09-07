require 'rails_helper'

RSpec.describe TrackParser, type: :model do
  subject(:parser) { described_class }
  let(:track) { build(:track) }

  describe '.parse' do
    it 'accepts parsed JSON track data and returns track objects' do
      # get track data to test
    end
  end
end