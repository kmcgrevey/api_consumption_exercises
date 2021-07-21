require 'faraday'
require 'json'

class AdviceService
  
  def random
    conn
  end

  def search(keyword)
    conn("/search/#{keyword}")
  end

  def conn(query = '')
    response = Faraday.get("https://api.adviceslip.com/advice#{query}")
    JSON.parse(response.body)
  end

end