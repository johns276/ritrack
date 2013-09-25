require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  should allow_value('American').for(:company)
  should allow_value('American Telegraph').for(:company)
  should allow_value('American Telegraph Company').for(:company)
  should allow_value('IBM').for(:company)
  should_not allow_value('American Telegraph company').for(:company)
  should_not allow_value('INTEL').for(:company)

  should allow_value('37122').for(:zip)
  should allow_value('37122-4444').for(:zip)
  should_not allow_value('37122-444').for(:zip)
  should_not allow_value('3712-4444').for(:zip)

  should belong_to(:user)
  should validate_presence_of(:user_id)
  should validate_numericality_of(:user_id).only_integer
  should allow_value(1).for(:user_id)
  should_not allow_value(0).for(:user_id)

  context 'A given Location' do

    setup do
      @location = locations(:one)
    end

    should 'require a valid comany if comapny is specified' do
      @location.company = 'California'
      @location.valid?
      assert @location.errors[:company].any? == false
      @location.company = 'California Utility'
      @location.valid?
      assert @location.errors[:company].any? == false
      @location.company = 'California utility'
      @location.valid?
      assert @location.errors[:company].any? == true
    end

    should 'not be valid if company is specified and address1 is not' do
      @location.address1 = nil
      assert @location.valid? == false
      assert @location.errors[:address1].any? == true
    end

    should 'not be valid if company is specified and city is not' do
      @location.city = nil
      assert @location.valid? == false
      assert @location.errors[:city].any? == true
    end

    should 'not be valid if company is specified and state is not' do
      @location.state = nil
      assert @location.valid? == false
      assert @location.errors[:state].any? == true
    end

    should 'not be valid if company is specified and zip is not' do
      @location.zip = nil
      assert @location.valid? == false
      assert @location.errors[:zip].any? == true
    end

    should 'not be valid with invalid zip' do
      @location.zip = '9201'
      assert @location.valid? == false
      assert @location.errors[:zip].any? == true
      @location.zip = '92040'
      assert @location.valid? == true
      assert @location.errors[:zip].any? == false
      @location.zip = '92040-112'
      assert @location.valid? == false
      assert @location.errors[:zip].any? == true
      @location.zip = '92040-4432'
      assert @location.valid? == true
      assert @location.errors[:zip].any? == false
    end

    should 'not be valid if adddress2 is specified and address1 is not' do
      @location.address1 = nil
      @location.address2 = '13th Floor'
      assert @location.valid? == false
      assert @location.errors[:address1].any? == true
    end

  end # a given user

  context 'A new Location' do

    setup do
      @location = Location.new()
    end

    should 'require a valid comany if comapny is specified' do
      @location.company = 'California'
      @location.valid?
      assert @location.errors[:company].any? == false
      @location.company = 'California Utility'
      @location.valid?
      assert @location.errors[:company].any? == false
      @location.company = 'California utility'
      @location.valid?
      assert @location.errors[:company].any? == true
    end

    should 'not be valid if company is specified and address1 is not' do
      @location.company = 'California'
      @location.address1 = nil
      @location.valid?
      assert @location.errors[:address1].any? == true
    end

    should 'not be valid if company is specified and city is not' do
      @location.company = 'California'
      @location.city = nil
      @location.valid?
      assert @location.errors[:city].any? == true
    end

    should 'not be valid if company is specified and state is not' do
      @location.company = 'California'
      @location.state = nil
      @location.valid?
      assert @location.errors[:state].any? == true
    end

    should 'not be valid if company is specified and zip is not' do
      @location.company = 'California'
      @location.zip = nil
      @location.valid?
      assert @location.errors[:zip].any? == true
    end

    should 'not be valid with invalid zip' do
      @location.zip = '9201'
      @location.valid?
      assert @location.errors[:zip].any? == true
      @location.zip = '92040'
      @location.valid?
      assert @location.errors[:zip].any? == false
      @location.zip = '92040-112'
      @location.valid?
      assert @location.errors[:zip].any? == true
      @location.zip = '92040-4432'
      @location.valid?
      assert @location.errors[:zip].any? == false
    end

    should 'not be valid if adddress2 is specified and address1 is not' do
      @location.address1 = nil
      @location.address2 = "13th Floor"
      @location.valid?
      assert @location.errors[:address1].any? == true
    end

  end # a new user

end
