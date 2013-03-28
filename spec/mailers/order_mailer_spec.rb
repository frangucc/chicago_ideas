require "spec_helper"

describe OrderMailer do

  describe '#thank_you_membership' do

    let(:order) { FactoryGirl.build(:order) }

    before do
      OrderMailer.thank_you_membership(order).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it 'sends proper headers' do
      @email.subject.should == "Thank you for joining CIW's Member Program"
      @email.from[0].should == 'forms@chicagoideas.com'
      @email.to[0].should   == order.user.email
    end

    it 'sends proper content' do
      @email.body.should match(/Thank you for joining CIW's Member Program/)
      @email.body.should match(/Dear, #{order.name_on_card}/)
      @email.body.should match(/Included in your #{order.member_type.title} Member package you receive/)
      [:specific_benefits, :general_benefits].each do |benefit|
        order.member_type.try(benefit).split("\r\n").reject { |i| i.empty? }.each do |line|
          @email.body.should match(/#{line}/)
        end
      end
    end

  end

  #describe '#notify_member_purchase' do

    #let(:order) { FactoryGirl.build(:order) }

    #before do
      #OrderMailer.notify_member_purchase(order).deliver
      #@email = ActionMailer::Base.deliveries.last
    #end

    #it 'sends proper headers' do
      #@email.subject.should == "Someone just purchased a membership!"
      #@email.from[0].should == "forms@chicagoideas.com"
      #@email.to[0].should   == "membership@chicagoideas.com"
    #end

    #it 'email has proper content' do
      #@email.body.should match(/Hello CIW,/)
      #@email.body.should match(/Someone just purchased a membership\! Click/)
      #@email.body.should have_link("here", :href => admin_member_url(order.user.member))
      #@email.body.should match(/to view the purchase\./)
    #end

  #end

end
