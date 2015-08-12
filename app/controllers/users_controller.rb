class UsersController < ApplicationController
  skip_before_action :authenticate

  def index
    # mms: prefer getting random user from db, rather return all and then select one
    # mms: why @users (as instance var)?
    @users = User.all
    @randomUser = @users.sample
    redirect_to user_path(@randomUser)
  end

  def show
    @user = User.find(params[:id])
    @hubs = @user.hubs
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    # mms: reset session on every update?  Is there a specific change that requires this?
    reset_session
    redirect_to "/"
  end

  def destroy
    @user = current_user
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
    # mms: recommend changing the form so you can utilize user_params (string params here).
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

    # mms: recommend extracting a `authenticate` method.
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
      session[:user_id] = @user.id
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
