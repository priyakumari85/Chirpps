class AddUserProfileToUserLogin < ActiveRecord::Migration
  def change
    add_column :user_logins, :user_profile_id, :integer
  end
end
