require "spec_helper"

describe DailyMembershipReportMailer do

  describe '#daily_report' do

    CURRENT_YEAR = Time.current.year

    before do
      Order.stub(:generate_members_stats_excel)
      Member.stub(:generate_current_year_members_excel)
      ["Member_list_#{CURRENT_YEAR}.csv", "Member_stats_#{CURRENT_YEAR}.csv"].each do |file_name|
        CSV.open("/tmp/#{file_name}", "wb")
      end
      DailyMembershipReportMailer.daily_report.deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it 'sends proper headers' do
      @email.subject.should   == 'Daily Membership Report'
      @email.from[0].should   == 'membership@chicagoideas.com'
      @email.to.should        == ['user@domain.com']
    end

    it 'sends proper attachments' do
      @email.attachments.count.should == 2
      @email.attachments.collect { |a| a.content_type }.to_set.should == ["text/csv; filename=Member_list_#{CURRENT_YEAR}.csv", "text/csv; filename=Member_stats_#{CURRENT_YEAR}.csv"].to_set
    end

  end

end
