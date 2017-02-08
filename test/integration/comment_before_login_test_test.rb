require 'test_helper'

class CommentBeforeLoginTestTest < ActionDispatch::IntegrationTest
    def setup
    	@comment = comments(:one)
    end
    test "should redirect comment index when not logged in" do
    	get comments_path
    	assert_redirected_to login_url
  	end

  	test "should redirect comment show when not logged in" do
    	get comment_path @comment
    	assert_redirected_to login_url
  	end

  	test "should redirect comment new when not logged in" do
    	get new_comment_path
    	assert_redirected_to login_url
  	end

  	test "should redirect comment edit when not logged in" do
    	delete comment_path @comment
    	assert_redirected_to login_url
  	end

end
