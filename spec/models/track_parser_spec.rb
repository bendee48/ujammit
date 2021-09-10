require 'rails_helper'

RSpec.describe TrackParser, type: :model do
  subject(:parser) { described_class }
  let(:track) { build(:track) }

  let(:api_response) { File.open('./spec/support/track_data.txt', 'r') { |f| f.read } }

  describe '.get_tracks' do
    it 'accepts API response and returns track objects' do
      track_data = parser.get_tracks(api_response)
      expect(track_data.first.class).to eql Track 
    end
  end

  # ADD MORE TESTS
end