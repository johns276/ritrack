require 'test_helper'

class TicketQueuesControllerTest < ActionController::TestCase
  setup do
    @ticket_queue = ticket_queues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ticket_queues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticket_queue" do
    assert_difference('TicketQueue.count') do
      post :create, ticket_queue: { default_due_in: @ticket_queue.default_due_in, description: @ticket_queue.description, end_date: @ticket_queue.end_date, name: @ticket_queue.name, priority: @ticket_queue.priority, start_date: @ticket_queue.start_date, url: @ticket_queue.url }
    end

    assert_redirected_to ticket_queue_path(assigns(:ticket_queue))
  end

  test "should show ticket_queue" do
    get :show, id: @ticket_queue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ticket_queue
    assert_response :success
  end

  test "should update ticket_queue" do
    patch :update, id: @ticket_queue, ticket_queue: { default_due_in: @ticket_queue.default_due_in, description: @ticket_queue.description, end_date: @ticket_queue.end_date, name: @ticket_queue.name, priority: @ticket_queue.priority, start_date: @ticket_queue.start_date, url: @ticket_queue.url }
    assert_redirected_to ticket_queue_path(assigns(:ticket_queue))
  end

  test "should destroy ticket_queue" do
    assert_difference('TicketQueue.count', -1) do
      delete :destroy, id: @ticket_queue
    end

    assert_redirected_to ticket_queues_path
  end
end
