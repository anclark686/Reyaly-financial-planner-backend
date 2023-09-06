require "test_helper"

class SavedPaychecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @saved_paycheck = saved_paychecks(:one)
  end

  test "should get index" do
    get saved_paychecks_url
    assert_response :success
  end

  test "should get new" do
    get new_saved_paycheck_url
    assert_response :success
  end

  test "should create saved_paycheck" do
    assert_difference("SavedPaycheck.count") do
      post saved_paychecks_url, params: { saved_paycheck: { date: @saved_paycheck.date, paycheck_id: @saved_paycheck.paycheck_id } }
    end

    assert_redirected_to saved_paycheck_url(SavedPaycheck.last)
  end

  test "should show saved_paycheck" do
    get saved_paycheck_url(@saved_paycheck)
    assert_response :success
  end

  test "should get edit" do
    get edit_saved_paycheck_url(@saved_paycheck)
    assert_response :success
  end

  test "should update saved_paycheck" do
    patch saved_paycheck_url(@saved_paycheck), params: { saved_paycheck: { date: @saved_paycheck.date, paycheck_id: @saved_paycheck.paycheck_id } }
    assert_redirected_to saved_paycheck_url(@saved_paycheck)
  end

  test "should destroy saved_paycheck" do
    assert_difference("SavedPaycheck.count", -1) do
      delete saved_paycheck_url(@saved_paycheck)
    end

    assert_redirected_to saved_paychecks_url
  end
end
