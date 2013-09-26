# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  start_date :datetime
#  due_date   :datetime
#  end_date   :datetime
#  note       :text
#  ticket_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Task < ActiveRecord::Base

  validates :subject, presence: true
  validates :subject, length: { minimum: 5 }
  validates :subject, length: { maximum: 255 }

  validates :start_date, presence: true

  validates :note, presence: true
  validates :note, length: { minimum: 5 }

  validate :no_end_date_without_start_date
  validate :start_date_must_precede_end_date

  belongs_to :ticket
  validates :ticket, presence: true

  belongs_to :user
  validates :user, presence: true

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
