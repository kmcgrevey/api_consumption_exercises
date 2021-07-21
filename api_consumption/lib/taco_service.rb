require 'net/http'
require 'json'

class TacoService
  def random_ingredients
    conn('/random/')
  end

  def random_taco
    conn('/random/?full-taco=true')
  end
  
  def contributions(username)
    conn("/contributions/#{username}/")
  end

  def ingredients_by_type(type)
    conn("/#{type}/")
  end

  def contributors_by_ingredient(type, ingredient)
    conn("/contributors/#{type}/#{ingredient}/")
  end

  def conn(param)
    uri = URI("http://taco-randomizer.herokuapp.com#{param}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
   
end