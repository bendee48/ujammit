class StaticController < ApplicationController
  require 'base64'
  require 'json'

  def homepage    
    # returned access token
    # @access = JSON.parse(@response.body)['access_token']
    # @refresh_token = JSON.parse(@response.body)['refresh_token']

    # #use acess token to request stuff
    # @stuff = Faraday.get('https://api.spotify.com/v1/me') do |req|
    #   req.headers['Authorization'] = " Bearer #{@access}"
    # end
    
  end
end
