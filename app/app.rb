class LeapStatsApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  post '/' do
    puts JSON.parse(request.body.read)
    status 204
  end
end
