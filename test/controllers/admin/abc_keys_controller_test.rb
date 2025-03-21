require "test_helper"

class Admin::AbcKeysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_abc_key = admin_abc_keys(:one)
  end

  test "should get index" do
    get admin_abc_keys_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_abc_key_url
    assert_response :success
  end

  test "should create admin_abc_key" do
    assert_difference("Admin::AbcKey.count") do
      post admin_abc_keys_url, params: { admin_abc_key: { description: @admin_abc_key.description, name: @admin_abc_key.name } }
    end

    assert_redirected_to admin_abc_key_url(Admin::AbcKey.last)
  end

  test "should show admin_abc_key" do
    get admin_abc_key_url(@admin_abc_key)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_abc_key_url(@admin_abc_key)
    assert_response :success
  end

  test "should update admin_abc_key" do
    patch admin_abc_key_url(@admin_abc_key), params: { admin_abc_key: { description: @admin_abc_key.description, name: @admin_abc_key.name } }
    assert_redirected_to admin_abc_key_url(@admin_abc_key)
  end

  test "should destroy admin_abc_key" do
    assert_difference("Admin::AbcKey.count", -1) do
      delete admin_abc_key_url(@admin_abc_key)
    end

    assert_redirected_to admin_abc_keys_url
  end
end
