class UsersController < ApplicationController
  skip_before_action :authenticate

  def index
    @users = User.all
    @randomUser = Random.new.rand(@users.first.id..@users.length)
    redirect_to "/users/#{@randomUser}"
  end

  def show
    @user = User.find(params[:id])
    @hubs = @user.hubs
  end

  def edit
    @user = User.find(session[:user]["id"])
  end

  def update
    @user = User.find(session[:user]["id"])
    @user.update(user_params)

    reset_session
    redirect_to "/"
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    reset_session
    redirect_to "/"
  end

  def find
    @users = User.all
  end

  def sign_up
  end

  def sign_up!
    user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      photo_url: params[:photo_url],
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
    redirect_to '/sign_in'
  end

  def sign_in
  end

  def sign_in!
    @user = User.find_by(email: params[:email])

    if !@user
      message = "This user doesn't exist!"
    elsif !BCrypt::Password.new( @user.password_digest ).is_password?(params[:password])
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
    redirect_to "/"
  end

  def sign_out
    reset_session
    redirect_to "/"
  end

private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :photo_url, :password)
  end
end
