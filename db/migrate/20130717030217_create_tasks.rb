class CreateTasks < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.references :user
      t.string :title
      t.string :description
      t.boolean :completed
      t.timestamps
    end
    add_index :tasks, :id
    add_index :tasks, :user_id
    add_index :tasks, :completed
  end

  def down
    remove_index :tasks, :id
    remove_index :tasks, :user_id
    remove_index :tasks, :completed
    drop_table :tasks
  end
end
