require "test_helper"

class Admin::TrackSerialLotsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_track_serial_lots_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_track_serial_lots_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_track_serial_lots_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_track_serial_lots_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_track_serial_lots_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_track_serial_lots_destroy_url
    assert_response :success
  end
end
