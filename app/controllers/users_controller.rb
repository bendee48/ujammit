class UsersController < ApplicationController
  def show
    # Save new access token if refresh exists but access doesn't
    if Rails.cache.exist?(:refresh_token) && Rails.cache.fetch(:access_token).nil?
      @refresh_response = SpotifyApi.request_refreshed_token
      @access_token = JSON.parse(@refresh_response.body)['access_token']
      @expires = JSON.parse(@refresh_response.body)['expires_in']
      
      save_access_token
    end
    
    if Rails.cache.exist?(:access_token)
      url = "https://api.spotify.com/v1/me/player/recently-played"
      @response = SpotifyApi.get_userdata(url)
      @track_items = JSON.parse(@response.body)['items']
    end
  end

  private

  def save_access_token
    # Rails.cache.write(:access_token, @access_token, expires_in: @expires) 
    Rails.cache.write(:access_token, @access_token, expires_in: 15) #testing
  end
end
