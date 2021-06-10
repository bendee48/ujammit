module ApiRequestHelper
  def authorize(url:, client_id:, redirect_url:, state:, return_info: {})
    stub_request(:get, url)
        .with(query: { client_id: client_id,
                       response_type: 'code',
                       scope: 'user-read-recently-played',
                       redirect_uri: redirect_url,
                       state: state })
        .to_return(return_info)
  end
end