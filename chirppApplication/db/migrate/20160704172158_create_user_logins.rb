class CreateUserLogins < ActiveRecord::Migration
  def change
    create_table :user_logins do |t|
      t.string :username
      t.string :password

      t.timestamps null: false
    end
  end
end
