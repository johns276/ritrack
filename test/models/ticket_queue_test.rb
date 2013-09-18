require 'test_helper'

class TicketQueueTest < ActiveSupport::TestCase

  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  should validate_presence_of(:description)
  should validate_presence_of(:url)
  should validate_presence_of(:priority)
  should validate_presence_of(:default_due_in)
  should validate_presence_of(:start_date)

  should have_many(:tickets)

  context 'A given ticket queue' do

    setup do
      # @ticket_queue = TicketQueue.first
      @ticket_queue = ticket_queues(:one)
    end

    should 'require a start date if an end date is present' do
      @ticket_queue.start_date = nil
      @ticket_queue.end_date = Date.today()
      @ticket_queue.valid?
      assert @ticket_queue.errors[:end_date].any? == true
      assert_equal @ticket_queue.errors[:end_date].join(';'), "requires a start date"
    end

    should 'require an end date on or after start date' do
      @ticket_queue.start_date = Date.today
      @ticket_queue.end_date = Date.today - 1.day
      @ticket_queue.valid?
      assert @ticket_queue.errors[:end_date].any? == true
      assert_equal @ticket_queue.errors[:end_date].join(';'), "cannot be less than the start date"
    end


  end # a given ticket queue

end
