class Task < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
end
