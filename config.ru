require "qless"
require "qless/server"

puts ENV

client = Qless::Client.new(
  :host => ENV['QLESS_REDIS_PORT_6379_TCP_ADDR'],
  :port => ENV['QLESS_REDIS_PORT_6379_TCP_PORT']
)

app = Rack::Builder.new do
  map('/qless') { run Qless::Server.new(client) }
end
run app
