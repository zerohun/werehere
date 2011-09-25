class HistoriesController < ApplicationController
  # GET /histories
  # GET /histories.json
  #
  before_filter :require_authenticate, :only => [:new, :edit, :create, :update]
  before_filter :find_history, :only => [:show , :edit, :update ,:destroy]
  def index
    @histories = History.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @histories }
    end
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
    @comments = @history.comments.find(:all, :limit => 5, :order =>  "created_at DESC") 
    @comment = @history.comments.build
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @history }
    end
  end

  # GET /histories/new
  # GET /histories/new.json
  def new
    @history = History.new
    @current_user = current_user
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @history }
      format.js {render :layout => false}
    end
  end

  # GET /histories/1/edit
  def edit
  end

  # POST /histories
  # POST /histories.json
  def create
    
    converted_channel_name = params[:history][:url].gsub(':',';').gsub('/','_')
    @history = History.find_by_url(converted_channel_name)
    if @history.blank?
      @history = History.new(params[:history])
      @history.url = converted_channel_name
      @current_user = current_user
      @history.users << @current_user
      respond_to do |format|
        if @history.save
          @current_user.histories.last.users.delete @current_user if  @current_user.histories.present?
          @current_user.histories << @history
          @current_user.save
          format.html { redirect_to @history, notice: 'History was successfully created.' }
          format.json { render json: @history, status: :created, location: @history }
        else
          format.html { render action: "new" }
          format.json { render json: @history.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to @history
    end
  end

  # PUT /histories/1
  # PUT /histories/1.json
  def update

    respond_to do |format|
      if @history.update_attributes(params[:history])
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history.destroy

    respond_to do |format|
      format.html { redirect_to histories_url }
      format.json { head :ok }
    end
  end

  def destroyall
    History.destroy_all
    respond_to do |format|
      format.html {redirect_to histories_url }
    end
  end


  private
  def find_history
    @history = History.find(params[:id])
  end
end
