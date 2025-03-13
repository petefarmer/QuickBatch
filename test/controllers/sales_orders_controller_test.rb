require "test_helper"

class SalesOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sales_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get sales_orders_show_url
    assert_response :success
  end

  test "should get new" do
    get sales_orders_new_url
    assert_response :success
  end

  test "should get edit" do
    get sales_orders_edit_url
    assert_response :success
  end

  test "should get create" do
    get sales_orders_create_url
    assert_response :success
  end

  test "should get update" do
    get sales_orders_update_url
    assert_response :success
  end

  test "should get destroy" do
    get sales_orders_destroy_url
    assert_response :success
  end
end
