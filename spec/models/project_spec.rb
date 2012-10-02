require 'spec_helper'

describe Project do
  def create_project(creator)
    creator.projects.build :name => "Foobar"
  end

  let(:user) { User.create :user_name => "matt freer"}
  subject { create_project(user) }

  it "name" do
    subject.name.should == "Foobar"
  end

  it "should have a creator" do
    subject.should respond_to(:creator)
    subject.creator.present?.should be_true
  end

  describe "creator is archived" do
    before do
      user.archived = true
      user.save
    end

    it "should have a creator" do
      subject.creator.present?.should be_true
    end
  end
end
