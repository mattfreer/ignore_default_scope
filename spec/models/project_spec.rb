require 'spec_helper'

describe Project do
  let(:user) { User.create :user_name => "matt freer"}

  before(:each) do
    user.projects.create :name => "Foobar"
  end
  it { user.projects.count.should eq(1) }
  subject { user.projects.first }

  it { subject.name.should == "Foobar" }

  context "#creator" do
    it { subject.creator.present?.should be_true }
    it { subject.creator.should eq(user) }

    context "when creator is archived" do
      before do
        user.archived = true
        user.save
      end
      it { user.archived.should == true }
      it { subject.creator.present?.should be_false }

      context "with ignore_default_scope" do
        before do
          class Project
            ignore_default_scope :creator
          end
        end
        it{ subject.creator.present?.should be_true }
      end
    end
  end

end
