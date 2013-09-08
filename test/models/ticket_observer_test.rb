require 'test_helper'

class TicketObserverTest < ActiveSupport::TestCase

  should validate_presence_of :user_id
  should validate_presence_of :ticket_id
  should validate_presence_of :start_date

  context 'A given ticket_observer' do

    setup do
      @ticket_observer = TicketObserver.first()
    end

    should 'retrieve its ticket' do
      ticket = @ticket_observer.ticket
      assert ticket.nil? == false
    end

    should 'retrieve its user' do
      user = @ticket_observer.user
      assert user.nil? == false
    end

  end

end
