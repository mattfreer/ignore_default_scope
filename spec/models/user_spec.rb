require 'spec_helper'
require 'timecop'

describe User do
  def create_user
    User.create :user_name => "Matt Freer"
  end

  subject { create_user }

  it "user name" do
    subject.user_name.should == "Matt Freer"
  end

  describe "archived user" do
    before do
      @time = Date.today
      Timecop.freeze(@time)
      subject.archived = true
      subject.save
    end

    it "subject is archived" do
      subject.archived.should == true
      subject.deleted_at.should == @time
    end

    it "should be removed from default scope" do
      User.count.should == 0
    end
  end
end
