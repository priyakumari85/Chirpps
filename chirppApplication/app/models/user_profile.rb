class UserProfile < ActiveRecord::Base
	validates_presence_of :first, :last, :email
	validates_uniqueness_of :email
	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
	validates_format_of :phone, :with => /[0-9]{10}/ , :allow_nil => true

	has_one :user_login
end
