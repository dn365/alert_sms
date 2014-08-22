require "sinatra"
require "yaml"
require File.expand_path("../sms", __FILE__)


conf_file = File.expand_path("../conf/config.yml", __FILE__)
config = YAML.load_file(conf_file)


sms = Sms.new(config["default"])

set :port, 8000


get "/" do
  return "API v 1.0"
end

post "/send_sms" do
  value = params[:sms]
  return "Not found value." unless value
  "Send success."
end
