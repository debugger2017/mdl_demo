require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
  	@comment = comments(:one)
  end

  test "comment should be valid" do
  	assert @comment.valid?
  end

  test "comment should be present" do
  	@comment.content = " "
  	assert_not @comment.valid?
  end

  test "content should not be too long" do
  	@comment.content = "a"*256
  	assert_not @comment.valid?
  end
end
