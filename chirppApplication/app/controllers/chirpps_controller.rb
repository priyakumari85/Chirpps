class ChirppsController < ApplicationController

  def index
    @chirp = Chirpp.new
    if session[:current_user_id] != ""
    	@chirpps = Chirpp.where("user_profile_id = ?", session[:current_user_id])
      @other_chirpps = Chirpp.where("user_profile_id != ?", session[:current_user_id])
    else
      @chirpps = Chirpp.all
      render :show
    end   
  end	


  def create
    @chirp = Chirpp.new
    @chirp.content = params[:chirpp][:content]
    @chirp.user_profile_id = session[:current_user_id]
    respond_to do |format|
      if @chirp.save
        format.js
      else
        format.js { render :create_error }
      end
    end
  end

  def show
    @chirpps = Chirpp.all
  end

  def edit
    @chirp=Chirpp.find(params[:id])
    respond_to do |format|
      format.js { render :inline_edit_row }
    end
  end

  def update
    @chirp=Chirpp.find(params[:id])
    @chirp.content = params[:chirpp][:content]
    @chirp.user_profile_id = session[:current_user_id]
    respond_to do |format|
      if @chirp.save
        format.html { redirect_to :controller=>"chirpps", :action => "index"}
      else
        format.js { render :edit_error }
      end
    end
  end

  def destroy
    @chirp = Chirpp.find(params[:id])
    if @chirp
       respond_to do |format|
         @chirp.destroy
         format.html { redirect_to :controller=>"chirpps", :action => "index"}
      end
    end
  end

end
