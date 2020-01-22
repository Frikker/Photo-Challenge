require 'test_helper'

class MainPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get main_pages_index_url
    assert_response :success
  end

  test "should get rules" do
    get main_pages_rules_url
    assert_response :success
  end

  test "should get contacts" do
    get main_pages_contacts_url
    assert_response :success
  end

end
