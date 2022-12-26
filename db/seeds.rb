require 'net/http'
require 'json'

api_key = Rails.application.credentials.dig(:exchange, :api_key)

url = "https://v6.exchangerate-api.com/v6/#{api_key}/latest/USD"
uri = URI(url)
response = Net::HTTP.get(uri)
response_obj = JSON.parse(response)

currency_rates = response_obj['conversion_rates'].keys
currency_codes = currency_rates.reduce([]) { |ary, code| ary.push({country_code: code}) }

Currency.destroy_all

Currency.create!(currency_codes)

p "Created #{Currency.count} Currency country codes."

