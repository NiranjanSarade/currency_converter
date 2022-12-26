require 'net/http'
require 'json'

module ExchangeApi
  class Converter
    API_ENDPOINT = "https://v6.exchangerate-api.com/v6"

    def initialize
      @api_key = Rails.application.credentials.dig(:exchange, :api_key)
      @base_url = "#{API_ENDPOINT}/#{@api_key}/latest"
    end

    def convert(amount, from_currency, to_currency)
      if from_currency && to_currency
        conversion_rate = currency_rates(from_currency, to_currency)
        converted_amount = (amount * conversion_rate).round(2)
      end
      return [converted_amount,conversion_rate]

    end

    private

      def currency_rates(from, to)
        uri = URI("#{@base_url}/#{from}")
        response = Net::HTTP.get(uri)
        response_obj = JSON.parse(response)

        response_obj['conversion_rates']["#{to}"]
      end
  end

end