# == Schema Information
#
# Table name: ticket_queues
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :string(255)
#  url            :string(255)
#  priority       :integer
#  default_due_in :integer
#  start_date     :date
#  end_date       :date
#  created_at     :datetime
#  updated_at     :datetime
#

class TicketQueue < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :url, presence: true
  validates :priority, presence: true
  validates :default_due_in, presence: true
  validates :start_date, presence: true

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
