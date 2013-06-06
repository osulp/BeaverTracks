require File.dirname(__FILE__) + '/../../test_helper'

class Admin::FrontControllerTest < ActionController::TestCase
  # Replace this with your real tests.
 test "should get new" do
    get :new
    assert_response :success
  end

  test "should create building" do
    assert_difference('Building.count') do
      post :create, :building => { }
    end

    assert_redirected_to building_path(assigns(:building))
  end
  
   test "should get edit" do
    get :edit, :id => buildings(:one).to_param
    assert_response :success
  end

  test "should update building" do
    put :update, :id => buildings(:one).to_param, :building => { }
    assert_redirected_to building_path(assigns(:building))
  end

  test "should destroy building" do
    assert_difference('Building.count', -1) do
      delete :destroy, :id => buildings(:one).to_param
    end

    assert_redirected_to buildings_path
  end
end
