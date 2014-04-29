require 'spec_helper'

describe "viewing the home page" do
  before(:each) do
    visit root_path
  end

  context "as a user" do
    it "should not have a link to the admin path" do
      expect(page).not_to have_link("Admin", :href => rails_admin_path)
    end
  end
end

describe "viewing the admin dashboard" do
  before(:each) do
    visit rails_admin_path
  end

  context "as a user not logged in" do
    it "should redirect to the sign in page" do
      expect(page).to have_content('Sign in')
      expect(current_path).to eq '/users/sign_in'
    end
  end
end
