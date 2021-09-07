FactoryBot.define do
  factory :track do
    # For regular Ruby classes skip create
    skip_create

    name { 'track 1' }
    artist { 'artist 1' }
    album_link { 'album_link' }
    preview_link { 'preview_link' }

    # For regular ruby classes redefine initialize
    initialize_with { new({name: name, artist: artist, album_link: album_link, preview_link: preview_link})}
  end
end