require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  should belong_to :user

  context 'A given Location' do

    setup do
      @location = Location.first()
    end

    should 'not be valid if address1 specified and Company is not' do
      @location.company = 'Company'
      @location.valid?
      assert @location.errors[:address1].any? == true
    end

  end # a given user

end
