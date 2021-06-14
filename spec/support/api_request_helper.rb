module ApiRequestHelper
  REDIRECT_URL = SpotifyApi::REDIRECT_URL

  def authorize(client_id:, state:, return_info: {})
    url = SpotifyApi::AUTHORIZE_URL

    stub_request(:get, url)
        .with(query: { client_id: client_id,
                       response_type: 'code',
                       scope: 'user-read-recently-played',
                       redirect_uri: REDIRECT_URL,
                       state: state })
        .to_return(return_info)
  end

  def request_token(auth_code:, return_info: {})
    url = SpotifyApi::TOKEN_URL 

    stub_request(:post, url)
        .with(body: { grant_type: 'authorization_code',
                      code: auth_code,
                      redirect_uri: REDIRECT_URL,
                    },
              headers: { authorization: "Basic #{SpotifyApi.encoded_credentials}" })
        .to_return(return_info)
  end
end