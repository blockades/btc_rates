require 'openssl'
require 'date'
require 'open-uri'
require 'json'
require 'yaml'

keys = YAML.load_file('keys.yaml')
timestamp = Time.now.to_i
payload = timestamp.to_s + "." + keys['public_key']
hex_hash = OpenSSL::HMAC.hexdigest('sha256', keys['secret_key'], payload)
signature = payload + '.' + hex_hash

ticker_url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCEUR'
response = open(ticker_url, 'X-Signature' => signature).read
puts JSON.parse(response)['averages']['week']


# since_date = Date.new(2018,3,26).to_time.to_i
#ticker_url = 'https://apiv2.bitcoinaverage.com/indices/global/history/BTCUSD?since=' + since_date.to_s
#puts ticker_url
#response = open(ticker_url, 'X-Signature' => signature).read
#puts response
