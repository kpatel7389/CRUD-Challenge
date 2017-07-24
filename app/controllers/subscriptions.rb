post '/subscriptions' do
  @user_id = params[:user_id]
  @channel_id = params[:channel_id]
  @subscription = Subscription.create!(user_id: @user_id, channel_id: @channel_id)
  redirect "/users/#{@user_id}"
end

delete '/subscriptions' do
  @user = User.find_by(id: params[:user_id])
  @subscription = Subscription.find_by(user_id: params[:user_id], channel_id: params[:channel_id])
  @subscription.destroy
  redirect "/users/#{@user.id}"
end
