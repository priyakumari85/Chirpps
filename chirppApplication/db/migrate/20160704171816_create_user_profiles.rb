class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :first
      t.string :last
      t.string :email
      t.integer :phone, :limit => 10
      t.string :addline1
      t.string :addline2
      t.string :street
      t.string :city
      t.string :country
      t.string :pincode

      t.timestamps null: false
    end
  end
end
