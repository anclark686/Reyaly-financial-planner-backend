require "test_helper"

class SavingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get savings_url
    assert_response :success
  end
end
