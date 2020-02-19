class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    return root_path if current_admin

    stored_location_for(resource) || payment_methods_path
  end
end
