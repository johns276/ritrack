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

  should validate_presence_of(:start_date)

  should belong_to(:ticket_queue)
  should belong_to(:user)

  context 'A given ticket' do

    setup do
      @ticket = Ticket.first()
    end

    should 'retrieve all observers, if there are any' do
      observers = @ticket.ticket_observers
      assert observers.nil? == false
      assert observers.size > 0
      users = @ticket.users
      user = @ticket.user
      assert users.size == 2
      assert user.nil? != 0
    end



  end # a given ticket

end
