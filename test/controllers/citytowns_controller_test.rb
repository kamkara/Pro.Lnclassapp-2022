require "test_helper"

class CitytownsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @citytown = citytowns(:one)
  end

  test "should get index" do
    get citytowns_url
    assert_response :success
  end

  test "should get new" do
    get new_citytown_url
    assert_response :success
  end

  test "should create citytown" do
    assert_difference("Citytown.count") do
      post citytowns_url, params: { citytown: { slug: @citytown.slug, title: @citytown.title, user_id: @citytown.user_id } }
    end

    assert_redirected_to citytown_url(Citytown.last)
  end

  test "should show citytown" do
    get citytown_url(@citytown)
    assert_response :success
  end

  test "should get edit" do
    get edit_citytown_url(@citytown)
    assert_response :success
  end

  test "should update citytown" do
    patch citytown_url(@citytown), params: { citytown: { slug: @citytown.slug, title: @citytown.title, user_id: @citytown.user_id } }
    assert_redirected_to citytown_url(@citytown)
  end

  test "should destroy citytown" do
    assert_difference("Citytown.count", -1) do
      delete citytown_url(@citytown)
    end

    assert_redirected_to citytowns_url
  end
end
