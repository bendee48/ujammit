class StaticController < ApplicationController
  def homepage
    #use access token to request stuff
    #url = 'https://api.spotify.com/v1/me'
    url = 'https://api.spotify.com/v1/me/player/recently-played'

    # Request new access token with refresh if it has expired
    unless Rails.cache.exist?(:access_token)
      @response = SpotifyApi.request_refreshed_token
      @access_token = JSON.parse(@response.body)['access_token']
      @expires = JSON.parse(@response.body)['expires_in']

      Rails.cache.write(:access_token, @access_token, expires_in: @expires)
    end

    if Rails.cache.exist?(:refresh_token)
      @requested_data = SpotifyApi.get_userdata(url)
      @parsed_data = JSON.parse(@requested_data.env.response.body)
    end
  end
end
