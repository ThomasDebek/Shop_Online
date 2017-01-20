require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  test "should get terms" do
    get :terms
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

  test "should get shipping" do
    get :shipping
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
