class UserloginsController < ApplicationController

  def new
    @user_login = UserLogin.new 
  end

  def create
    @errors = Hash.new
    respond_to do |format|
        if (params[:username] != "" || params[:username] != "")
        	if @user = UserLogin.find_by_username(params[:username])
          	if @user.password === params[:password]
              redirect_success(format)
          	else
              redirect_error("password","Password didn't match with the database.",format)
          	end
          else
              redirect_error("user","user doesn't exists",format)
          end	
        else
           redirect_error("empty","Username or password can't be empty",format)
        end
    end
  end

  def logout
    session[:current_user_id] = ""
    redirect_to :controller=>"chirpps", :action => "show"
  end

  private
  def redirect_error(key,value,format)
     @errors.clear
     @errors[key] = value
     format.html { redirect_to :action => "new" }
     format.js { render :create_error }
  end

  def redirect_success(format)
     session[:current_user_id] = @user.user_profile_id
     format.html { redirect_to :controller=>"chirpps", :action => "index"}
     format.js
  end

end
