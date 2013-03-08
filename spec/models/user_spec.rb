require 'spec_helper'
require 'timecop'

describe User do
  subject { described_class.create :user_name => "Matt Freer" }

  its("user_name") { should eq("Matt Freer") }

  describe "archived user" do
    before do
      @time = Date.today
      Timecop.freeze(@time)
      subject.archived = true
      subject.save
    end

    its("archived") { should be_true }
    its("deleted_at") { @time }

    it "should be removed from default scope" do
      User.count.should == 0
    end
  end
end
