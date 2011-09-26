require 'test_helper'

class OurTeamsControllerTest < ActionController::TestCase
  setup do
    @our_team = our_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:our_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create home_team" do
    assert_difference('HomeTeam.count') do
      post :create, home_team: @our_team.attributes
    end

    assert_redirected_to home_team_path(assigns(:home_team))
  end

  test "should show home_team" do
    get :show, id: @our_team.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @our_team.to_param
    assert_response :success
  end

  test "should update home_team" do
    put :update, id: @our_team.to_param, home_team: @our_team.attributes
    assert_redirected_to home_team_path(assigns(:home_team))
  end

  test "should destroy home_team" do
    assert_difference('HomeTeam.count', -1) do
      delete :destroy, id: @our_team.to_param
    end

    assert_redirected_to our_teams_path
  end
end
