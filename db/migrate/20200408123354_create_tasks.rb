class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.string :status
      t.date :limit
      t.integer :user_id
      t.timestamps
    end
  end
end
