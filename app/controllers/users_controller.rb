class UsersController < ApplicationController

  before_filter :find_user, :only => [:show]

  def index
    @users = User.all
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to "session/new", :notice => "Signed up!"
    else
      render "new"
    end
  end


  def show
    @histories = @user.histories

  end

  private
  def find_user 
    @user = User.find(params[:id])
  end

end
