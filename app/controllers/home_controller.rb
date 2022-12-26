class HomeController < ApplicationController

  def index
    @currency_codes = Currency.all.pluck(:country_code).sort
    
    if params[:amount]
      @amount = params[:amount].to_f.round(2)
      @from = params[:from]
      @to = params[:to]
      @converted_amount, @rate_of_conversion = ExchangeApi::Converter.new.convert(@amount, @from, @to)
    end
  end
end