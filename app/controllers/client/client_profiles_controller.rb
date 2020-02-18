class Client
  class ClientProfilesController < ApplicationController
    before_action :authenticate_client!

    def show
      @profile = ClientProfile.find(params[:id])
    end
  end
end