module TrackParser
  def self.get_tracks(api_response)
    parse(api_response)
    tracks
  end

  def self.parse(api_response)
    @parsed_tracks = JSON.parse(api_response)['items']
  end

  def self.tracks
    @tracks = @parsed_tracks.map do |track|
                url = track['track']['external_urls']['spotify']
                Track.new(name: track['track']['name'], 
                          artist: track['track']['artists'][0]['name'], 
                          album_link: url, 
                          preview_link: track['track']['preview_url'])
              end
  end

  private_class_method :parse, :tracks
end