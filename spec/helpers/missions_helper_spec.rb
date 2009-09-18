require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MissionsHelper do

  def p s
    helper.parse(s)
  end

  it "should accept 3d6 as 3 dice" do
    parse = p("3d6")
    parse.should_not be_nil
    parse.dice.should eql(3)
    parse.event_type.should eql("roll")
  end

  it "should accept 100d6 as 100 dice" do
    p("100d6").dice.should eql(100)
  end

  it "should accept 3d6! as exploded dice" do
    parse = p("3d6!")
    parse.should_not be_nil
    parse.dice.should eql(3)
    parse.explode?.should be_true
  end

  it "should treat 3d6 as not exploded dice" do
    p("3d6").explode?.should be_false
  end

  it "should accept ! as exploding a previous roll" do
    p("!").explode?.should be_true
  end

  it "should accept Ob3 as setting an obstacle of 3" do
    p("Ob3").obstacle.should eql(3)
  end

  it "should accept Hildred: Quote as a quote of 'Quote'" do
    parse = p("Hildred: Quote")
    parse.speaker.should eql("Hildred")
    parse.quote.should eql("Quote")
  end

  it "should accept Goal: foo as setting a goal" do
    parse = p("Goal: foo")
    parse.goal.should eql("foo")
  end

  it "should accept A/D/F as scripting three actions of A, D, F" do
    parse = p("A/D/F")
    parse.v1.should eql("A")
    parse.v2.should eql("D")
    parse.v3.should eql("F")
  end

  it "should accept D=9 as setting your disposition to 9" do
    p("D=9").disposition.should eql(9)
  end

  it "should accept D-2 as modifying your disposition by 2" do
    p("D-2").adjust_disposition.should eql(-2)
  end

  it "should accept D+2 as modifying your disposition by 2" do
    p("D+2").adjust_disposition.should eql(2)
  end

  it "should accept anything else as a comment" do
    p("blah blah blah").other.should eql("blah blah blah")

  end
end