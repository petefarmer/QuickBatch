require "test_helper"

class Admin::StorageConditionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_storage_conditions_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_storage_conditions_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_storage_conditions_edit_url
    assert_response :success
  end

  test "should get show" do
    get admin_storage_conditions_show_url
    assert_response :success
  end

  test "should get create" do
    get admin_storage_conditions_create_url
    assert_response :success
  end

  test "should get update" do
    get admin_storage_conditions_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_storage_conditions_destroy_url
    assert_response :success
  end
end
