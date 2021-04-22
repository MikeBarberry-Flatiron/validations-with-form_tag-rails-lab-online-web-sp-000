RSpec.describe "authors/new", type: :feature do
  before(:each) { visit new_author_path }

  describe "a blank form" do
    it "does not render an error list" do
      expect(page).not_to have_selector("#error_explanation")
    end

    it "does not render error fields" do
      expect(page).not_to have_selector(".field_with_errors")
    end
  end

  context "invalid submissions" do
    let(:invalid_attributes) do
      { email: "bro@sbahj.info", phone_number: "555035995" }
    end

    before(:each) do
      Author.create(
        email: invalid_attributes[:email],
        name: "Valid",
        phone_number: "5550350001"
      )

      visit new_author_path
      fill_in "Email", with: invalid_attributes[:email]
      fill_in "Phone Number", with: invalid_attributes[:phone_number]
      click_button "Create"
    end


    it "prefills fields" do
      expect(find("input[name=name]").value).to be_empty
      expect(find("input[name=email]").value).to eq(invalid_attributes[:email])
      expect(find("input[name=phone_number]").value).to eq(invalid_attributes[:phone_number])
    end

  end
end
