require 'test_helper'

class PanesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:panes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pane" do
    assert_difference('Pane.count') do
      post :create, :pane => { }
    end

    assert_redirected_to pane_path(assigns(:pane))
  end

  test "should show pane" do
    get :show, :id => panes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => panes(:one).to_param
    assert_response :success
  end

  test "should update pane" do
    put :update, :id => panes(:one).to_param, :pane => { }
    assert_redirected_to pane_path(assigns(:pane))
  end

  test "should destroy pane" do
    assert_difference('Pane.count', -1) do
      delete :destroy, :id => panes(:one).to_param
    end

    assert_redirected_to panes_path
  end
end
