# == Schema Information
#
# Table name: tickets
#
#  id              :integer          not null, primary key
#  subject         :string(255)
#  status          :string(255)
#  priority        :integer
#  start_date      :datetime
#  end_date        :datetime
#  due_date        :datetime
#  user_id         :integer
#  ticket_queue_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#  requestor_id    :integer
#  body            :text
#

class Ticket < ActiveRecord::Base

  validates :subject, presence: true
  validates :subject, length: { minimum: 2 }
  validates :subject, length: { maximum: 255 }

  validates :status, presence: true, inclusion: { in: %w(New Opened Ignored Resolved Held), message: "%{value} is not a valid status" }

  validates :priority, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 25 }
  validates :start_date, presence: true

  validate :no_end_date_without_start_date
  validate :start_date_must_precede_end_date

  validates :body, presence: true, length: { minimum: 2 }

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :ticket_queue_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :requestor_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :ticket_queue
  validates :ticket_queue, presence: true

  belongs_to :user
  validates :user, presence: true

  belongs_to :requestor, class_name: "User", foreign_key: "requestor_id"
  validates :requestor, presence: true

  has_many :ticket_observers
  has_many :users, :through => :ticket_observers

  private

  def no_end_date_without_start_date
    if end_date !=nil && start_date == nil
      errors.add(:end_date, "requires a start date")
    end
  end

  def start_date_must_precede_end_date
    if end_date != nil && start_date != nil && end_date < start_date
      errors.add(:end_date, "cannot be less than the start date")
    end
  end

end
