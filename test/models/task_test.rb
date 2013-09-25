require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  should validate_presence_of :subject
  should ensure_length_of(:subject).is_at_least(5)
  should ensure_length_of(:subject).is_at_most(255)

  should validate_presence_of :start_date
  should validate_presence_of :note
  should ensure_length_of(:note).is_at_least(5)

  should belong_to(:ticket)
  should belong_to(:user)

  context 'A given task' do

    setup do
      @task = tasks(:one)
    end

    should 'have a valid subject' do
      @task.subject = ''
      @task.valid?
      assert @task.errors[:subject].any? == true
      @task.subject = 'a'
      @task.valid?
      assert @task.errors[:subject].any? == true
      @task.subject = 'a' * 256
      @task.valid?
      assert @task.errors[:subject].any? == true
      @task.subject = 'Subject'
      @task.valid?
      assert @task.errors[:subject].any? == false
    end

    should 'have a valid note' do
      @task.note = ''
      @task.valid?
      assert @task.errors[:note].any? == true
      @task.note = 'a'
      @task.valid?
      assert @task.errors[:note].any? == true
      @task.note = 'This is a note.'
      @task.valid?
      assert @task.errors[:note].any? == false
    end

    should 'have a valid user' do
      assert @task.valid? == true
      user = @task.user
      assert user.valid? == true
    end

    should 'have a valid ticket' do
      assert @task.valid? == true
      ticket = @task.ticket
      assert ticket.valid? == true
    end

    should 'require a start date if an end date is present' do
      @task.start_date = nil
      @task.end_date = Date.today()
      @task.valid?
      assert @task.errors[:end_date].any? == true
      assert_equal @task.errors[:end_date].join(';'), "requires a start date"
    end

    should 'require an end date on or after start date' do
      @task.start_date = Date.today
      @task.end_date = Date.today - 1.day
      @task.valid?
      assert @task.errors[:end_date].any? == true
      assert_equal @task.errors[:end_date].join(';'), "cannot be less than the start date"
    end

  end # a given task

  context 'A new task' do

    setup do
      @task = Task.new
    end

    should 'have a valid subject' do
      @task.valid?
      @task.errors[:subject].any? == true
      @task.subject = 'A Su'
      @task.valid?
      @task.errors[:subject].any? == true
      @task.subject = 'A' * 256
      @task.subject = 'A Subject'
      @task.valid?
      @task.errors[:subject].any? == true
      @task.subject = 'A Subject'
      @task.valid?
      @task.errors[:subject].any? == false
    end

    should 'have a valid note' do
      @task.valid?
      assert @task.errors[:note].any? == true
      @task.note = 'a'
      @task.valid?
      assert @task.errors[:note].any? == true
      @task.note = 'This is a note.'
      @task.valid?
      assert @task.errors[:note].any? == false
    end

    should 'require a start date if an end date is present' do
      @task.start_date = nil
      @task.end_date = Date.today()
      @task.valid?
      assert @task.errors[:end_date].any? == true
      assert_equal @task.errors[:end_date].join(';'), "requires a start date"
    end

    should 'require an end date on or after start date' do
      @task.start_date = Date.today
      @task.end_date = Date.today - 1.day
      @task.valid?
      assert @task.errors[:end_date].any? == true
      assert_equal @task.errors[:end_date].join(';'), "cannot be less than the start date"
    end

    should 'be valid with a full data set' do
      user = users(:one)
      ticket = tickets(:one)
      @task.subject = 'A Subject'
      @task.note = 'A note for this task'
      @task.start_date = Date.today()
      @task.end_date = nil
      user.tasks << @task
      ticket.tasks << @task
      assert @task.valid? == true
    end

  end # a new task

end
