class Admin
  class ClientProfilesController < ApplicationController
    before_action :authenticate_admin!, only: %i[new create]

    def new
      @client_profile = ClientProfile.new
      @client_profile.build_client
    end

    def create
      @client_profile = ClientProfile.new(params_client_profile)
      @client_profile.client.password = 'Admin@123'

      if @client_profile.save
        redirect_to admin_client_profile_path(@client_profile),
                    notice: t('.success')
      else
        render :new
      end
    end

    def show
      @client_profile = ClientProfile.find(params[:id])
    end

    private

    def params_client_profile
      params.require(:client_profile).permit(:name, :cnpj, :company_name,
                                             :manager, :address, :phone,
                                             client_attributes: [:email])
    end
  end
end
