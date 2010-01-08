require 'test_helper'

class RoleassocsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:roleassocs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create roleassoc" do
    assert_difference('Roleassoc.count') do
      post :create, :roleassoc => { }
    end

    assert_redirected_to roleassoc_path(assigns(:roleassoc))
  end

  test "should show roleassoc" do
    get :show, :id => roleassocs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => roleassocs(:one).to_param
    assert_response :success
  end

  test "should update roleassoc" do
    put :update, :id => roleassocs(:one).to_param, :roleassoc => { }
    assert_redirected_to roleassoc_path(assigns(:roleassoc))
  end

  test "should destroy roleassoc" do
    assert_difference('Roleassoc.count', -1) do
      delete :destroy, :id => roleassocs(:one).to_param
    end

    assert_redirected_to roleassocs_path
  end
end
