require 'test_helper'

class ManualsControllerTest < ActionController::TestCase
  setup do
    @manual = manuals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manuals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manual" do
    assert_difference('Manual.count') do
      post :create, manual: { accreditation_number: @manual.accreditation_number, author_company: @manual.author_company, author_name: @manual.author_name, average_daily: @manual.average_daily, average_yearly: @manual.average_yearly, client_address: @manual.client_address, client_name: @manual.client_name, client_suburb: @manual.client_suburb, diagram_inverter_text: @manual.diagram_inverter_text, diagram_panels_text: @manual.diagram_panels_text, install_date: @manual.install_date, inverter_brand: @manual.inverter_brand, inverter_model: @manual.inverter_model, inverter_number: @manual.inverter_number, inverter_output: @manual.inverter_output, inverter_serial: @manual.inverter_serial, panels_brand: @manual.panels_brand, panels_model: @manual.panels_model, panels_number: @manual.panels_number, panels_serial_numbers: @manual.panels_serial_numbers, system_address: @manual.system_address, system_config: @manual.system_config, system_pv_current: @manual.system_pv_current, system_pv_voltage: @manual.system_pv_voltage, system_watts: @manual.system_watts, system_yearly_yield: @manual.system_yearly_yield, warranty_inverter: @manual.warranty_inverter, warranty_panels_output_performance: @manual.warranty_panels_output_performance, warranty_panels_product: @manual.warranty_panels_product, warranty_wokmanship: @manual.warranty_wokmanship }
    end

    assert_redirected_to manual_path(assigns(:manual))
  end

  test "should show manual" do
    get :show, id: @manual
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manual
    assert_response :success
  end

  test "should update manual" do
    put :update, id: @manual, manual: { accreditation_number: @manual.accreditation_number, author_company: @manual.author_company, author_name: @manual.author_name, average_daily: @manual.average_daily, average_yearly: @manual.average_yearly, client_address: @manual.client_address, client_name: @manual.client_name, client_suburb: @manual.client_suburb, diagram_inverter_text: @manual.diagram_inverter_text, diagram_panels_text: @manual.diagram_panels_text, install_date: @manual.install_date, inverter_brand: @manual.inverter_brand, inverter_model: @manual.inverter_model, inverter_number: @manual.inverter_number, inverter_output: @manual.inverter_output, inverter_serial: @manual.inverter_serial, panels_brand: @manual.panels_brand, panels_model: @manual.panels_model, panels_number: @manual.panels_number, panels_serial_numbers: @manual.panels_serial_numbers, system_address: @manual.system_address, system_config: @manual.system_config, system_pv_current: @manual.system_pv_current, system_pv_voltage: @manual.system_pv_voltage, system_watts: @manual.system_watts, system_yearly_yield: @manual.system_yearly_yield, warranty_inverter: @manual.warranty_inverter, warranty_panels_output_performance: @manual.warranty_panels_output_performance, warranty_panels_product: @manual.warranty_panels_product, warranty_wokmanship: @manual.warranty_wokmanship }
    assert_redirected_to manual_path(assigns(:manual))
  end

  test "should destroy manual" do
    assert_difference('Manual.count', -1) do
      delete :destroy, id: @manual
    end

    assert_redirected_to manuals_path
  end
end
