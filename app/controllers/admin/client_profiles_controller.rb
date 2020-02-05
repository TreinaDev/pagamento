  class Admin::ClientProfilesController < ApplicationController

    def new
      @client_profile = ClientProfile.new
    end

    def create
      @client = Client.new(params[:client][:email], password: 123456)
      @client.save!
      @client_profile = ClientProfile.new(params_client_profile)
      @client_profile.client.id = @client.id
      @client_profile.save!
    end

    private

    def params_client_profile
      params.require(:client_profile).permit(:name, :cnpj, :company_name, :manager, :address,
                                            :phone, )
    end
  end