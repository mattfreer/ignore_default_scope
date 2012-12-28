require 'spec_helper'

describe Comment do
  let(:user) do
    User.new :user_name => "Matt Freer" do |u|
      u.save
    end
  end

  context "user comment" do
    before(:each) do
      user.comments.create()
    end

    it { user.comments.count.should eq(1) }
    subject { user.comments.first }

    context "#author" do
      it { subject.author.should eq(user) }

      context "when user is archived" do
        before :each do
          user.archived = true
          user.save
        end
        it { user.archived.should == true }
        it { subject.author.present?.should be_false }

        context "with ignore_default_scope" do
          before(:each) do
            class Comment
              ignore_default_scope :author
            end
          end
          it{ subject.author.present?.should be_true }
        end
      end
    end
  end
end
