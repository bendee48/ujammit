require 'rails_helper'

RSpec.describe SpotifyApi, type: :model do
  describe '.authorize' do
    it 'returns a response object' do
      redirect_url = 'http://localhost:3000/callback'
      allow(SpotifyApi).to receive(:state).and_return("xyxyx")
      stub_const('SpotifyApi::CLIENT_ID', '12345')
      
      stub_request(:get, 'https://accounts.spotify.com/authorize')
        .with(query: { client_id: '12345',
                       response_type: 'code',
                       scope: 'user-read-private',
                       redirect_uri: redirect_url,
                       state: 'xyxyx' })
      response = SpotifyApi.authorize
      
      expect(response).to be_a(Faraday::Response)
    end
  end

  describe '.request_token' do
    it 'returns a response object' do
      allow(SpotifyApi).to receive(:authorization_code).and_return('xyxyxyx')

      stub_request(:post, 'https://accounts.spotify.com/api/token')
        .with(body: { grant_type: 'authorization_code',
                      code: '12345',
                      redirect_uri: 'http://localhost:3000/callback',
                    },
              headers: { authorization: 'Basic xyxyxyx' })

      response = SpotifyApi.request_token('12345')
      expect(response).to be_a(Faraday::Response)
    end    
  end
end