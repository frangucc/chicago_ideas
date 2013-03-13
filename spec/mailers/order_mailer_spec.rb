require "spec_helper"

describe OrderMailer do

  describe '#thank_you_membership' do

    let(:order) { FactoryGirl.build(:order) }

    before(:each) do
      OrderMailer.thank_you_membership(order).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it 'email has proper headers' do
      @email.subject.should == "Thank you for joining CIW's Member Program"
      @email.from[0].should == 'forms@chicagoideas.com'
      @email.to[0].should   == order.user.email
    end

    it 'email has proper content' do
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

end
