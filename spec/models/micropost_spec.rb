require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:agreements) }
  it { should respond_to(:agreed_microposts)}
  it { should respond_to(:reverse_agreements) }
  it { should respond_to(:agreers) }
  it { should respond_to(:agreeing?) }
  it { should respond_to(:agree!) }
  its(:user) { should == user }

  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @micropost.content = "a" * 14001 }
    it { should_not be_valid }
  end

  describe "agreeing" do
    let(:other_micropost) { FactoryGirl.create(:micropost) }    
    before do
      @micropost.save
      @micropost.agree!(other_micropost)
    end

    it { should be_agreeing(other_micropost) }
    its(:agreed_microposts) { should include(other_micropost) }
    
    describe "agreed micropost" do
      subject { other_micropost }
      its(:agreers) { should include(@micropost) }
    end

    describe "and unagreeing" do
      before { @micropost.unagree!(other_micropost) }

      it { should_not be_agreeing(other_micropost) }
      its(:agreed_microposts) { should_not include(other_micropost) }
    end
  end
end
