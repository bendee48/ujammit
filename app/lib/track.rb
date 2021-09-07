class Track
  attr_accessor :name, :artist, :album_link, :preview_link
  
  def initialize(name:, artist:, album_link:, preview_link:)
    @name = name
    @artist = artist
    @album_link = album_link
    @preview_link = preview_link
  end
end