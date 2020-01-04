require 'test_helper'

class BookleetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bookleet = bookleets(:one)
  end

  test "should get index" do
    get bookleets_url
    assert_response :success
  end

  test "should get new" do
    get new_bookleet_url
    assert_response :success
  end

  test "should create bookleet" do
    assert_difference('Bookleet.count') do
      post bookleets_url, params: { bookleet: { name: @bookleet.name } }
    end

    assert_redirected_to bookleet_url(Bookleet.last)
  end

  test "should show bookleet" do
    get bookleet_url(@bookleet)
    assert_response :success
  end

  test "should get edit" do
    get edit_bookleet_url(@bookleet)
    assert_response :success
  end

  test "should update bookleet" do
    patch bookleet_url(@bookleet), params: { bookleet: { name: @bookleet.name } }
    assert_redirected_to bookleet_url(@bookleet)
  end

  test "should destroy bookleet" do
    assert_difference('Bookleet.count', -1) do
      delete bookleet_url(@bookleet)
    end

    assert_redirected_to bookleets_url
  end
end
