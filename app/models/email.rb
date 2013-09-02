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

  validates :address, presence: true, format: {with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i}
  validate :start_date, presence: true
  belongs_to :user
end
