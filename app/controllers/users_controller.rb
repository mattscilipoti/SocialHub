class UsersController < ApplicationController
  skip_before_action :authenticate

  def sign_up
  end

  def sign_up!
    user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password_digest: BCrypt::Password.create(params[:password])
    )
    if params[:password_confirmation] != params[:password]
      message = "Your passwords don't match!"
    elsif user.save
      message = "Your account has been created!"
    else
      message = "Your account couldn't be created. Did you enter a unique username and password?"
    end
    flash[:notice] = message
    redirect_to action: :sign_up
  end

  def sign_in
  end

  def sign_in!
    @user = User.find_by(email: params[:email])
    if !@user
      message = "This user doesn't exist!"
    elsif !BCrypt::Password.new( @user.password_digest).is_password?(params[:password])
      message = "Your password's wrong!"
    else
      message = "You're signed in, #{@user.first_name}!"
      cookies[:email] = {
        value: @user.email,
        expires: 100.years.from_now
      }
      session[:user] = @user
    end
    flash[:notice] = message
    redirect_to action: :sign_in
  end

  def sign_out
    reset_session
    redirect_to "/"
  end

end
