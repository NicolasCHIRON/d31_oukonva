class User < ApplicationRecord
  after_create :welcome_send

  has_many :attendances, foreign_key: 'attendee_id', class_name: "Attendance"
  has_many :events, through: :attendances
  has_many :events, foreign_key: 'administrator_id', class_name: "Event"

  validates :description, presence:true
  validates :first_name, presence:true
  validates :last_name, presence:true

  def attendee?
    attendances.count > 0
  end

  def administrator?
    events.count > 0
  end
  
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
