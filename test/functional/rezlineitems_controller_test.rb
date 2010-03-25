require 'test_helper'

class RezlineitemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rezlineitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rezlineitem" do
    assert_difference('Rezlineitem.count') do
      post :create, :rezlineitem => { }
    end

    assert_redirected_to rezlineitem_path(assigns(:rezlineitem))
  end

  test "should show rezlineitem" do
    get :show, :id => rezlineitems(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => rezlineitems(:one).to_param
    assert_response :success
  end

  test "should update rezlineitem" do
    put :update, :id => rezlineitems(:one).to_param, :rezlineitem => { }
    assert_redirected_to rezlineitem_path(assigns(:rezlineitem))
  end

  test "should destroy rezlineitem" do
    assert_difference('Rezlineitem.count', -1) do
      delete :destroy, :id => rezlineitems(:one).to_param
    end

    assert_redirected_to rezlineitems_path
  end
end
