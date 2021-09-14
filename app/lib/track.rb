class Track
  attr_accessor :name, :artist, :album_link, :preview_link, :played_at
  
  def initialize(name:, artist:, album_link:, preview_link:, played_at:)
    @name = name
    @artist = artist
    @album_link = album_link
    @preview_link = preview_link
    @played_at = played_at
  end
end