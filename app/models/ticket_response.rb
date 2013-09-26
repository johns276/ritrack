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
  validates :body, length: { minimum: 5 }

  validates :response_sent, presence: true

  belongs_to :ticket
  validates :ticket, presence: true

  validate :no_response_before_ticket

  private

  def no_response_before_ticket
    if ticket_id != nil && response_sent != nil
      ticket = Ticket.find(ticket_id)
      if ticket.start_date > response_sent
        errors.add(:response_sent, "response sent date cannot be fore ticket create date")
      end
    end
  end

end
