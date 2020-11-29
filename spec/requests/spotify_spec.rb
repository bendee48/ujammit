require 'rails_helper'

RSpec.describe 'Spotify', type: :request do
  describe 'GET /authorize' do
    xit 'redirects to Spotify' do
      get authorize_path
      expect(response).to have_http_status(:redirect)
    end
  end
end