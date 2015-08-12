class HubsController < ApplicationController
  def index
    @hubs = current_user.hubs
  end

  def new
    @hub = Hub.new
  end

  def create
    # mms: inline this variable - no need for @user
    @user = current_user
    # mms: used local var - no view for :create
    @hub = @user.hubs.create!(hub_params)
    # mms: recommend using named route instead of string.
    redirect_to '/'
  end

  def show
    # mms: no @hub instantiation?  If you don't use :show, remove it.
  end

  def edit
    @hub = Hub.find(params[:id])
  end

  def update
    @hub = Hub.find(params[:id])
    # what happens if `hub.update` fails?  Either use if/then or raise the error.
    @hub.update(hub_params)

    redirect_to '/'
  end

  def destroy
    @hub = Hub.find(params[:id])
    @hub.destroy

    redirect_to '/'
  end

  private

  def hub_params
    params.require(:hub).permit(:acc_link, :photo_url, :title, :description)
  end
end
