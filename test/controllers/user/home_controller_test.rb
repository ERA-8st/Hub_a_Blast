require 'test_helper'

class User::HomeControllerTest < ActionDispatch::IntegrationTest

  test "should get root" do
    get root_url
    assert_response :success
  end
  
  test "should get top" do
    get user_home_top_url
    assert_response :success
  end

  test "should get about" do
    get user_home_about_url
    assert_response :success
  end

end
