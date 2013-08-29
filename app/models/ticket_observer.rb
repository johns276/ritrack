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
  belongs_to :user
  belongs_to :ticket
end
