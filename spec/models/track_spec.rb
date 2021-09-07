require 'rails_helper'

RSpec.describe Track, type: :model do
  subject(:track) { described_class.new(name: 'Song 1', 
                                        artist: 'Artist',   
                                        album_link: 'album link',
                                        preview_link: 'preview link') }

  describe '#name' do
    it "returns the name of the track" do
      expect(track.name).to eql 'Song 1'
    end
  end

  describe '#artist' do
    it "returns the artist of the track" do
      expect(track.artist).to eql 'Artist'
    end
  end

  describe '#album_link' do
    it "returns the album link for the track" do
      expect(track.album_link).to eql 'album link'
    end
  end

  describe '#preview_link' do
    it "returns the preview link for the track" do
      expect(track.preview_link).to eql 'preview link'
    end
  end
end