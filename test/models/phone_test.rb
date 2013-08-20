require 'test_helper'

class PhoneTest < ActiveSupport::TestCase

  should validate_presence_of :number
  should ensure_length_of(:number).is_at_least(7)
  should ensure_length_of(:number).is_at_most(24)

  should validate_presence_of(:tag)
  should ensure_inclusion_of(:tag).in_array(['Home', 'Office', 'Mobile', 'Pager'])

  should validate_presence_of(:user_id)

  should belong_to(:user)

  context 'A given phone' do

    setup do
      @phone = Phone.first()
    end

    should 'be initially valid' do
      assert @phone.valid?
    end

    should 'optionally require a valid 10-digit North American number' do
      @phone.number = '(913) 345 2244'
      @phone.valid?
      assert @phone.errors[:number].any? == false

      @phone.number = '913 345 2244'
      @phone.valid?
      assert @phone.errors[:number].any? == false

      @phone.number = '(913) 345-2244'
      @phone.valid?
      assert @phone.errors[:number].any? == false

      @phone.number = '913-345-2244'
      @phone.valid?
      assert @phone.errors[:number].any? == false
    end

    should 'optionally be a valid number with 10 digits with a leading 1 for long distance' do
      @phone.number = '1-123-456-7890'
      @phone.valid?
      assert @phone.errors[:number].any? == false
      @phone.number = '1(123) 456-7890'
      @phone.valid?
      assert @phone.errors[:number].any? == false
    end

    should 'not be valid with a poorly formatted 10 digit North American number' do
      @phone.number = '123 123 12345'
      @phone.valid?
      assert @phone.errors[:number].any? == true
      assert_equal @phone.errors[:number].join(';'), "doesn't look like a valid North American or International phone number"
    end

    should 'optionally be a valid North American number with 7 digits' do
      @phone.number = '456-7890'
      @phone.valid?
      assert @phone.errors[:number].any? == false
      @phone.number = '456 7890'
      @phone.valid?
      assert @phone.errors[:number].any? == false
      @phone.number = '4567890'
      @phone.valid?
      assert @phone.errors[:number].any? == false
    end

    should 'not be valid with a poorly formatted 7 digit North American number' do
      @phone.number = '456-78091'
      @phone.valid?
      assert @phone.errors[:number].any? == true
      assert_equal @phone.errors[:number].join(';'), "doesn't look like a valid North American or International phone number"
    end

    should 'optionally be a valid  ITU-T E.123 international number' do
      @phone.number = '+49 89 636 48018'
      @phone.valid?
      assert @phone.errors[:number].any? == false
    end

    should 'optionally be a valid  EPP international number' do
      @phone.number = '+449.12345678901234x1234'
      @phone.valid?
      assert @phone.errors[:number].any? == false
    end

    should 'require a user_id' do
      @phone.user_id = nil
      @phone.valid?
      assert @phone.errors[:user_id].any? == true
    end

  end # a given phone

  context 'A new phone' do

    setup do
      @phone = Phone.new()
    end

    should 'not be initially valid' do
      assert @phone.valid? == false
    end

    should 'optionally require a valid 10-digit North American number' do
      @phone.number = '(913) 345 2244'
      @phone.valid?
      assert @phone.errors[:number].any? == false

      @phone.number = '913 345 2244'
      @phone.valid?
      assert @phone.errors[:number].any? == false

      @phone.number = '(913) 345-2244'
      @phone.valid?
      assert @phone.errors[:number].any? == false

      @phone.number = '913-345-2244'
      @phone.valid?
      assert @phone.errors[:number].any? == false
    end

    should 'optionally be a valid number with 10 digits with a leading 1 for long distance' do
      @phone.number = '1-123-456-7890'
      @phone.valid?
      assert @phone.errors[:number].any? == false
      @phone.number = '1(123) 456-7890'
      @phone.valid?
      assert @phone.errors[:number].any? == false
    end

    should 'not be valid with a poorly formatted 10 digit North American number' do
      @phone.number = '123 123 12345'
      @phone.valid?
      assert @phone.errors[:number].any? == true
      assert_equal @phone.errors[:number].join(';'), "doesn't look like a valid North American or International phone number"
    end

    should 'optionally be a valid North American number with 7 digits' do
      @phone.number = '456-7890'
      @phone.valid?
      assert @phone.errors[:number].any? == false
      @phone.number = '456 7890'
      @phone.valid?
      assert @phone.errors[:number].any? == false
      @phone.number = '4567890'
      @phone.valid?
      assert @phone.errors[:number].any? == false
    end

    should 'not be valid with a poorly formatted 7 digit North American number' do
      @phone.number = '456-78091'
      @phone.valid?
      assert @phone.errors[:number].any? == true
      assert_equal @phone.errors[:number].join(';'), "doesn't look like a valid North American or International phone number"
    end

    should 'not be savable without being fully valid' do
      assert @phone.valid? == false
      @phone.number = '345-6789'
      @phone.tag = 'Home'
      @phone.user_id = 100
      assert @phone.new_record? == true
      assert @phone.valid? == true
      assert @phone.save == true
      assert @phone.new_record? == false
    end

  end # a new phone

end
