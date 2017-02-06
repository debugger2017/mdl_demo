require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  
  def setup
  	@group = groups(:pace)
  end

  test "should be valid" do 
  	assert @group.valid?
  end

  test "name should be present" do
  	@group.name = "   "
  	assert_not @group.valid? 
  end

  test "names should be unique" do
    duplicate_group = @group.dup
    duplicate_group.name = @group.name
    @group.save
    assert_not duplicate_group.valid?
  end

  test "name should be of minimum length" do
    @group.name = " " * 7
    assert_not @group.valid?
  end
end
