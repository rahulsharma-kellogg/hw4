class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({"email" => params["email"]})

    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome!"
        redirect_to "/"
      else
        flash["notice"] = "Some information is incorrect. Please try again."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Some information is incorrect. Please try again."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "You are now logged out."
    redirect_to "/login"
  end
end
  