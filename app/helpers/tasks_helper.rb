module TasksHelper
  require 'date'
  LIMIT_STATUS = [[I18n.t(:state_waiting),0],[I18n.t(:state_working),1],[I18n.t(:state_completed),2],[I18n.t(:state_pending),3]]
  PRIORITY_STATUS = [["高",0],["中",1],["低",2]]

  def today
    Date.today
  end

  def view_limit_status(status_id)
    LIMIT_STATUS.find { |value,id| id == status_id.to_i }.first
  end
  def view_priority_status(priority_id)
    PRIORITY_STATUS.find { |value,id| id == priority_id.to_i }.first
  end
end
