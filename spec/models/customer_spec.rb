require 'spec_helper'

describe Customer do
  subject { described_class.new(:fullname => 'Ian Smith', :email => "ian@smith.com") }

  context "#save" do
    before :each do
      subject.save
    end

    context "#cutomer_no" do
      its("customer_no") { should =~ /\A(cust_)\d/ }
    end
  end
end
