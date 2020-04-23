class RemoveTasksColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :users_id, :integer
  end
end
