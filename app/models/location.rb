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
  belongs_to :user
end
