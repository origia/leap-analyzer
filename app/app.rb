class LeapStatsApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  post '/' do
    data = JSON.parse(request.body.read)
    data[:position] = data.delete 'relativePosition'
    Bump.create(data)
    status 204
  end
end
