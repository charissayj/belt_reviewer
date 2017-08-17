class User < ActiveRecord::Base
	has_secure_password

	has_many :events, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :meetups, dependent: :destroy
	has_many :joined_events, through: :meetups, source: :event

	validates :first_name, :last_name, :location, :state, presence: true
	validates :password, presence: { on: :create }, length: { minimum: 2, allow_blank: true }
	validates_presence_of :password_confirmation, if: :password_digest_changed?
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :email, presence: true, uniqueness: { case_sensitve: false }, format: { with: EMAIL_REGEX }
end
