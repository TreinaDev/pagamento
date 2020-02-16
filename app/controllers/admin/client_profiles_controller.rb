class Admin
  class ClientProfilesController < ApplicationController
    def index
      @client_profiles = ClientProfile.all
    end

    def new
      @client_profile = ClientProfile.new
      @client_profile.build_client
    end

    def create
      @client_profile = ClientProfile.new(params_client_profile)
      @client_profile.client.password = 'Admin@123'

      @client_profile.save!
      flash[:success] = t('.success')
      redirect_to admin_client_profile_path(@client_profile)
    end

    def edit
      @client_profile = ClientProfile.find(params[:id])
    end

    def update
      @client_profile = ClientProfile.find(params[:id])
      if @client_profile.update(params.require(:client_profile)
                    .permit(:name, :cnpj, :company_name, :manager,
                            :address, :phone))
        flash[:success] = t('.success')
        redirect_to admin_client_profile_path(@client_profile)
      else
        render edit_admin_client_profile_path(@client_profile)
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
