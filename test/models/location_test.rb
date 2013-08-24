require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  should allow_value('American').for(:company)
  should allow_value('American Telegraph').for(:company)
  should allow_value('American Telegraph Company').for(:company)
  should_not allow_value('American Telegraph company').for(:company)

  should allow_value('37122').for(:zip)
  should allow_value('37122-4444').for(:zip)
  should_not allow_value('37122-444').for(:zip)
  should_not allow_value('3712-4444').for(:zip)

  should belong_to :user

  context 'A given Location' do

    setup do
      @location = Location.first()
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

    should 'not be valid if adddress2 is specified and address1 is not' do
      @location.address1 = nil
      @location.address2 = nil
      assert @location.valid? == false
      assert @location.errors[:address1].any? == true
    end

  end # a given user

end
