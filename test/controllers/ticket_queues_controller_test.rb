require 'test_helper'

class TicketQueuesControllerTest < ActionController::TestCase
  setup do
    @ticket_queue = ticket_queues(:one)
  end

  context "on GET to :index for ticket queue list" do
    setup do
      get :index
    end
    should respond_with :success
    should render_template :index
    should render_template(partial: false)
    should route(:get, '/ticket_queues').to(:controller => :ticket_queues, :action => :index)
  end

  context 'on GET to :new for a new ticket queue' do
    setup do
      get :new
    end
    should route(:get, '/ticket_queues/new').to(:action => :new)
    should respond_with :success
    should render_template :new
    should render_template(partial: '_form')
  end

  should "create ticket_queue" do
    assert_difference('TicketQueue.count') do
      @ticket_queue.id = nil
      post :create, ticket_queue: { default_due_in: @ticket_queue.default_due_in, description: @ticket_queue.description, end_date: @ticket_queue.end_date, name: "Queue3", priority: @ticket_queue.priority, start_date: @ticket_queue.start_date, url: @ticket_queue.url }
    end

    assert_redirected_to ticket_queue_path(assigns(:ticket_queue))
  end

  should "get edit" do
    get :edit, id: @ticket_queue
    assert_response :success
  end

  should "update ticket_queue" do
    patch :update, id: @ticket_queue, ticket_queue: { default_due_in: @ticket_queue.default_due_in, description: @ticket_queue.description, end_date: @ticket_queue.end_date, name: @ticket_queue.name, priority: @ticket_queue.priority, start_date: @ticket_queue.start_date, url: @ticket_queue.url }
    assert_redirected_to ticket_queue_path(assigns(:ticket_queue))
  end

  should "destroy ticket_queue" do
    assert_difference('TicketQueue.count', -1) do
      delete :destroy, id: @ticket_queue
    end

    assert_redirected_to ticket_queues_path
  end

  context "on GET to :show for first record" do

    setup do
      get :show, :id => 1
    end

    should respond_with :success
    should render_template :show
    should route(:get, '/ticket_queues/1').to(:action => :show, :id => 1)
  end

end
