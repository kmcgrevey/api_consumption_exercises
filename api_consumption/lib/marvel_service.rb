require 'faraday'
require 'json'
require 'dotenv'
Dotenv.load('vars.env')
require 'digest'

class MarvelService
  attr_reader :time

  def character(name)
    conn("/v1/public/characters", { name: "#{name}" })
  end
  
  def creators(name)
    if name[:last_name]
      options = { lastName: "#{name[:last_name]}" }
    elsif name[:first_name]
      options = { firstName: "#{name[:first_name]}" }
    end
    conn("/v1/public/creators", options)
  end

  def auth_code
    ts = @time
    priv = ENV['MARV_PRIV_KEY']
    pub = ENV['MARV_PUB_KEY']
    Digest::MD5.hexdigest(ts + priv + pub)
  end

  def conn(subject, options)
    @time = Time.now.to_s
    params = { 
      apikey: ENV['MARV_PUB_KEY'],
      ts: @time,
      hash: auth_code
      }
      .merge(options)
      response = Faraday.get("https://gateway.marvel.com#{subject}", params)
    JSON.parse(response.body)
  end

end
