require 'spec_helper'

describe Project do
  subject { project_class.create(:name => "Foobar") }
  let(:project_class) { described_class }
  let(:user) { User.create(:user_name => "matt freer") }
  let(:creator) { subject.reload.creator }

  before(:each) do
    subject.creator_id = user.id
    subject.save
  end

  context "projects" do
    it { user.projects.all.size.should eq(1) }
    its("name") { should == "Foobar" }

    context "#creator" do
      its("creator.present?") { should be_true }
      its("creator") { should eq(user) }

      context "when creator is archived" do
        before do
          user.archived = true
          user.save
        end
        it { user.archived.should be_true }
        it { creator.present?.should be_false }

        context "with ignore_default_scope" do
          let(:project_class) {
            Project.ignore_default_scope :creator
            Project
          }

          its("creator.present?") { should be_true }
        end
      end
    end
  end
end
