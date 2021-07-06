module TasksHelper
  require 'date'
  LIMIT_STATUS = [["未着手",0],["着手中",1],["完了",2],["凍結",3]]

  def today
    Date.today
  end

  def view_limit_status(status_id)
    LIMIT_STATUS.find { |value,id| id == status_id.to_i }.first
  end
end
