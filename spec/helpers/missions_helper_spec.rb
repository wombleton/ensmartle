require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MissionsHelper do

  def p s
    helper.parse(s)
  end

  it "should accept 3d6 as 3 dice" do
    parse = p("3d6")
    parse.should_not be_nil
    parse.is_roll?.should be_true
    parse.dice.should eql(3)
  end

  it "should accept 100d6 as 100 dice" do
    p("100d6").dice.should eql(100)
  end

  it "should accept 3d6! as exploded dice" do
    parse = p("3d6!")
    parse.should_not be_nil
    parse.is_roll?.should be_true
    parse.dice.should eql(3)
    parse.explode?.should be_true
  end

  it "should treat 3d6 as not exploded dice" do
    p("3d6").explode?.should be_false
  end

  it "should accept ! as exploding a previous roll"

  it "should accept Ob3 as setting an obstacle of 3"

  it "should accept Hildred: Quote as a quote of 'Quote'"

  it "should accept Goal: foo as setting a goal"

  it "should accept A/D/F as scripting three actions of A, D, F"

  it "should accept D=9 as setting your disposition to 9"

  it "should accept D-2 as modifying your disposition by 2"

  it "should accept anything else as a comment"
end