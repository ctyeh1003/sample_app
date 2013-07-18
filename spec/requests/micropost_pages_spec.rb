require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end

#  describe "micropost show page" do
    

#    describe "agree/unagree buttons" do 
 #     let (:other_micropost) {FactoryGirl.create(:micropost) }
  #    before { visit micropost_path(other_micropost)}
#
 #     describe "create new agreeing micropost" do
  #      let (:new_micropost) {FactoryGirl.create(:micropost) }



  describe "agreeing/agreers" do
    let(:micropost) { FactoryGirl.create(:micropost) }
    let(:other_micropost) { FactoryGirl.create(:micropost) }
    before { micropost.agree!(other_micropost) }

    describe "agreed micropost" do
      before do
        visit agreeing_micropost_path(micropost)
      end

      it { should have_selector('title', text: full_title('Agreeing')) }
      it { should have_selector('h3', text: 'Agreeing') }
      it { should have_link(other_micropost.content, href: micropost_path(other_micropost)) }
    end

    describe "agreers" do
      before do
        visit agreers_micropost_path(other_micropost)
      end

      it { should have_selector('title', text: full_title('Agreers')) }
      it { should have_selector('h3', text: 'Agreers') }
      it { should have_link(micropost.content, href: micropost_path(micropost)) }
    end
  end
end
