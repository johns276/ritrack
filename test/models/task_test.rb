require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  should validate_presence_of :subject
  should ensure_length_of(:subject).is_at_least(5)
  should ensure_length_of(:subject).is_at_most(255)

  should validate_presence_of :start_date
  should validate_presence_of :notes

end
