require 'test_helper'

class PostBeforeLoginTestTest < ActionDispatch::IntegrationTest
    def setup
    	@post = posts(:one)
    end
    test "should redirect post index when not logged in" do
    	get posts_path
    	assert_redirected_to login_url
  	end

  	test "should redirect post show when not logged in" do
    	get post_path @post
    	assert_redirected_to login_url
  	end

  	test "should redirect post new when not logged in" do
    	get new_post_path
    	assert_redirected_to login_url
  	end

  	test "should redirect post edit when not logged in" do
    	delete post_path @post
    	assert_redirected_to login_url
  	end

end
