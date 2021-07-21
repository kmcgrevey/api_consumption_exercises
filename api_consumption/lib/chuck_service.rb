require 'faraday'
require 'json'

class ChuckService
  def random
    conn("/random")
  end
  
  def random_in_category(category)
    conn("/random?category=#{category}")
  end
  
  def categories
    conn("/categories")
  end

  def search(query)
    conn("/search?query=#{query}")
  end

  def conn(param)
    response = Faraday.get("https://api.chucknorris.io/jokes/#{param}")
    JSON.parse(response.body)
  end

end