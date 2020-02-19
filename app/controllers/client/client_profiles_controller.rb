class Client
  class ClientProfilesController < ApplicationController
    before_action :authenticate_client!

    def show
      @client_profile = ClientProfile.find(params[:id])
    end

    def edit
      @client_profile = ClientProfile.find(params[:id])
    end

    def update
      @client_profile = ClientProfile.find(params[:id])
      if @client_profile.update(params_client_profile)
        redirect_to client_client_profile_path(@client_profile),
                    notice: t('.success')
      else
        render :edit
      end
    end

    private

    def params_client_profile
      params.require(:client_profile).permit(:manager, :address, :phone)
    end
  end
end
