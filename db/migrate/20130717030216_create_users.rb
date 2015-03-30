class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :status
      t.string :password_digest
      t.timestamps
    end
    add_index :users, :id
    add_index :users, :email
    add_index :users, :status
    add_index :users, :password_digest
  end

  def down
    remove_index :users, :id
    remove_index :users, :email
    remove_index :users, :stats
    remove_index :users, :password_digest
    drop_table :users
  end
end
