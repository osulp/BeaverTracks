require 'test_helper'

class BuildingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buildings)
  end

 

  test "should show building" do
    get :show, :id => buildings(:one).to_param
    assert_response :success
  end

 
end
