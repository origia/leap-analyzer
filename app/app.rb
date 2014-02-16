class LeapStatsApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  helpers Sinatra::JSON

  before /^(?!\/(token|$))/ do
    @data = JSON.parse(request.body.read) rescue {}
    @user = User.where(token: @data['token']).first
    if @user.nil?
      json error: 'not authenticated'
      halt 403
    end
  end

  get '/' do
    user = User.first
    @bumps = user.bumps.limit(50)
    slim :index
  end

  get '/token' do
    user = User.create!
    json token: user.token
  end

  post '/register' do
    @user.device_token = @data['device_token']
    @user.save
    status 204
  end

  post '/location' do
    if @user.update_position(@data)
      @user.notify_nearby
      status 204
    else
      status 422
      json error: 'bad location'
    end
  end

  post '/bump' do
    @data[:position] = @data.delete 'relativePosition'
    @user.bumps.create(@data.merge(location: @user.location))
    PushManager.push(@user.device_token, @data)
    status 204
  end

end
