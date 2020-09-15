require 'test_helper'

class User::InquiryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_inquiry_index_url
    assert_response :success
  end

  test "should get confirm" do
    get user_inquiry_confirm_url
    assert_response :success
  end

  test "should get thanks" do
    get user_inquiry_thanks_url
    assert_response :success
  end

end
