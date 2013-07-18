require 'spec_helper'

describe Agreement do

  let(:agreer) { FactoryGirl.create(:micropost) }
  let(:agreed) { FactoryGirl.create(:micropost) }
  let(:agreement) { agreer.agreements.build(agreed_id: agreed.id) }

  subject { agreement }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to agreer_id" do
      expect do
        Agreement.new(agreer_id: agreer.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "agreer methods" do    
    it { should respond_to(:agreer) }
    it { should respond_to(:agreed) }
    its(:agreer) { should == agreer }
    its(:agreed) { should == agreed }
  end

  describe "when agreed id is not present" do
    before { agreement.agreed_id = nil }
    it { should_not be_valid }
  end

  describe "when agreer id is not present" do
    before { agreement.agreer_id = nil }
    it { should_not be_valid }
  end

end