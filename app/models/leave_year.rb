class LeaveYear < ActiveRecord::Base
  belongs_to :user, required: true

  validates :starts_on, :entitlement, :carried_forward, presence: true
end