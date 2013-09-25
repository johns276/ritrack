# == Schema Information
#
# Table name: emails
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  start_date :date
#  end_date   :date
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Email < ActiveRecord::Base

  before_save { self.address = address.downcase }

  validates :address, presence: true,
            format: {with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i},
            uniqueness: { case_sensitive: false }

  validates :start_date, presence: true

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate  :no_end_date_without_start_date
  validate  :start_date_must_precede_end_date

  belongs_to :user, validate: true
  # validates :user, presence: true

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
