require File.expand_path("../jar/ojdbc6.jar", __FILE__)
require "sequel"

class Sms

  def initialize options={}
    options["pool"] ||= 10
    options["port"] ||= 1521
    options["pool_timeout"] ||= 10
    options["login_timeout"] ||= 5
    options["logger"] ||= File.expand_path("../logs/database.log", __FILE__)

    return "Database Config File Error." if options["adapter"].nil? or options["host"].nil? or options["database"].nil? or options["username"].nil? or options["password"].nil?
    url = nil
    case options["adapter"]
    when "oracle"
      url = "jdbc:oracle:thin:#{options["username"]}/#{options["password"]}@#{options["host"]}:#{options["port"]}:#{options["database"]}"
    end
    if url
      DB = Sequel.connect(url,:max_connections => options["pool"],:logger => options["logger"], :pool_timeout => options["pool_timeout"], :login_timeout=> options["login_timeout"])
    end
  end


  def insert(table_name,values={})
    items = DB[:"#{table_name}"]
    items.insert(values)
  end

  def select(sql)
    DB["#{sql}"]
  end

end
