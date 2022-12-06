require "application_system_test_case"

class CitytownsTest < ApplicationSystemTestCase
  setup do
    @citytown = citytowns(:one)
  end

  test "visiting the index" do
    visit citytowns_url
    assert_selector "h1", text: "Citytowns"
  end

  test "should create citytown" do
    visit citytowns_url
    click_on "New citytown"

    fill_in "Slug", with: @citytown.slug
    fill_in "Title", with: @citytown.title
    fill_in "User", with: @citytown.user_id
    click_on "Create Citytown"

    assert_text "Citytown was successfully created"
    click_on "Back"
  end

  test "should update Citytown" do
    visit citytown_url(@citytown)
    click_on "Edit this citytown", match: :first

    fill_in "Slug", with: @citytown.slug
    fill_in "Title", with: @citytown.title
    fill_in "User", with: @citytown.user_id
    click_on "Update Citytown"

    assert_text "Citytown was successfully updated"
    click_on "Back"
  end

  test "should destroy Citytown" do
    visit citytown_url(@citytown)
    click_on "Destroy this citytown", match: :first

    assert_text "Citytown was successfully destroyed"
  end
end
