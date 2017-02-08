require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @group = groups(:st)
    @user = users(:kartik)
  end


  test "should get new after login" do
    get login_path
    assert_template 'sessions/new'
    post login_path , params:{session:{email: @user.email,password:"believe"}}  
    assert_redirected_to @user
    get groups_path
    assert_template 'groups/index'
  end
  
  test "should create group after valid login" do
    get login_path
    assert_template 'sessions/new'
    post login_path , params:{session:{email: @user.email,password:"believe"}}  
    assert is_logged_in?
    assert_redirected_to @user
    get new_group_path
    assert_template 'groups/new'
    assert_difference 'Group.count' ,1 do
      post groups_path , params: {group:{name: "gh"}}
    end
    follow_redirect!
    assert_template 'groups/show'
  end

  test "should get index after valid login" do
    get login_path
    assert_template 'sessions/new'
    post login_path , params:{session:{email: @user.email,password:"believe"}}  
    assert is_logged_in?
    assert_redirected_to @user
    get groups_path
    assert_template 'groups/index'
  end
end
