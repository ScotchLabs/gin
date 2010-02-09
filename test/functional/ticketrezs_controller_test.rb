require 'test_helper'

class TicketrezsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ticketrezs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticketrez" do
    assert_difference('Ticketrez.count') do
      post :create, :ticketrez => { }
    end

    assert_redirected_to ticketrez_path(assigns(:ticketrez))
  end

  test "should show ticketrez" do
    get :show, :id => ticketrezs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ticketrezs(:one).to_param
    assert_response :success
  end

  test "should update ticketrez" do
    put :update, :id => ticketrezs(:one).to_param, :ticketrez => { }
    assert_redirected_to ticketrez_path(assigns(:ticketrez))
  end

  test "should destroy ticketrez" do
    assert_difference('Ticketrez.count', -1) do
      delete :destroy, :id => ticketrezs(:one).to_param
    end

    assert_redirected_to ticketrezs_path
  end
end
