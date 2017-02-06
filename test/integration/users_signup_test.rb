require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
  	get new_user_path
  	assert_no_difference 'User.count' do
  		post users_path , params: {user:{name: "",email:"user@invalid",password: "foo",password_confirmation: "bar"}}
  	end
  	assert_template 'users/new'
  end

  test "valid signup information" do
  	get new_user_path
  	assert_difference 'User.count' ,1 do
  		post users_path , params: {user:{name: "kartik" , email: "kartik@gmail.com" ,password: "believe" ,password_confirmation:"believe"}}
  	end
  	follow_redirect!
  	assert_template 'users/show'
    assert is_logged_in?
  end
end