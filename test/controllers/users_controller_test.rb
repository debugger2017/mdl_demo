require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:kartik)
    @group = groups(:pace)
  end

  test "should get index after valid login" do
    get login_path
    assert_template 'sessions/new'
    post login_path , params:{session:{email: @user.email,password:"believe"}}
    assert_redirected_to @user
    get users_path
    assert_template 'users/index'
  end

  test "should redirect index after invalid login" do
    get login_path
    assert_template 'sessions/new'
    post login_path , params:{session:{email:"",password:""}}
    assert_template 'sessions/new'
  end
  
  test "should show after valid login" do
    get login_path
    assert_template 'sessions/new'
    post login_path , params:{session:{email: @user.email,password:"believe"}}
    assert_redirected_to @user
  end

  test "should create group after valid login" do
    get login_path
    assert_template 'sessions/new'
    post login_path , params:{session:{email: @user.email,password:"believe"}}
    assert_redirected_to @user
    get groups_path
    assert_template 'groups/index'
    get new_group_path
    assert_difference 'Group.count' ,1 do
      post groups_path , params: {group:{ name: "pace" }}
    end

  end

end
