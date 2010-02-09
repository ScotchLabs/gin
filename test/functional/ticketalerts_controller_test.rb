require 'test_helper'

class TicketalertsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ticketalerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticketalert" do
    assert_difference('Ticketalert.count') do
      post :create, :ticketalert => { }
    end

    assert_redirected_to ticketalert_path(assigns(:ticketalert))
  end

  test "should show ticketalert" do
    get :show, :id => ticketalerts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ticketalerts(:one).to_param
    assert_response :success
  end

  test "should update ticketalert" do
    put :update, :id => ticketalerts(:one).to_param, :ticketalert => { }
    assert_redirected_to ticketalert_path(assigns(:ticketalert))
  end

  test "should destroy ticketalert" do
    assert_difference('Ticketalert.count', -1) do
      delete :destroy, :id => ticketalerts(:one).to_param
    end

    assert_redirected_to ticketalerts_path
  end
end
