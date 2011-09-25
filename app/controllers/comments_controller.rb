class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
  before_filter :require_authenticate
  before_filter :find_history, :only => [:new, :create, :index]
  before_filter :find_comment_in_history, :except => [:new, :create, :index]



  def index
    @comments = @history.comments.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = @history.comments.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @history.comments.build(params[:comment].merge!(:user => current_user))

    respond_to do |format|
      if @comment.save
        Pusher["presence-#{@history.url}"].trigger('message', [@comment.user.email, @comment.mention])
        format.html { redirect_to history_comment_path(@history,@comment), notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
    current_user.comments << @comment
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :ok }
    end
  end
  private 
  def find_history
    @history = History.find(params[:history_id])
  end
  def find_comment_in_history
    find_history
    @comment = @history.comments.find(params[:id])
  end
end
