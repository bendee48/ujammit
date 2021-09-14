require 'rails_helper'

RSpec.describe TrackParser, type: :model do
  subject(:parser) { described_class }
  let(:track) { build(:track) }
  let(:api_response) { File.open('./spec/support/track_data.txt', 'r') { |f| f.read } }
  let(:track_data) { parser.get_tracks(api_response) }

  describe '.get_tracks' do
    it 'accepts API response and returns track objects' do
      expect(track_data.first.class).to eql Track 
    end

    it 'returns 2 tracks' do
      expect(track_data.size).to eql 2
    end

    it 'returns tracks parsed with the correct information' do
      track = track_data.first
      expect(track.name).to eql 'Disciples'
      expect(track.artist).to eql 'Tame Impala'
      expect(track.album_link).to eql 'https://open.spotify.com/track/2gNfxysfBRfl9Lvi9T3v6R'
      expect(track.preview_link).to eql 'https://p.scdn.co/mp3-preview/6023e5aac2123d098ce490488966b28838b14fa2'
    end
  end
end