require "net/http"
require "json"

class StockApiService
  API_URL = "https://financialmodelingprep.com/api/v3/stock/list"
  API_KEY = "TjBA95mM5eWMsdlGrByYgll9ye0IifR8"

  def self.fetch_stocks
    uri = URI("#{API_URL}?apikey=#{API_KEY}")
    response = Net::HTTP.get(uri)
    JSON.parse(response) # Parse the JSON response into Ruby objects
  rescue StandardError => e
    Rails.logger.error("Failed to fetch stocks: #{e.message}")
    [] # Return an empty array in case of an error
  end
end
