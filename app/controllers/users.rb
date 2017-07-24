get '/users' do
  erb :index
end

get '/users/new' do
  erb :'users/new'
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @errors = @user.errors.full_messages
    erb :'users/new'
  end
end

get '/login' do
  erb :'users/login'
end

post '/login' do
  @user = User.authenticate(params[:email], params[:password])

  if @user
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @errors = ["Invalid Email and/or Password"]
    erb :'users/login'
  end
end

get '/users/:id' do
  @user = User.find_by(id: params[:id])
  @channels = @user.channels
  @price = @channels.inject(0) { |sum, channel| sum + channel.price_per_month }
  if authorized?(@user.id)
    erb :'users/show'
  else
    redirect '/'
  end
end

delete '/users/logout' do
  session[:user_id] = nil
  redirect "/"
end