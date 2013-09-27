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
      @ticket_queue = ticket_queues(:one)
    end

    should 'require a name' do
      @ticket_queue.name = nil
      @ticket_queue.valid?
      assert @ticket_queue.errors[:name].any? == true
    end

    should 'require a uniqie name' do
      @ticket_queue.name = 'Queue2'
      @ticket_queue.valid?
      assert @ticket_queue.errors[:name].any? == true
    end

    should 'require a description' do
      @ticket_queue.description = nil
      @ticket_queue.valid?
      assert @ticket_queue.errors[:description].any? == true
    end

    should 'require a url' do
      @ticket_queue.url = nil
      @ticket_queue.valid?
      assert @ticket_queue.errors[:url].any? == true
    end

    should 'require a priority' do
      @ticket_queue.priority = nil
      @ticket_queue.valid?
      assert @ticket_queue.errors[:priority].any? == true
    end

    should 'require a default due in' do
      @ticket_queue.default_due_in = nil
      @ticket_queue.valid?
      assert @ticket_queue.errors[:default_due_in].any? == true
    end

    should 'require a start_date' do
      @ticket_queue.start_date = nil
      @ticket_queue.valid?
      assert @ticket_queue.errors[:start_date].any? == true
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

  context 'A new ticket queue' do

    setup do
      @ticket_queue = TicketQueue.new()
    end

    should 'require a name' do
      @ticket_queue.valid?
      assert @ticket_queue.errors[:name].any? == true
      @ticket_queue.name = "QueueName"
      @ticket_queue.valid?
      assert @ticket_queue.errors[:name].any? == false
    end

    should 'require a uniqie name' do
      @ticket_queue.name = 'Queue2'
      @ticket_queue.valid?
      assert @ticket_queue.errors[:name].any? == true
    end

    should 'require a description' do
      @ticket_queue.valid?
      assert @ticket_queue.errors[:description].any? == true
      @ticket_queue.description = 'A description'
      @ticket_queue.valid?
      assert @ticket_queue.errors[:description].any? == false
    end

    should 'require a url' do
      @ticket_queue.valid?
      assert @ticket_queue.errors[:url].any? == true
      @ticket_queue.url = 'vanderbilt.edu'
      @ticket_queue.valid?
      assert @ticket_queue.errors[:url].any? == false
    end

    should 'require a priority' do
      @ticket_queue.valid?
      assert @ticket_queue.errors[:priority].any? == true
      @ticket_queue.priority = 1
      @ticket_queue.valid?
      assert @ticket_queue.errors[:priority].any? == false
    end

    should 'require a default due in' do
      @ticket_queue.valid?
      assert @ticket_queue.errors[:default_due_in].any? == true
      @ticket_queue.default_due_in = 3
      @ticket_queue.valid?
      assert @ticket_queue.errors[:default_due_in].any? == false
    end

    should 'require a start_date' do
      @ticket_queue.valid?
      assert @ticket_queue.errors[:start_date].any? == true
      @ticket_queue.start_date = Date.today()
      @ticket_queue.valid?
      assert @ticket_queue.errors[:start_date].any? == false
    end

    should 'require a start date if an end date is present' do
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

  end # a new ticket queue

end
