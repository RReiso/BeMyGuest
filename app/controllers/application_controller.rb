class ApplicationController < ActionController::Base
  include SessionsHelper
   add_flash_types :success, :warning, :danger, :info


end
