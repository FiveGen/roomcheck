require 'spec_helper'

describe "MakingCapybaraWorks" do
  describe "GET /making_capybara_works" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get check_lists_path
      response.status.should be(200)
      click_link "Edit"
    end
  end
end


describe "Checking edit button works" do
  describe "GET /check report problem page" do
    it "clicks on Report Problem link" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get check_lists_path
      response.status.should be(200)
      click_link "Report Problem"
    end
  end
end