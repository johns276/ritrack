class Phone < ActiveRecord::Base

  validates :number, presence: true
  validates :number, length: { minimum: 7 }
  validates :number, length: { maximum: 17 }

  validates :tag, presence: true, inclusion: { in: %w(Home Office Mobile Pager) }

  validates :user_id, presence: true

  validate :number_format

  belongs_to :user

  private

  def number_format
    # first test for standard 10 digit North American standard phone number area-code plus 7 digits
    # second test for standard 10 plus a leading '1' for long distance
    # third test for standard 7 digit North American phone number
    return if (number =~ /\A\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})\z/) != nil
    return if (number =~ /\A(?:\+?1[-. ]?)?\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})\z/) != nil
    return if (number =~ /\A(?:\(?([0-9]{3})\)?[-. ]?)?([0-9]{3})[-. ]?([0-9]{4})\z/) != nil
    errors.add(:number, "doesn't look like a valid phone number")

  end

end
