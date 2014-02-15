class LeapStatsApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  helpers Sinatra::JSON

  get '/token' do
    user = User.create!
    json token: user.token
  end

  post '/location' do
    data = JSON.parse(request.body.read)
    user = User.where(token: data['token']).first
    if !user.nil? && user.update_position(data)
      status 204
    else
      status 400
      json error: 'bad request' # TODO: return proper error
    end
  end

  post '/' do
    data = JSON.parse(request.body.read)
    data[:position] = data.delete 'relativePosition'
    Bump.create(data)
    status 204
  end

  post '/position' do
  end
end
