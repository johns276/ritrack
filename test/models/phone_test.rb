require 'test_helper'

class PhoneTest < ActiveSupport::TestCase

  should validate_presence_of :number
  should ensure_length_of(:number).is_at_least(7)
  should ensure_length_of(:number).is_at_most(17)

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
      assert_equal @phone.errors[:number].join(';'), "doesn't look like a valid phone number"
    end

    should 'optionally be a valid North American number with 7 digits.' do
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
      assert_equal @phone.errors[:number].join(';'), "doesn't look like a valid phone number"
    end

  end # a given phone

end
