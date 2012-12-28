require 'spec_helper'

describe Customer do
  subject { Customer.new :fullname => 'Ian Smith', :email => "ian@smith.com"}

  context "#save" do
    before :each do
      subject.save
    end

    context "#cutomer_no" do
      it { subject.customer_no.should =~ /\A(cust_)\d/ }
    end
  end
end
