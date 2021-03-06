require 'rails_helper'

RSpec.describe SpotifyApi, type: :model do
  # Testing only that response objects are returned
  subject(:spotify_api) { described_class }
  
  describe '.authorize' do
    it 'returns a response object' do
      state = 'xyxyx'
      allow(spotify_api).to receive(:state).and_return(state)
      stub_const("#{spotify_api}::CLIENT_ID", '12345')

      authorize(client_id: spotify_api::CLIENT_ID,
                                 state: state)

      response = spotify_api.authorize
      expect(response).to be_a(Faraday::Response)
      expect(response.status).to eql 200
    end
  end

  describe '.request_token' do
    it 'returns a response object' do
      credentials = 'xyxyxyx'
      auth_code = '12345'
      allow(spotify_api).to receive(:encoded_credentials).and_return(credentials)

      request_token(auth_code: auth_code)

      response = SpotifyApi.request_token(auth_code)
      expect(response).to be_a(Faraday::Response)
      expect(response.status).to eql 200
    end    
  end

  describe '.get_userdata' do
    it 'returns a response object' do
      api_url = 'https://api.spotify.com/v1/me'
      allow(Rails.cache).to receive(:fetch).with(:access_token).and_return('hah')
      
      stub_request(:get, api_url)
        .with(headers: { authorization: "Bearer #{Rails.cache.fetch(:access_token)}"})

      response = spotify_api.get_userdata(api_url)
      expect(response).to be_a(Faraday::Response)
    end
  end

  describe '.get_refresh_refreshed_token' do
    it 'returns a response object' do
      allow(Rails.cache).to receive(:fetch).with(:refresh_token).and_return('token')

      stub_request(:post, spotify_api::TOKEN_URL)
        .with(body: { grant_type: 'refresh_token', 
                      refresh_token: Rails.cache.fetch(:refresh_token)
                    },
              headers: { authorization: "Basic #{spotify_api.encoded_credentials}"})

      response = spotify_api.request_refreshed_token
      expect(response).to be_a(Faraday::Response)
    end
  end
end