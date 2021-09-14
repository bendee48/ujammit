require 'rails_helper'

RSpec.describe TrackParser, type: :model do
  subject(:parser) { described_class }
  let(:track) { build(:track) }
  let(:api_response) { File.open('./spec/support/track_data.txt', 'r') { |f| f.read } }
  let(:track_data) { parser.get_tracks(api_response) }
  let(:track) { track_data.first }

  describe '.get_tracks' do
    it 'accepts API response and returns track objects' do
      expect(track_data.first.class).to eql Track 
    end

    it 'returns 2 tracks' do
      expect(track_data.size).to eql 2
    end

    it 'returns tracks parsed with the correct information' do
    end
  end
  
  describe 'track is parsed with correct information' do
    it 'returns correct name' do
      expect(track.name).to eql 'Disciples'
    end
    
    it 'returns correct artist' do
      expect(track.artist).to eql 'Tame Impala'      
    end
    
    it 'returns correct album link' do
      expect(track.album_link).to eql 'https://open.spotify.com/track/2gNfxysfBRfl9Lvi9T3v6R'
    end
    
    it 'returns correct preview link' do
      expect(track.preview_link).to eql 'https://p.scdn.co/mp3-preview/6023e5aac2123d098ce490488966b28838b14fa2'
    end
    
    it 'returns correct time played' do
      expect(track.played_at).to eql '2016-12-13T20:44:04.589Z'
    end
  end
end