require 'rails_helper'

RSpec.describe SpotifyApi, type: :model do
  describe '.authorize' do
    it 'returns a response object' do
      redirect_url = 'http://localhost:3000'
      allow(SpotifyApi).to receive(:state).and_return("xyxyx")
      allow(Rails.application.credentials).to receive(:spotify).and_return(client_id: '12345')

      stub_request(:get, 'https://accounts.spotify.com/authorize')
        .with(query: { client_id: Rails.application.credentials.spotify[:client_id],
                       response_type: 'code',
                       scope: 'user-read-private',
                       redirect_uri: redirect_url,
                       state: 'xyxyx' })
      response = SpotifyApi.authorize
      
      expect(response).to be_a(Faraday::Response)
    end
  end
end