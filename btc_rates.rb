require 'openssl'
require 'date'
require 'open-uri'
require 'json'
require 'yaml'
require 'slim'
require 'sinatra'

def btc_average_api(url)

  # grab data from bitcoinaverage api

  #keys = YAML.load_file('keys.yaml')
  
  keys['public_key'] = ENV['PUBLIC_BCA']
  keys['secret_key'] = ENV['SECRET_BCA']


  timestamp = Time.now.to_i
  payload = timestamp.to_s + "." + keys['public_key']
  hex_hash = OpenSSL::HMAC.hexdigest('sha256', keys['secret_key'], payload)
  signature = payload + '.' + hex_hash

  response = open(url, 'X-Signature' => signature).read
  return JSON.parse(response)

end

def list_exchanges

  # list exchanges which list BTC price in euros. 

  exchanges = []
  btc_average_api('https://apiv2.bitcoinaverage.com/symbols/exchanges/ticker')['exchanges'].each do | key, value |
    if value['symbols'].include?('BTCEUR')
      exchanges.push(value['display_name'])
    end
  end
  return exchanges
end


def week_average(currency)

  # give weekly btc/eur average, convert to float

  return btc_average_api("https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC#{currency}")['averages']['week'].to_f

end

def historical_average

  # this gives us hourly rates, highs, lows and averages each hour over the last month
  # could potentially use this to give us something better than 'weekly average'

  return btc_average_api('https://apiv2.bitcoinaverage.com/indices/global/history/BTCEUR?period=monthly&?format=json')

end

get '/' do 
  @today = Date.today
  @payroll = YAML.load_file('payroll.yaml')
  @week_av = week_average("EUR")
  
  @currencies = {}
  ["NZD","AUD","GBP","USD"].each do |curr|
    @currencies[curr] = week_average(curr)
  end 

  @exchanges = list_exchanges
  slim :index
end

