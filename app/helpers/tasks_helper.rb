module TasksHelper
  require 'date'
  LIMIT_STATUS = [[I18n.t(:state_waiting),0],[I18n.t(:state_working),1],[I18n.t(:state_completed),2],[I18n.t(:state_pending),3]]
  def today
    Date.today
  end

  def view_limit_status(status_id)
    LIMIT_STATUS.find { |value,id| id == status_id.to_i }.first
  end
end
