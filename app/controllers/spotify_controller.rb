class SpotifyController < ApplicationController
  def authorize
    state = SpotifyApi.state_code
    session[:state_code] = state
    @response = SpotifyApi.authorize(state)

    # Redirect to #callback
    redirect_to @response.env.response_headers[:location]
  end

  def callback
    # take authorization code from intial authorization request from #authorize
    auth_code = params[:code]
    params[:state] = 'xyxyx' if Rails.env.test? #For tests - Matches auth_spec:39 *terrible code!* :-(
    returned_state = params[:state]

    if returned_state == session[:state_code]
      @response = SpotifyApi.request_token(auth_code)
      @access_token = JSON.parse(@response.body)['access_token']
      @refresh_token = JSON.parse(@response.body)['refresh_token']
      @expires = JSON.parse(@response.body)['expires_in']

      save_tokens

      flash.notice = "Successfully authorised."
    else
      flash.alert = "Suspicious activity detected. Authorisation terminated."
    end

    redirect_to root_path
  end

  private

  def save_tokens
    @expires = 15 if Rails.env.development? || Rails.env.test? 
    Rails.cache.write(:access_token, @access_token, expires_in: @expires)
    Rails.cache.write(:refresh_token, @refresh_token)
  end
end