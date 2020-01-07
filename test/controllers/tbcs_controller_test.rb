require 'test_helper'

class TbcsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tbc = tbcs(:one)
  end

  test "should get index" do
    get tbcs_url
    assert_response :success
  end

  test "should get new" do
    get new_tbc_url
    assert_response :success
  end

  test "should create tbc" do
    assert_difference('Tbc.count') do
      post tbcs_url, params: { tbc: { name: @tbc.name } }
    end

    assert_redirected_to tbc_url(Tbc.last)
  end

  test "should show tbc" do
    get tbc_url(@tbc)
    assert_response :success
  end

  test "should get edit" do
    get edit_tbc_url(@tbc)
    assert_response :success
  end

  test "should update tbc" do
    patch tbc_url(@tbc), params: { tbc: { name: @tbc.name } }
    assert_redirected_to tbc_url(@tbc)
  end

  test "should destroy tbc" do
    assert_difference('Tbc.count', -1) do
      delete tbc_url(@tbc)
    end

    assert_redirected_to tbcs_url
  end
end
