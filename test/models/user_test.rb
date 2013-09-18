require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should validate_presence_of :first_name
  should allow_value("Charles").for(:first_name)
  should_not allow_value("charles").for(:first_name)
  should ensure_length_of(:first_name).is_at_least(2)
  should ensure_length_of(:first_name).is_at_most(254)

  should validate_presence_of :last_name
  should ensure_length_of(:last_name).is_at_least(2)
  should ensure_length_of(:last_name).is_at_most(254)

  should ensure_length_of(:nick_name).is_at_most(254)

  should validate_presence_of :login_name
  should validate_uniqueness_of :login_name
  should ensure_length_of(:login_name).is_at_least(6)
  should ensure_length_of(:login_name).is_at_most(254)

  should validate_presence_of :start_date

  should have_many(:phones)
  should have_many(:locations)
  should have_many(:emails)
  should have_many(:tickets)

  context 'A given user' do

    setup do
      @user = User.first()
    end

    should 'be valid initially' do
      assert @user.valid?
    end

    should 'respond to all of its components' do
      assert @user.respond_to?(:first_name) == true
      assert @user.respond_to?(:last_name) == true
      assert @user.respond_to?(:nick_name) == true
      assert @user.respond_to?(:login_name) == true
      assert @user.respond_to?(:notes) == true
      assert @user.respond_to?(:created_at) == true
      assert @user.respond_to?(:updated_at) == true
      assert @user.respond_to?(:start_date) == true
      assert @user.respond_to?(:end_date) == true
      assert @user.respond_to?(:is_admin) == true
      assert @user.respond_to?(:can_login) == true
      assert @user.respond_to?(:user_by_email) == true
      assert @user.respond_to?(:password_digest) == true
    end

    should 'not be valid if first name is nil' do
      @user.first_name = nil
      @user.valid?
      assert @user.errors[:first_name].any? == true
    end

    should 'not be valid if first name starts with a lower case letter' do
      @user.first_name = 'charles'
      @user.valid?
      assert @user.errors[:first_name].any? == true
    end

    should 'not be valid if first name is too short' do
      @user.first_name = 'A'
      @user.valid?
      assert @user.errors[:first_name].any? == true
    end

    should 'not be valid if first name is too long' do
      @user.first_name = 'A' + ('a' * 255)
      @user.valid?
      assert @user.errors[:first_name].any? == true
    end

    should 'not be valid if last name is nil' do
      @user.last_name = nil
      @user.valid?
      assert @user.errors[:last_name].any? == true
    end

    should 'not be valid if last name is too short' do
      @user.last_name = 'A'
      @user.valid?
      assert @user.errors[:last_name].any? == true
    end

    should 'not be valid if last name is too long' do
      name = 'a' * 255
      @user.last_name = 'A' + name
      @user.valid?
      assert @user.errors[:last_name].any? == true
    end

    should 'not be valid if login name is nil' do
      @user.login_name = nil
      @user.valid?
      assert @user.errors[:login_name].any? == true
    end

    should 'not be valid if login name starts with a capital letter' do
      @user.login_name = 'Johns276'
      @user.valid?
      assert @user.errors[:login_name].any? == true
    end

    should 'not be valid if login name has non-alphanumeric letters' do
      @user.login_name = 'johns-276'
      @user.valid?
      assert @user.errors[:login_name].any? == true
    end

    should 'not be valid if login name is too short' do
      @user.login_name = 'aaaaa'
      @user.valid?
      assert @user.errors[:login_name].any? == true
    end

    should 'not be valid if login name is a duplicate' do
      @new_user = User.new
      @new_user.first_name = 'Willemina'
      @new_user.last_name = 'Konig'
      @new_user.start_date = Date.today()
      @new_user.login_name = 'johns276'
      @new_user.save
      @new_user.valid?
      assert @new_user.errors[:login_name].any? == true
    end

    should 'not be valid if login name is too long' do
      @user.login_name = 'a' * 255
      @user.valid?
      assert @user.errors[:login_name].any? == true
    end

    should 'not be valid without a password confirmation' do
      @user.password = "Password1-"
      @user.password_confirmation = nil
      @user.valid?
      assert @user.errors[:password_confirmation].any? == true
    end

    should 'not be valid with a blank password confirmation' do
      @user.password = "Password1-"
      @user.password_confirmation = " "
      @user.valid?
      assert @user.errors[:password_confirmation].any? == true
    end

    should 'not be valid if password does not match its confirmation' do
      @user.password = "Password1-good"
      @user.password_confirmation = "Password1-bad"
      @user.valid?
      assert @user.errors[:password_confirmation].any? == true
    end

    should 'not be valid if password is too short' do
      @user.password = "Pasrd1-"
      @user.password_confirmation = "Pasrd1-"
      @user.valid?
      assert @user.errors[:password].any? == true
    end

    should 'not be valid if password is too long' do
      @user.password = "Password1-" + ("a" * 246)
      @user.password_confirmation = "Password1-" + ("a" * 246)
      @user.valid?
      assert @user.errors[:password].any? == true
    end

    should 'not be valid if password format is incorrect' do
      @user.password = "Password"
      @user.password_confirmation = "Password"
      @user.valid?
      assert @user.errors[:password].any? == true
    end

    should 'be valid if password format is correct' do
      @user.password = "Password1-"
      @user.password_confirmation = "Password1-"
      @user.valid?
      assert @user.errors[:password].any? == false
    end

    should 'not authenticate with incorrect password' do
      assert @user.authenticate("Password1-bad") == false
      @user.password = "Password1-good"
      @user.password_confirmation = "Password1-good"
      @user.save
      assert @user.authenticate("Password1-good") == @user
    end

    should 'require a start date if an end date is present' do
      @user.start_date = nil
      @user.end_date = Date.today()
      @user.valid?
      assert @user.errors[:end_date].any? == true
      assert_equal @user.errors[:end_date].join(';'), "requires a start date"
    end

    should 'require an end date on or after start date' do
      @user.start_date = Date.today
      @user.end_date = Date.today - 1.day
      @user.valid?
      assert @user.errors[:end_date].any? == true
      assert_equal @user.errors[:end_date].join(';'), "cannot be less than the start date"
    end

    should 'allow retrieval of user phone numbers' do
      phones = @user.phones
      assert phones.size != 0
    end

    should 'retrieve only valid phones' do
      phones = @user.phones
      phones.each do |phone|
        assert phone.valid? == true
      end
    end

    should 'allow adding a valid phone' do
      phone = Phone.new()
      phone.number = '234-5678'
      phone.tag = 'Home'
      assert phone.new_record? == true
      @user.phones << phone
      assert @user.save == true
      assert @user.phones.size > 2
      assert phone.new_record? == false
    end

    should 'not allow adding an invalid phone' do
      phone = Phone.new()
      phone.number = '234-5678'
      phone.tag = 'Hummus'
      assert phone.new_record? == true
      @user.phones << phone
      assert @user.save == false
      assert phone.valid? == false
    end

    should 'allow retrieving of email addresses if there are any' do
      emails = @user.emails
      assert emails.size > 0
    end

    should 'retrieve only valid emails' do
      emails = @user.emails
      emails.each do |email|
        assert email.valid? == true
      end
    end

    should 'allow retrieving of tickets if there are any' do
      tickets = @user.tickets
      assert tickets.size > 0
    end

    should 'find all the observed tickets' do
      ticket_observers = @user.ticket_observers
      assert ticket_observers.size > 0
    end

    should 'retrieve all tasks, if there are any' do
      tasks = @user.tasks
      assert tasks.nil? == false
      assert tasks.size > 0
    end

    should 'not allow an invalid task' do
      task = Task.new()
      task.start_date = Date.today()
      task.note = 'This is a note.'
      task.subject = nil
      task.user_id = 1
      assert task.valid? == false
      @user.tasks << task
      @user.valid?
      assert @user.errors.any? == true
    end

  end #A given user

  context 'A new user' do

    setup do
      @user = User.new()
    end

    should 'not be valid initially' do
      assert @user.valid? == false
    end

    should 'respond to all of its components' do
      assert @user.respond_to?(:first_name) == true
      assert @user.respond_to?(:last_name) == true
      assert @user.respond_to?(:nick_name) == true
      assert @user.respond_to?(:login_name) == true
      assert @user.respond_to?(:notes) == true
      assert @user.respond_to?(:created_at) == true
      assert @user.respond_to?(:updated_at) == true
      assert @user.respond_to?(:start_date) == true
      assert @user.respond_to?(:end_date) == true
      assert @user.respond_to?(:is_admin) == true
      assert @user.respond_to?(:can_login) == true
      assert @user.respond_to?(:user_by_email) == true
      assert @user.respond_to?(:password_digest) == true
    end

    should 'not be valid if first name is nil' do
      @user.first_name = nil
      @user.valid?
      assert @user.errors[:first_name].any? == true
    end

    should 'not be valid if first name starts with a lower case letter' do
      @user.first_name = 'charles'
      @user.valid?
      assert @user.errors[:first_name].any? == true
    end

    should 'not be valid if first name is too short' do
      @user.first_name = 'A'
      @user.valid?
      assert @user.errors[:first_name].any? == true
    end

    should 'not be valid if first name is too long' do
      @user.first_name = 'Aa' + ('b' * 254)
      @user.valid?
      assert @user.errors[:first_name].any? == true
    end

    should 'not be valid if last name is nil' do
      @user.last_name = nil
      @user.valid?
      assert @user.errors[:last_name].any? == true
    end

    should 'not be valid if last name is too short' do
      @user.last_name = 'A'
      @user.valid?
      assert @user.errors[:last_name].any? == true
    end

    should 'not be valid if last name is too long' do
      @user.last_name = 'Aa' + ('b' * 254)
      @user.valid?
      assert @user.errors[:last_name].any? == true
    end

    should 'not be valid if login name is nil' do
      @user.login_name = nil
      @user.valid?
      assert @user.errors[:login_name].any? == true
    end

    should 'not be valid if login name starts with a capital letter' do
      @user.login_name = 'Johns276'
      @user.valid?
      assert @user.errors[:login_name].any? == true
    end

    should 'not be valid if login name has non-alphanumeric letters' do
      @user.login_name = 'johns-276'
      @user.valid?
      assert @user.errors[:login_name].any? == true
    end

    should 'not be valid if login name is too short' do
      @user.login_name = 'aaaaa'
      @user.valid?
      assert @user.errors[:login_name].any? == true
    end

    should 'not be valid if login name is a duplicate' do
      @new_user = @user.dup
      @new_user.save
      @new_user.valid?
      assert @new_user.errors[:login_name].any? == true
    end

    should 'not be valid if login name is too long' do
      @user.login_name = 'a' + ('b' * 255)
      @user.valid?
      assert @user.errors[:login_name].any? == true
    end

    should 'not be valid without a password' do
      @user.password = nil
      @user.password_confirmation = nil
      @user.valid?
      assert @user.errors[:password].any? == true
    end

    should 'not be valid with a blank password' do
      @user.password = " "
      @user.password_confirmation = " "
      @user.valid?
      assert @user.errors[:password].any? == true
    end

    should 'not be valid without a password confirmation' do
      @user.password = "Password1-"
      @user.password_confirmation = nil
      @user.valid?
      assert @user.errors[:password_confirmation].any? == true
    end

    should 'not be valid with a blank password confirmation' do
      @user.password = "Password1-"
      @user.password_confirmation = " "
      @user.valid?
      assert @user.errors[:password_confirmation].any? == true
    end

    should 'not be valid if password does not match its confirmation' do
      @user.password = "Password1-good"
      @user.password_confirmation = "Password1-bad"
      @user.valid?
      assert @user.errors[:password_confirmation].any? == true
    end

    should 'require a start date if an end date is present' do
      @user.start_date = nil
      @user.end_date = Date.today()
      @user.valid?
      assert @user.errors[:end_date].any? == true
      assert_equal @user.errors[:end_date].join(';'), "requires a start date"
    end

    should 'require an end date on or after start date' do
      @user.start_date = Date.today
      @user.end_date = Date.today - 1.day
      @user.valid?
      assert @user.errors[:end_date].any? == true
      assert_equal @user.errors[:end_date].join(';'), "cannot be less than the start date"
    end

    should 'allow adding a phone' do
      phone = Phone.new()
      phone.number = '234-5678'
      phone.tag = 'Home'
      assert phone.new_record? == true
      @user.phones << phone
      assert @user.phones.size == 1
    end

  end #A new user

end
