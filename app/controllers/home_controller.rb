require "open-uri"
require "json"
# Full API Stock
# https://financialmodelingprep.com/api/v3/search?query=AA&apikey=TjBA95mM5eWMsdlGrByYgll9ye0IifR8
class HomeController < ApplicationController
  # https://financialAAPLmodelingprep.com/api/v3/quote/AAPL?apikey=TjBA95mM5eWMsdlGrByYgll9ye0IifR8
  def index
    @api_key = "TjBA95mM5eWMsdlGrByYgll9ye0IifR8"
    @ticker = params[:ticker]

    if @ticker.blank?
      @nothing = "Hey! You Forgot To Enter A Symbol"
    else
      begin
        # Fetch stock data
        # @url = "https://financialmodelingprep.com/api/v3/quote/#{@ticker}?apikey=#{@api_key}"
        # @uri = URI(@url)
        # response = Net::HTTP.get(@uri)
        url = "https://financialmodelingprep.com/api/v3/quote/#{@ticker}?apikey=#{@api_key}"
        response = URI.open(url).read
        @stock = JSON.parse(response).first # Parse JSON and take the first element (because the response is an array)

        if @stock.nil?
          @error = "Hey! That Stock Symbol Doesn't Exist. Please Try Again."
        end
      rescue => e
        @error = "Error fetching stock data: #{e.message}"
      end
    end
  end

  def about
  end
end


=begin
class HomeController < ApplicationController
  def index
    @api = StockQuote::Stock.new(api_key: 'pk_16a849fd637243a79fff90fa4d42bc5d')

    if params[:ticker] == ""
      @nothing = "Hey! You Forgot To Enter A Symbol"
    elsif params[:ticker]
      @stock = StockQuote::Stock.quote(params[:ticker])
      if !@stock
        @error = "Hey! That Stock Symbol Doesn't Exist. Please Try Again."
      end

    end

  end

  def about
  end

end
=end
