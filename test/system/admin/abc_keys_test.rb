require "application_system_test_case"

class Admin::AbcKeysTest < ApplicationSystemTestCase
  setup do
    @admin_abc_key = admin_abc_keys(:one)
  end

  test "visiting the index" do
    visit admin_abc_keys_url
    assert_selector "h1", text: "Abc keys"
  end

  test "should create abc key" do
    visit admin_abc_keys_url
    click_on "New abc key"

    fill_in "Description", with: @admin_abc_key.description
    fill_in "Name", with: @admin_abc_key.name
    click_on "Create Abc key"

    assert_text "Abc key was successfully created"
    click_on "Back"
  end

  test "should update Abc key" do
    visit admin_abc_key_url(@admin_abc_key)
    click_on "Edit this abc key", match: :first

    fill_in "Description", with: @admin_abc_key.description
    fill_in "Name", with: @admin_abc_key.name
    click_on "Update Abc key"

    assert_text "Abc key was successfully updated"
    click_on "Back"
  end

  test "should destroy Abc key" do
    visit admin_abc_key_url(@admin_abc_key)
    click_on "Destroy this abc key", match: :first

    assert_text "Abc key was successfully destroyed"
  end
end
