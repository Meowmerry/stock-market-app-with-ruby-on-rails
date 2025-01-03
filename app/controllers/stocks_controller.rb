
class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]
  # before_action :set_stock, only: [ :show, :edit, :update, :destroy ]
  before_action :correct_user, only: [ :edit, :update, :destroy ]
  before_action :authenticate_user!

  # GET /stocks or /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1 or /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)
    # Check if the user exists
    @user = User.find_by(id: @stock.user_id)
    if @user.nil?
      flash[:error] = "User must exist"
      render :new and return
    end


    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }
      else
        # Log validation errors
        Rails.logger.error @stock.errors.full_messages.join(", XXX ")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy!

    respond_to do |format|
      format.html { redirect_to stocks_path, status: :see_other, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @ticker = current_user.stocks.find_by(id: params[:id])
    redirect_to stocks_path, notice: "Not authorized to edit this stock" if @ticker.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.expect(stock: [ :ticker, :user_id ])
    end
end


=begin
require "open-uri"

class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]
  # before_action :set_stock, only: [ :show, :edit, :update, :destroy ]
  before_action :correct_user, only: [ :edit, :update, :destroy ]
  before_action :authenticate_user!

  # GET /stocks or /stocks.json
  def index
    @api_key = "TjBA95mM5eWMsdlGrByYgll9ye0IifR8"
    api_url = "https://financialmodelingprep.com/api/v3/stock/list?apikey=#{@api_key}"

    # Open the URL and parse the JSON response
    response = URI.open(api_url).read
    @stocks_data = JSON.parse(response).take(100)  # Limit to first 100 stocks
  end


  # GET /stocks/1 or /stocks/1.json
  def show
    @ticker = params[:ticker]
    @api_key = "TjBA95mM5eWMsdlGrByYgll9ye0IifR8"
    api_url = "https://financialmodelingprep.com/api/v3/quote/#{@ticker}?apikey=#{@api_key}"

    # Open the URL and parse the JSON response
    response = URI.open(api_url).read
    @stock_data = JSON.parse(response).first # Get the first result from the API response
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
    @stock = Stock.find_by(symbol: params[:symbol])
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)
    @user = User.find_by(id: @stock.user_id)
    if @user.nil?
      flash[:error] = "User must exist"
      render :new and return
    end

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }
      else
        Rails.logger.error @stock.errors.full_messages.join(", ")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy!

    respond_to do |format|
      format.html { redirect_to stocks_path, status: :see_other, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_stock
      @stock = Stock.find(params[:id])  # Corrected the typo
    end

    def stock_params
      params.require(:stock).permit(:ticker, :user_id)  # Fixed strong parameters
    end
end


=end
