class PusherController < ApplicationController
  protect_from_forgery :except => :auth # stop rails CSRF protection for this action
  def auth
    if current_user.present?
      channel_name = params[:channel_name]
      channel = Pusher[channel_name]
      new_user = current_user 
      response = channel.authenticate(params[:socket_id], {
        :user_id => session[:user_id],
        :user_info => {
          :email => new_user.email
        }
      })
      render :json => response
    else
      render :text => "Not authorized", :status => '403'
    end
  end

end
