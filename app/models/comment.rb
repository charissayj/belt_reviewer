class Comment < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :event, required: true

  validates :content, presence: true
end
