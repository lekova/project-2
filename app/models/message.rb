class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender_id, class_name: "User"

  validates :sender, presence: true
end
