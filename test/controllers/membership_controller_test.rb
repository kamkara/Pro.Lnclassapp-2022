require "test_helper"

class MembershipControllerTest < ActionDispatch::IntegrationTest
  test "should get teamUp" do
    get membership_teamUp_url
    assert_response :success
  end

  test "should get teamIn" do
    get membership_teamIn_url
    assert_response :success
  end

  test "should get teacherUp" do
    get membership_teacherUp_url
    assert_response :success
  end

  test "should get teacherIn" do
    get membership_teacherIn_url
    assert_response :success
  end

  test "should get ambassadorUp" do
    get membership_ambassadorUp_url
    assert_response :success
  end

  test "should get ambassadorIn" do
    get membership_ambassadorIn_url
    assert_response :success
  end
end
