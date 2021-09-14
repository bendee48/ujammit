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
                Track.new(name: track['track']['name'], 
                          artist: track['track']['artists'][0]['name'], 
                          album_link: track['track']['external_urls']['spotify'], 
                          preview_link: track['track']['preview_url'],
                          played_at: track['played_at'])
              end
  end

  private_class_method :parse, :tracks
end