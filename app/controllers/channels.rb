get '/channels' do
  @channels = Channel.all
  erb :'channels/index'
end

get '/channels/:id' do
  if logged_in?
    @user = User.find_by(id: session[:user_id])
  end
  @channel = Channel.find(params[:id])
  @subscribers = @channel.subscribers
  erb :'channels/show'
end
