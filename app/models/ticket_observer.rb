# == Schema Information
#
# Table name: ticket_observers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  ticket_id  :integer
#  start_date :date
#  end_date   :date
#  created_at :datetime
#  updated_at :datetime
#

class TicketObserver < ActiveRecord::Base

  validates :user_id, presence: true
  validates :ticket_id, presence: true
  validates :start_date, presence: true

  validate  :no_end_date_without_start_date
  validate  :start_date_must_precede_end_date

  belongs_to :user
  belongs_to :ticket

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
