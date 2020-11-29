module SpotifyApi
  AUTHORIZE_URL = 'https://accounts.spotify.com/authorize'.freeze
  REDIRECT_URL  = 'http://localhost:3000'.freeze

  def self.authorize
    response = Faraday.get(AUTHORIZE_URL, { client_id:      Rails.application.credentials.spotify[:client_id],
                                            response_type:  'code',
                                            scope:          'user-read-private',
                                            redirect_uri:   REDIRECT_URL,
                                            state:          state })
  end

  def self.state
    # code to protect against csrf
    SecureRandom.base64(12)
  end
end