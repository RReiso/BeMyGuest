class ApplicationController < ActionController::Base
  include SessionsHelper
  include UsersHelper
   add_flash_types :success, :warning, :danger, :info


end
