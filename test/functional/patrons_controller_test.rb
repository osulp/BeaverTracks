require 'test_helper'

class PatronsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:patrons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create patron" do
    assert_difference('Patron.count') do
      post :create, :patron => { }
    end

    assert_redirected_to patron_path(assigns(:patron))
  end

  test "should show patron" do
    get :show, :id => patrons(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => patrons(:one).to_param
    assert_response :success
  end

  test "should update patron" do
    put :update, :id => patrons(:one).to_param, :patron => { }
    assert_redirected_to patron_path(assigns(:patron))
  end

  test "should destroy patron" do
    assert_difference('Patron.count', -1) do
      delete :destroy, :id => patrons(:one).to_param
    end

    assert_redirected_to patrons_path
  end
end
