class EventsController < ApplicationController
  before_action :require_user_logged_in, only: %i[create show update, destroy]
  before_action :require_correct_user, only: %i[create show update, destroy]


end
