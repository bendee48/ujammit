class SpotifyController < ApplicationController
  def authorize
    @response = SpotifyApi.authorize

    redirect_to @response.env.response_headers[:location]
  end
end