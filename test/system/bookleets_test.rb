require "application_system_test_case"

class BookleetsTest < ApplicationSystemTestCase
  setup do
    @bookleet = bookleets(:one)
  end

  test "visiting the index" do
    visit bookleets_url
    assert_selector "h1", text: "Bookleets"
  end

  test "creating a Bookleet" do
    visit bookleets_url
    click_on "New Bookleet"

    fill_in "Name", with: @bookleet.name
    click_on "Create Bookleet"

    assert_text "Bookleet was successfully created"
    click_on "Back"
  end

  test "updating a Bookleet" do
    visit bookleets_url
    click_on "Edit", match: :first

    fill_in "Name", with: @bookleet.name
    click_on "Update Bookleet"

    assert_text "Bookleet was successfully updated"
    click_on "Back"
  end

  test "destroying a Bookleet" do
    visit bookleets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bookleet was successfully destroyed"
  end
end
