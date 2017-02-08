require 'test_helper'

class GroupBeforeLoginTestTest < ActionDispatch::IntegrationTest
    def setup
    	@group = groups(:pace)
    end
    test "should redirect group index when not logged in" do
    	get groups_path
    	assert_redirected_to login_url
  	end

  	test "should redirect group show when not logged in" do
    	get group_path @group
    	assert_redirected_to login_url
  	end

  	test "should redirect group new when not logged in" do
    	get new_group_path
    	assert_redirected_to login_url
  	end

  	test "should redirect group edit when not logged in" do
    	delete group_path @group
    	assert_redirected_to login_url
  	end

end
