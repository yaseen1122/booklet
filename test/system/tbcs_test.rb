require "application_system_test_case"

class TbcsTest < ApplicationSystemTestCase
  setup do
    @tbc = tbcs(:one)
  end

  test "visiting the index" do
    visit tbcs_url
    assert_selector "h1", text: "Tbcs"
  end

  test "creating a Tbc" do
    visit tbcs_url
    click_on "New Tbc"

    fill_in "Name", with: @tbc.name
    click_on "Create Tbc"

    assert_text "Tbc was successfully created"
    click_on "Back"
  end

  test "updating a Tbc" do
    visit tbcs_url
    click_on "Edit", match: :first

    fill_in "Name", with: @tbc.name
    click_on "Update Tbc"

    assert_text "Tbc was successfully updated"
    click_on "Back"
  end

  test "destroying a Tbc" do
    visit tbcs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tbc was successfully destroyed"
  end
end
