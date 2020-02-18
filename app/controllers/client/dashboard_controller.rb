class Client
  class DashboardController < ApplicationController
    before_action :authenticate_client!

    def index
      @orders = current_client.client_profile.orders
    end
  end
end
