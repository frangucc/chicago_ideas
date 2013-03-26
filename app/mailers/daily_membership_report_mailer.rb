class DailyMembershipReportMailer < ActionMailer::Base

  helper :application

  default :from    => ApplicationHelper::CIW_MEMBERSHIP_EMAIL
  default :subject => "Daily Membership Report"

  def daily_report
    @last_order = Order.last_order_created_today

    Order.generate_members_stats_excel
    Member.generate_current_year_members_excel

    members_list_file_name  = "Member_list_#{Time.current.year}.csv"
    members_stats_file_name = "Member_stats_#{Time.current.year}.csv"

    attachments[members_list_file_name]  = File.read("/tmp/#{members_list_file_name}")
    attachments[members_stats_file_name] = File.read("/tmp/#{members_stats_file_name}")

    mail(:to => ApplicationHelper::DAILY_REPORT_RECIPIENTS)
  end

end
