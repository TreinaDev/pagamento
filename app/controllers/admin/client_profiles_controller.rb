class Admin
  class ClientProfilesController < ApplicationController
    def new
      @client_profile = ClientProfile.new
    end

    def create
      @client = Client.new(email: params[:client_profile][:email],
                           password: 123_456)
      @client.save!
      @client_profile = ClientProfile.new(params_client_profile)
      @client_profile.client_id = @client.id
      @client_profile.save!
      redirect_to admin_client_profile_path(@client_profile),
                  notice: t('.success')
    end

    def show
      @client_profile = ClientProfile.find(params[:id])
    end

    private

    def params_client_profile
      params.require(:client_profile).permit(:name, :cnpj, :company_name,
                                             :manager, :address, :phone, :email)
    end
  end
end
