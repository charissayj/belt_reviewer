class Event < ActiveRecord::Base
	belongs_to :user, required: true
	has_many :comments, dependent: :destroy
	has_many :meetups, dependent: :destroy
  	has_many :users, through: :meetups, source: :user
  	
	validates :name, :date, :location, :state, presence: true

	validates :date, timeliness: { on_or_after: lambda { Date.current }, type: :date }
end
