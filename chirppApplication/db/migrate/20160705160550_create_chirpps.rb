class CreateChirpps < ActiveRecord::Migration
  def change
    create_table :chirpps do |t|
      t.text :content
      t.integer :user_profile_id

      t.timestamps null: false
    end
  end
end
