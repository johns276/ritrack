require 'test_helper'

class EmailTest < ActiveSupport::TestCase

  should validate_presence_of(:address)
  should validate_uniqueness_of(:address).case_insensitive
  should allow_value('ming.Zhu@accre.vanderbilt.edu').for(:address)
  should_not allow_value('ming.Zhu@accre').for(:address)

  should validate_presence_of(:start_date)

  context 'A given email' do

    setup do
      @email = Email.first()
    end

    should 'initially be valid' do
      @email.valid?
      assert @email.errors.any? == false
    end

    should 'not allow saving a duplicate email address' do
      dupemail = @email.dup
      dupemail.save
      dupemail.valid?
      assert dupemail.errors[:address].any? == true
      dupemail.address = 'manfred@rocket.com'
      dupemail.save
      dupemail.valid?
      assert dupemail.errors[:address].any? == false
    end

    should 'require a start date if an end date is present' do
      @email.start_date = nil
      @email.end_date = Date.today()
      @email.valid?
      assert @email.errors[:end_date].any? == true
      assert_equal @email.errors[:end_date].join(';'), "requires a start date"
    end

    should 'require an end date on or after start date' do
      @email.start_date = Date.today
      @email.end_date = Date.today - 1.day
      @email.valid?
      assert @email.errors[:end_date].any? == true
      assert_equal @email.errors[:end_date].join(';'), "cannot be less than the start date"
    end

  end #a given email

  context 'A new email' do

    setup do
      @email = Email.new()
    end

    should 'not initially be valid' do
      @email.valid?
      assert @email.errors.any? == true
    end

    should 'not allow saving a duplicate email address' do
      @email.address = 'charles@mexico.mx'
      @email.start_date = Date.today()
      @email.save
      @email.valid?
      assert @email.errors.any? == false
      dupemail = @email.dup
      dupemail.save
      dupemail.valid?
      assert dupemail.errors[:address].any? == true
      dupemail.address = 'manfred@rocket.com'
      dupemail.save
      dupemail.valid?
      assert dupemail.errors[:address].any? == false
    end

    should 'require a start date if an end date is present' do
      @email.address = 'charles@mexico.mx'
      @email.start_date = Date.today()
      assert @email.valid? == true
      @email.start_date = nil
      @email.end_date = Date.today()
      @email.valid?
      assert @email.errors[:end_date].any? == true
      assert_equal @email.errors[:end_date].join(';'), "requires a start date"
    end

    should 'require an end date on or after start date' do
      @email.start_date = Date.today
      @email.end_date = Date.today - 1.day
      @email.valid?
      assert @email.errors[:end_date].any? == true
      assert_equal @email.errors[:end_date].join(';'), "cannot be less than the start date"
    end

  end #a new email

end
