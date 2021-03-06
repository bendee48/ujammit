require 'rails_helper'

RSpec.describe 'Spotify', type: :request do
  describe 'GET /authorize' do
    # actual requests are disabled via webmock
    it 'redirects to Spotify' do
      get authorize_path
      expect(response).to have_http_status(:redirect)
    end
  end
end