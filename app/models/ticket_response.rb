# == Schema Information
#
# Table name: ticket_responses
#
#  id            :integer          not null, primary key
#  body          :text
#  response_sent :datetime
#  ticket_id     :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class TicketResponse < ActiveRecord::Base

  validates :body, presence: true
  validates :response_sent, presence: true
  belongs_to :ticket

end
