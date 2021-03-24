class StaticController < ApplicationController
  def homepage
    #use access token to request stuff
    url = 'https://api.spotify.com/v1/me'
    @requested_data = SpotifyApi.get_userdata(url)
    
    @parsed_data = JSON.parse(@requested_data.env.response.body)
  end
end
