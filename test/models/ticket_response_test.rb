require 'test_helper'

class TicketResponseTest < ActiveSupport::TestCase

  should validate_presence_of(:body)
  should allow_value('This is a ticket response.').for(:body)
  should_not allow_value('aaaa').for(:body)

  should validate_presence_of(:response_sent)

  should belong_to(:ticket)

  context 'A given ticket response' do

    setup do
      @ticket_response = ticket_responses(:one)
    end

    should 'be initially valid' do
      assert @ticket_response.valid? == true
    end

    should 'not be valid with nil body' do
      @ticket_response.body = nil
      @ticket_response.valid?
      assert @ticket_response.errors[:body].any? == true
    end

    should 'not be valid with an invalid body' do
      @ticket_response.body = 'a'
      @ticket_response.valid?
      assert @ticket_response.errors[:body].any? == true
    end

    should 'be valid with a valid body' do
      @ticket_response.body = 'This is a valid body'
      @ticket_response.valid?
      assert @ticket_response.errors[:body].any? == false
    end

    should 'not be valid with nil response_sent' do
      @ticket_response.response_sent = nil
      @ticket_response.valid?
      assert @ticket_response.errors[:response_sent].any? == true
    end

    should 'not have sent date before ticket start date' do
      ticket = @ticket_response.ticket
      ticket.start_date = @ticket_response.response_sent + 1.day
      assert ticket.save
      assert @ticket_response.response_sent < ticket.start_date
      @ticket_response.valid?
      assert @ticket_response.errors[:response_sent].any? == true
    end

    should 'have a ticket' do
      @ticket_response.ticket = nil
      @ticket_response.valid?
      assert @ticket_response.errors[:ticket].any? == true
    end

  end # a given ticket response

  context 'A new ticket response' do

    setup do
      @ticket_response = TicketResponse.new
    end

    should 'be initially invalid' do
      assert @ticket_response.valid? == false
    end

    should 'not be valid with blank body' do
      @ticket_response.body = ''
      @ticket_response.valid?
      assert @ticket_response.errors[:body].any? == true
    end

    should 'not be valid with an invalid body' do
      @ticket_response.body = 'a'
      @ticket_response.valid?
      assert @ticket_response.errors[:body].any? == true
    end

    should 'be valid with a valid body' do
      @ticket_response.body = 'This is a valid body'
      @ticket_response.valid?
      assert @ticket_response.errors[:body].any? == false
    end

    should 'not be valid with nil response_sent' do
      @ticket_response.response_sent = nil
      @ticket_response.valid?
      assert @ticket_response.errors[:response_sent].any? == true
    end

    should 'not have sent date before ticket start date' do
      ticket = tickets(:one)
      @ticket_response.ticket = ticket
      @ticket_response.response_sent = Date.today()
      ticket.start_date = @ticket_response.response_sent + 1.day
      @ticket_response.body = 'This is a valid body'
      assert ticket.save
      assert @ticket_response.response_sent < ticket.start_date
      @ticket_response.valid?
      assert @ticket_response.errors[:response_sent].any? == true
    end

    # should 'have a ticket' do
    #   @ticket_response.ticket = nil
    #   @ticket_response.valid?
    #   assert @ticket_response.errors[:ticket].any? == true
    # end

  end # a new ticket response

end
