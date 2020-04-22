module TasksHelper
  require 'date'
  LIMIT_TASK_STATUS = [[I18n.t("state.waiting"),0],[I18n.t("state.working"),1],[I18n.t("state.completed"),2],[I18n.t("state.pending"),3]]
  PRIORITY_STATUS = [[I18n.t("priority.high"),0],[I18n.t("priority.medium"),1],[I18n.t("priority.low"),2]]

  def today
    Date.today
  end

  def view_task_status(status_id)
    LIMIT_TASK_STATUS.find { |value,id| id == status_id.to_i }.first
  end

  def view_priority_status(priority_id)
    PRIORITY_STATUS.find { |value,id| id == priority_id.to_i }.first
  end

end
