class UserLogin < ActiveRecord::Base 
	validates_presence_of :username, :password
	validates_uniqueness_of :username
    validates_format_of :password, :with => /^.*(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^]).*$/, :multiline => true, message: "must be at least 6 characters and include one number and one uppercase and lowercase letter and special characters @#$%^."

    belongs_to :user_profile
end
