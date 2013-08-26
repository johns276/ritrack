# == Schema Information
#
# Table name: tickets
#
#  id              :integer          not null, primary key
#  subject         :string(255)
#  status          :string(255)
#  priority        :integer
#  start_date      :datetime
#  end_date        :datetime
#  due_date        :datetime
#  user_id         :integer
#  ticket_queue_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Ticket < ActiveRecord::Base
end
