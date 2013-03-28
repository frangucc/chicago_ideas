class DailyMembershipReportMailer < ActionMailer::Base

  helper :application

  default :from    => ApplicationHelper::CIW_MEMBERSHIP_EMAIL
  default :subject => "Daily Membership Report"

  def daily_report
    Order.generate_members_stats_excel
    Member.generate_current_year_members_excel

    members_list_file_name  = "Member_list_#{current_time.year}_#{current_time.strftime("%m-%d-%Y")}.csv"
    members_stats_file_name = "Member_stats_#{current_time.year}_#{current_time.strftime("%m-%d-%Y")}.csv"

    attachments[members_list_file_name]  = File.read("/tmp/#{members_list_file_name}")
    attachments[members_stats_file_name] = File.read("/tmp/#{members_stats_file_name}")

    mail(:to => ApplicationHelper::DAILY_REPORT_RECIPIENTS)
  end

  private

  def current_time
    Time.current
  end

end
