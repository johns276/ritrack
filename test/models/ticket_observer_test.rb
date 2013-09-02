require 'test_helper'

class TicketObserverTest < ActiveSupport::TestCase

  should validate_presence_of :user_id
  should validate_presence_of :ticket_id
  should validate_presence_of :start_date

end
