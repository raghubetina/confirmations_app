require 'test_helper'

class ConfirmationsControllerTest < ActionController::TestCase
  setup do
    @confirmation = confirmations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:confirmations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create confirmation" do
    assert_difference('Confirmation.count') do
      post :create, confirmation: { description: @confirmation.description, doubletime_hours: @confirmation.doubletime_hours, number: @confirmation.number, overtime_hours: @confirmation.overtime_hours, performed_on: @confirmation.performed_on, service_order_id: @confirmation.service_order_id, straight_hours: @confirmation.straight_hours, travel_hours: @confirmation.travel_hours, user_id: @confirmation.user_id }
    end

    assert_redirected_to confirmation_path(assigns(:confirmation))
  end

  test "should show confirmation" do
    get :show, id: @confirmation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @confirmation
    assert_response :success
  end

  test "should update confirmation" do
    put :update, id: @confirmation, confirmation: { description: @confirmation.description, doubletime_hours: @confirmation.doubletime_hours, number: @confirmation.number, overtime_hours: @confirmation.overtime_hours, performed_on: @confirmation.performed_on, service_order_id: @confirmation.service_order_id, straight_hours: @confirmation.straight_hours, travel_hours: @confirmation.travel_hours, user_id: @confirmation.user_id }
    assert_redirected_to confirmation_path(assigns(:confirmation))
  end

  test "should destroy confirmation" do
    assert_difference('Confirmation.count', -1) do
      delete :destroy, id: @confirmation
    end

    assert_redirected_to confirmations_path
  end
end
