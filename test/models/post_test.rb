require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
  	@post = posts(:one)
  end

  test "post should be valid" do
  	assert @post.valid?
  end

  test "post should be present" do
  	@post.content = " "
  	assert_not @post.valid?
  end

   test "content should not be too long" do
  	@post.content = "a"*256
  	assert_not @post.valid?
  end
end
