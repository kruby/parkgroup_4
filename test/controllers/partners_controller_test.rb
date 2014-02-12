require 'test_helper'

class PartnersControllerTest < ActionController::TestCase
  setup do
    @partner = partners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:partners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create partner" do
    assert_difference('Partner.count') do
      post :create, partner: { address: @partner.address, category: @partner.category, city: @partner.city, email: @partner.email, homepage: @partner.homepage, info: @partner.info, lock_version: @partner.lock_version, log: @partner.log, name: @partner.name, next_action: @partner.next_action, phone: @partner.phone, postno: @partner.postno, responsible: @partner.responsible, search_lock: @partner.search_lock, user_id: @partner.user_id }
    end

    assert_redirected_to partner_path(assigns(:partner))
  end

  test "should show partner" do
    get :show, id: @partner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @partner
    assert_response :success
  end

  test "should update partner" do
    patch :update, id: @partner, partner: { address: @partner.address, category: @partner.category, city: @partner.city, email: @partner.email, homepage: @partner.homepage, info: @partner.info, lock_version: @partner.lock_version, log: @partner.log, name: @partner.name, next_action: @partner.next_action, phone: @partner.phone, postno: @partner.postno, responsible: @partner.responsible, search_lock: @partner.search_lock, user_id: @partner.user_id }
    assert_redirected_to partner_path(assigns(:partner))
  end

  test "should destroy partner" do
    assert_difference('Partner.count', -1) do
      delete :destroy, id: @partner
    end

    assert_redirected_to partners_path
  end
end
