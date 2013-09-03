require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  should validate_presence_of(:subject)
  should ensure_length_of(:subject).is_at_least(2)
  should ensure_length_of(:subject).is_at_most(255)

  should allow_value('New').for(:status)
  should allow_value('Opened').for(:status)
  should allow_value('Ignored').for(:status)
  should allow_value('Resolved').for(:status)
  should allow_value('Held').for(:status)
  should_not allow_value('Dropped').for(:status)

  should validate_presence_of(:priority)
  should validate_numericality_of(:priority)
  should allow_value(1).for(:priority)
  should allow_value(25).for(:priority)
  should_not allow_value(0).for(:priority)
  should_not allow_value(26).for(:priority)
  should_not allow_value(1.5).for(:priority)

  should validate_presence_of(:start_date)

  should validate_presence_of(:body)
  should allow_value('This is a body').for(:body)
  should_not allow_value('T').for(:body)

  should belong_to(:ticket_queue)
  should validate_numericality_of(:ticket_queue_id).only_integer
  should allow_value(1).for(:ticket_queue_id)
  should_not allow_value(0).for(:ticket_queue_id)

  should belong_to(:user)
  should validate_numericality_of(:user_id).only_integer
  should allow_value(1).for(:user_id)
  should_not allow_value(0).for(:user_id)

  context 'A given ticket' do

    setup do
      @ticket = Ticket.first()
    end

    should 'not be valid if subject is invalid' do
      @ticket.subject = ''
      @ticket.valid?
      assert @ticket.errors[:subject].any? == true
      @ticket.subject = 'a'
      @ticket.valid?
      assert @ticket.errors[:subject].any? == true
      @ticket.subject = 'a' * 256
      @ticket.valid?
      assert @ticket.errors[:subject].any? == true
      @ticket.subject = 'Subject'
      @ticket.valid?
      assert @ticket.errors[:subject].any? == false
    end

    should 'not be valid with an invalid status' do
      @ticket.status = 'Dropped'
      @ticket.valid?
      assert @ticket.errors[:status].any? == true
    end

    should 'not be valid with an invalid priority' do
      @ticket.priority = 0
      @ticket.valid?
      assert @ticket.errors[:priority].any? == true
      @ticket.priority = 26
      @ticket.valid?
      assert @ticket.errors[:priority].any? == true
    end

    should 'not be valid without a start_date' do
      @ticket.start_date = nil
      @ticket.valid?
      assert @ticket.errors[:start_date].any? == true
    end

    should 'require a start date if an end date is present' do
      @ticket.start_date = nil
      @ticket.end_date = Date.today()
      @ticket.valid?
      assert @ticket.errors[:end_date].any? == true
      assert_equal @ticket.errors[:end_date].join(';'), "requires a start date"
    end

    should 'require an end date on or after start date' do
      @ticket.start_date = Date.today
      @ticket.end_date = Date.today - 1.day
      @ticket.valid?
      assert @ticket.errors[:end_date].any? == true
      assert_equal @ticket.errors[:end_date].join(';'), "cannot be less than the start date"
    end

    should 'not be valid without a ticket_queue' do
      @ticket.ticket_queue = nil
      @ticket.valid?
      assert @ticket.errors[:ticket_queue].any? == true
    end

    should 'not be valid without a user' do
      @ticket.user = nil
      @ticket.valid?
      assert @ticket.errors[:user].any? == true
    end

    should 'retrieve its ticket queue' do
      ticket_queue = @ticket.ticket_queue
      assert ticket_queue.nil? == false
      assert ticket_queue.valid? == true
    end

    should 'retrieve its user' do
      user = @ticket.user
      assert user.nil? == false
      assert user.valid? == true
    end

    should 'retrieve all observers, if there are any' do
      observers = @ticket.ticket_observers
      assert observers.nil? == false
      assert observers.size > 0
      users = @ticket.users
      user = @ticket.user
      assert users.size == 2
      assert user.nil? == false
    end



  end # a given ticket

end
