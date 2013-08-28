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
#

class Ticket < ActiveRecord::Base

  validates :subject, presence: true
  validates :status, presence: true, inclusion: { in: %w(New Opened Ignored Resolved Held), message: "%{value} is not a valid size" }
  validates :priority, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 25 }
  validates :start_date, presence: true
  belongs_to :ticket_queue
  belongs_to :user
  belongs_to :requestor, class_name: "User", foreign_key: "requestor_id"

end
