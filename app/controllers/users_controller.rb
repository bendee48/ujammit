class UsersController < ApplicationController
  def show
    # If refesh exists but access doesn't
    if Rails.cache.exist?(:refresh_token) &&
       Rails.cache.fetch(:access_token).nil?
        @response = SpotifyApi.request_refreshed_token
        @access_token = JSON.parse(@response.body)['access_token']
        @expires = JSON.parse(@response.body)['expires_in']
        
        save_access_token
    end

    url = "https://api.spotify.com/v1/me/player/recently-played"
    @response = SpotifyApi.get_userdata(url)
    @track_items = JSON.parse(@response.body)['items']
  end

  private

  def save_access_token
    # Rails.cache.write(:access_token, @access_token, expires_in: @expires) 
    Rails.cache.write(:access_token, @access_token, expires_in: 15) #testing
  end
end
