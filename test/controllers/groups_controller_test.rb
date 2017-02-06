require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @group = groups(:pace)
    @user = users(:kartik)
  end


  test "should get new" do
    get new_group_url
    assert_response :success
  end

  test "should create group" do
    log_in_as(@user)
    assert_not is_logged_in?
    assert_difference 'Group.count' ,1 do
      post users_path , params: { group:{ name: @group.name } }
    end
    assert_redirected_to group_url(@group)
  end

  test "should show group" do
    log_in_as(@user)
    assert_not is_logged_in?
    get group_url(@group)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    assert_not is_logged_in?
    get edit_group_url(@group)
    assert_response :success
  end

  test "should update group" do
    log_in_as(@user)
    assert_not is_logged_in?
    patch group_url(@group), params: { group: { name: @group.name } }
    assert_redirected_to group_url(@group)
  end

  test "should destroy group" do
    log_in_as(@user)
    assert_not is_logged_in?
    assert_difference('Group.count', -1) do
      delete group_url(@group)
    end

    assert_redirected_to groups_url
  end
end
