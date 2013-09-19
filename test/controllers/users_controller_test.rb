require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      user = User.new
      user.first_name = "Henry"
      user.last_name = "Aaron"
      user.login_name = "aaronhc"
      user.nick_name = "Hank"
      user.notes = "This is a note"
      user.start_date = Date.today
      user.end_date = nil
      user.is_admin = true
      user.can_login = true
      user.user_by_email = true
      user.password = "Password_1"
      user.password_confirmation = "Password_1"

      post :create, user: { first_name: user.first_name,
                            last_name: user.last_name,
                            login_name: user.login_name,
                            nick_name: user.nick_name,
                            notes: user.notes,
                            start_date: user.start_date,
                            end_date: user.end_date,
                            is_admin: user.is_admin,
                            can_login: user.can_login,
                            user_by_email: user.user_by_email,
                            password: user.password,
                            password_confirmation: user.password_confirmation,
                            password_digest: user.password_digest }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { first_name: @user.first_name, last_name: @user.last_name, login_name: @user.login_name, nick_name: @user.nick_name, notes: @user.notes }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
