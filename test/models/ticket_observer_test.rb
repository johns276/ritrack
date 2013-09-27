require 'test_helper'

class TicketObserverTest < ActiveSupport::TestCase

  should validate_presence_of :user_id
  should validate_presence_of :ticket_id
  should validate_presence_of :start_date

  context 'A given ticket_observer' do

    setup do
      @ticket_observer = ticket_observers(:one)
    end

    should 'retrieve its ticket' do
      ticket = @ticket_observer.ticket
      assert ticket.nil? == false
    end

    should 'retrieve its user' do
      user = @ticket_observer.user
      assert user.nil? == false
    end

    should 'require a user' do
      @ticket_observer.user = nil
      @ticket_observer.valid?
      @ticket_observer.errors[:user].any? == true
    end

    should 'require a ticket' do
      @ticket_observer.ticket = nil
      @ticket_observer.valid?
      @ticket_observer.errors[:ticket].any? == true
    end

    should 'require a start date if an end date is present' do
      @ticket_observer.start_date = nil
      @ticket_observer.end_date = Date.today()
      @ticket_observer.valid?
      assert @ticket_observer.errors[:end_date].any? == true
      assert_equal @ticket_observer.errors[:end_date].join(';'), "requires a start date"
    end

    should 'require an end date on or after start date' do
      @ticket_observer.start_date = Date.today
      @ticket_observer.end_date = Date.today - 1.day
      @ticket_observer.valid?
      assert @ticket_observer.errors[:end_date].any? == true
      assert_equal @ticket_observer.errors[:end_date].join(';'), "cannot be less than the start date"
    end

  end # a given ticket_observer

  context 'A new ticket_observer' do

    setup do
      @ticket_observer = TicketObserver.new
    end

    should 'require a user' do
      @ticket_observer.valid?
      @ticket_observer.errors[:user].any? == true
      @ticket_observer.user = users(:one)
      @ticket_observer.valid?
      @ticket_observer.errors[:user].any? == false
    end

    should 'require a ticket' do
      @ticket_observer.valid?
      @ticket_observer.errors[:ticket].any? == true
      @ticket_observer.ticket = tickets(:one)
      @ticket_observer.valid?
      @ticket_observer.errors[:ticket].any? == true
    end

    should 'require a start date if an end date is present' do
      @ticket_observer.end_date = Date.today()
      @ticket_observer.valid?
      assert @ticket_observer.errors[:end_date].any? == true
      assert_equal @ticket_observer.errors[:end_date].join(';'), "requires a start date"
    end

    should 'require an end date on or after start date' do
      @ticket_observer.start_date = Date.today
      @ticket_observer.end_date = Date.today - 1.day
      @ticket_observer.valid?
      assert @ticket_observer.errors[:end_date].any? == true
      assert_equal @ticket_observer.errors[:end_date].join(';'), "cannot be less than the start date"
    end

  end # a new ticket_observer

end
