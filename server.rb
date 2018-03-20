require 'webrick'
require 'webrick/log'
require 'fcm'
require 'dotenv/load'

params = {
  Port: 8888,
  DocumentRoot: File.expand_path(File.dirname(__FILE__))
}

FCM_SEVER_KEY = ENV['SERVER_KEY']

fcm = FCM.new(FCM_SEVER_KEY)

logger = WEBrick::BasicLog.new

server = WEBrick::HTTPServer.new(params)
trap('INT') { server.shutdown }

server.mount_proc '/send_message' do |req, _res|
  time = Time.now.strftime('%Y%m%d%H%M&S')
  options = {
    data: {
      url: 'https://google.com',
      message: 'Hello Firebase Cloud Messaging!',
      tag: "message:#{time}"
    }
  }

  responce = fcm.send([req.body], options)
  logger.info(responce)
end

server.start
