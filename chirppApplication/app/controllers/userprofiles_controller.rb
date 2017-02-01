class UserprofilesController < ApplicationController
  
  def new
    @user = UserProfile.new 
  end

  def create
    @user = UserProfile.new(users_params)
    @user_login = UserLogin.new
    
    respond_to do |format|
      if @user.save
		    @user_login.username = params[:username]
		    @user_login.password = params[:password]
		    @user_login.user_profile_id = UserProfile.last.id
		    if @user_login.save
            session[:current_user_id] = UserProfile.last.id
		        format.js
	       else
           UserProfile.last.destroy
	       	 format.html { redirect_to :action => "new" }
         	 format.js { render :create_error }
	       end
      else
         format.html { redirect_to :action => "new" }
         format.js { render :create_error }
      end
     end
  end

  def edit
    @user = UserProfile.find(params[:id])
    @username = @user.user_login.username
    @password = @user.user_login.password
    @other_chirpps = Chirpp.where("user_profile_id != ?", params[:id])
  end  

  def update
    @user = UserProfile.find(params[:id])
    @user_login = @user.user_login

    respond_to do |format|
      if @user.update(users_params)
          @user_login.username = params[:username]
          @user_login.password = params[:password]
          if @user_login.save
              session[:current_user_id] = params[:id]
              format.js
          else
             format.js { render :create_error }
          end
      else
          format.js { render :create_error }
      end
    end
  end  

 private
  def users_params
    params.require(:user_profile).permit(:first, :last, :email, :phone, :addline1, :addline2, :street, :city, :country, :pincode)
  end

end
