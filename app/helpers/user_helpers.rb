helpers do

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    session[:user_id] != nil
  end

  def authorized?(id)
    session[:user_id] == id
  end


  def subscribed?(user_id, channel_id)
    if Subscription.find_by(user_id: user_id, channel_id: channel_id)
      true
    end
  end
end