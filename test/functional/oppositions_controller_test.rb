require 'test_helper'

class OppositionsControllerTest < ActionController::TestCase
  setup do
    @opposition = oppositions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oppositions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create opposition" do
    assert_difference('Opposition.count') do
      post :create, opposition: @opposition.attributes
    end

    assert_redirected_to opposition_path(assigns(:opposition))
  end

  test "should show opposition" do
    get :show, id: @opposition.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @opposition.to_param
    assert_response :success
  end

  test "should update opposition" do
    put :update, id: @opposition.to_param, opposition: @opposition.attributes
    assert_redirected_to opposition_path(assigns(:opposition))
  end

  test "should destroy opposition" do
    assert_difference('Opposition.count', -1) do
      delete :destroy, id: @opposition.to_param
    end

    assert_redirected_to oppositions_path
  end
end
