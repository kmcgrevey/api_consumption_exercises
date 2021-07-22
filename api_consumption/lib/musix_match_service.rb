require 'faraday'
require 'json'
require 'dotenv'
Dotenv.load('vars.env')

class MusixMatchService
  def music_genres
    conn('/music.genres.get')
  end

  def tracks_from_artist(artist)
    conn("/track.search?q_artist=#{artist}")
  end

  def conn(subject)
    key = { apikey: ENV['MUSIX_KEY'] }
    response = Faraday.get("https://api.musixmatch.com/ws/1.1#{subject}", key)
    JSON.parse(response.body)
  end

end