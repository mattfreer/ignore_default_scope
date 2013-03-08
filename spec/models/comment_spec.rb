require 'spec_helper'

describe Comment do
  subject { comment_class.new() }
  let(:comment_class) { described_class }
  let(:user) { User.create(:user_name => "Matt Freer") }
  let(:author) { subject.reload.author }

  before(:each) do
    subject.author = user
    subject.save
  end

  context "user comment" do
    it { user.comments.count.should eq(1) }

    context "#author" do
      its("author") { should eq(user) }

      context "when user is archived" do
        let(:user) { User.create(:user_name => "Matt Freer") { |u| u.archived = true } }

        it { user.archived.should be_true }
        it { author.present?.should be_false }

        context "with ignore_default_scope" do
          let(:comment_class) {
            Comment.ignore_default_scope :author
            Comment
          }
          its("author.present?"){ should be_true }
        end
      end
    end
  end
end
