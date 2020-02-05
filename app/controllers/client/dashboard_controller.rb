class Client
  class DashboardController < ApplicationController
    before_action :authenticate_client!

    def index; end
  end
end
