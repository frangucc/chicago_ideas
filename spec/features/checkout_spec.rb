require 'spec_helper'

describe "Checking out", js: true do
  before do
    @member_type = FactoryGirl.create(:member_type)
    @year = Year.create(id: 2013)

    @sponsors = []
    TalkBrand.stub_chain(:find, :talks, :current, :order, :limit).and_return([])
    TalkBrand.stub_chain(:find, :talks, :current, :order, :limit).and_return([])
    User.stub_chain(:speaker, :not_deleted, :current, :order, :limit).and_return([])
    Year.stub(:find).and_return(double(:year))

    visit "/payment?member_id=#{@member_type.id}"
  end

  describe "With correct data" do
    it "should work", focus: true do
      @member_oc  = Member.count
      @user_oc    = User.count
      @address_oc = Address.count
      @order_oc   = Order.count

      response = double("response")
      response.stub(:success?).and_return(true)
      AuthorizeNet::AIM::Transaction.any_instance.stub(:purchase) { response }
      within("#new_order") do
        fill_in("Amount", :with => "100")
        fill_in("Name on card", with: "Jane Doe")
        fill_in("Card number", with: "370000000000002")
        fill_in("Exp Date", with: "1114")
        fill_in("CVC", with: "123")
        fill_in("order_billing_address_attributes_street_1", with: "Evergreen")
        fill_in("order_billing_address_attributes_city", with: "Springfield")
        select("Rhode Island", from: "order_billing_address_attributes_state")
        fill_in("order_billing_address_attributes_zip", with: "33123")
      end

      within("#personal") do
        fill_in("Email", with: "herp@example.com")
        fill_in("First name", with: "Herp")
        fill_in("Last name", with: "Testerson")
        fill_in("order_address_street_1", with: "Da Street")
        fill_in("order_address_city", with: "Da City")
        select("California", from: "order_address_state")
        fill_in("order_address_zip", with: "44123")
      end

      click_on("Confirm Purchase")

      Member.count.should   == (@member_oc  + 1)
      User.count.should     == (@user_oc    + 1)
      Address.count.should  == (@address_oc + 1)
      save_and_open_page
      page.should have_content @member_type.title
    end
  end
end