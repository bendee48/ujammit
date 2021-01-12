module SpotifyApi
  AUTHORIZE_URL = 'https://accounts.spotify.com/authorize'.freeze
  TOKEN_URL = 'https://accounts.spotify.com/api/token'.freeze
  REDIRECT_URL  = 'http://localhost:3000/callback'.freeze
  CLIENT_ID = Rails.application.credentials.spotify[:client_id].freeze
  CLIENT_SECRET = Rails.application.credentials.spotify[:client_secret].freeze

  def self.authorize
    Faraday.get(AUTHORIZE_URL, { client_id:      CLIENT_ID,
                                 response_type:  'code',
                                 scope:          'user-read-private',
                                 redirect_uri:   REDIRECT_URL,
                                 state:          state })
  end

  def self.state
    # code to protect against csrf
    SecureRandom.base64(12)
  end

  def self.request_token(auth_code)
    # use authorization code and swap for access and refresh token
    Faraday.post(TOKEN_URL) do |req|
      req.body = { grant_type: 'authorization_code', code: auth_code, redirect_uri: REDIRECT_URL }
      req.headers['Authorization'] = " Basic #{authorization_code}"
    end
  end

  def self.authorization_code
    Base64.strict_encode64("#{CLIENT_ID}:#{CLIENT_SECRET}")
  end
end