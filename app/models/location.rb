# == Schema Information
#
# Table name: locations
#
#  id           :integer          not null, primary key
#  company      :string(255)
#  organization :string(255)
#  address1     :string(255)
#  address2     :string(255)
#  city         :string(255)
#  state        :string(255)
#  zip          :string(255)
#  country      :string(255)
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Location < ActiveRecord::Base

  validate :company_requires_address
  validate :address2_requires_address1

  belongs_to :user

  private

    def company_requires_address

      if company != nil
        errors.add(:address1, "if company is specified a street address is required") if address1 == nil
        errors.add(:city, "if company is specified a city is required") if city.nil == nil
        errors.add(:state, "if company is specified a state is required") if state == nil
        errors.add(:zip, "if company is specified a zip code is required") if zip == nil
      end

    end

    def address2_requires_address1

      if address2 != nil
        errors.add(:address1, "if second line of address is specified a first line is required") if address1 == nil
      end

    end
end
