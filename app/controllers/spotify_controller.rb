class SpotifyController < ApplicationController
  def authorize
    @response = SpotifyApi.authorize

    redirect_to @response.env.response_headers[:location]
  end

  def callback
    # take authorization code from intial authorization request from #authorize
    auth_code = params[:code]
    # for csrf protection
    state = params[:state]

    @response = SpotifyApi.request_token(auth_code)

    @access_token = JSON.parse(@response.body)['access_token']
    @refresh_token = JSON.parse(@response.body)['refresh_token']
    @expires = JSON.parse(@response.body)['expires_in']
  end
end