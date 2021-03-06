# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  nick_name       :string(255)
#  login_name      :string(255)
#  notes           :text
#  created_at      :datetime
#  updated_at      :datetime
#  start_date      :date
#  end_date        :date
#  is_admin        :boolean
#  can_login       :boolean
#  user_by_email   :boolean
#  password_digest :string(255)
#

class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true, format: {with: /\A[A-Z][a-z]+\z/}
  validates :first_name, length: { minimum: 2 }
  validates :first_name, length: { maximum: 254 }

  validates :nick_name, length: { maximum: 254 }

  validates :last_name,  presence: true
  validates :last_name, length: { minimum: 2 }
  validates :last_name, length: { maximum: 254 }

  validates :login_name, presence: true, uniqueness: true, format: {with: /\A[a-z][0-9a-z]{5,253}\z/}
  validates :login_name, length: { minimum: 6 }
  validates :login_name, length: { maximum: 254 }

  validates :start_date, presence: true

  validates :password_digest, presence: true

  validate  :no_end_date_without_start_date
  validate  :start_date_must_precede_end_date

  has_many :emails, inverse_of: :user
  validates_associated :emails

  has_many :phones, inverse_of: :user
  validates_associated :phones

  has_many :locations, inverse_of: :user
  validates_associated :locations

  has_many :tickets, inverse_of: :user

  has_many  :ticket_observers

  has_many  :tasks, inverse_of: :user
  validates_associated :tasks

  validates :password,
        format: {with: /\A((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%_-]).{8,255})\z/, message: 'must have 8 or more characters and must include at least one digit, one upper-case, and one special character.',},
        length: { minimum: 8, maximum: 255 }, if: :validate_password?

  validates :password_confirmation, presence: true, if: :validate_password?

  scope :active, -> { where(end_date: nil) }

  private

  def no_end_date_without_start_date
    if end_date !=nil && start_date == nil
      errors.add(:end_date, "requires a start date")
    end
  end

  def start_date_must_precede_end_date
    if end_date != nil && start_date != nil && end_date < start_date
      errors.add(:end_date, "cannot be less than the start date")
    end
  end

  def validate_password?
    password.present? || password_confirmation.present?
  end

end
