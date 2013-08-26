require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  should validate_presence_of(:subject)

  should validate_presence_of(:priority)
  should validate_numericality_of(:priority)
  should allow_value(1).for(:priority)
  should allow_value(25).for(:priority)
  should_not allow_value(0).for(:priority)
  should_not allow_value(26).for(:priority)
  should_not allow_value(1.5).for(:priority)

  should belong_to(:ticket_queue)
  should belong_to(:user)

end
