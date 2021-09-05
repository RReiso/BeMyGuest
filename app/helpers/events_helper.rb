module EventsHelper
  
  def new_event
    @new_event = Event.new
  end

  def require_correct_event
    @event =
      if params[:controller] == 'events'
        Event.find_by(id: params[:id])
      else
        Event.find_by(id: params[:event_id])
      end
    
    redirect_to(current_user) unless (current_user?(@user) && event_exists?(@event))
  end

  private

  def event_exists?(event)
    !event.blank?
  end
end
