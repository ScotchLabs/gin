require 'test_helper'

class TicketsectionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ticketsections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticketsection" do
    assert_difference('Ticketsection.count') do
      post :create, :ticketsection => { }
    end

    assert_redirected_to ticketsection_path(assigns(:ticketsection))
  end

  test "should show ticketsection" do
    get :show, :id => ticketsections(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ticketsections(:one).to_param
    assert_response :success
  end

  test "should update ticketsection" do
    put :update, :id => ticketsections(:one).to_param, :ticketsection => { }
    assert_redirected_to ticketsection_path(assigns(:ticketsection))
  end

  test "should destroy ticketsection" do
    assert_difference('Ticketsection.count', -1) do
      delete :destroy, :id => ticketsections(:one).to_param
    end

    assert_redirected_to ticketsections_path
  end
end
