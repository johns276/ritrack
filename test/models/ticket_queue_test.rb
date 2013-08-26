require 'test_helper'

class TicketQueueTest < ActiveSupport::TestCase

  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  should validate_presence_of(:description)
  should validate_presence_of(:url)
  should validate_presence_of(:priority)
  should validate_presence_of(:default_due_in)
  should validate_presence_of(:start_date)

end
