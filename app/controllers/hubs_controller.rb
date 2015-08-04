class HubsController < ApplicationController
  def index
    @hubs = Hub.all
  end

  def new
    @hub = Hub.new
  end

  def create
    @hub = Hub.create(hub_params)
    redirect_to '/'
  end

  def show
  end

  def edit
    @hub = Hub.find(params[:id])
  end

  def update
    @hub = Hub.find(params[:id])
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
