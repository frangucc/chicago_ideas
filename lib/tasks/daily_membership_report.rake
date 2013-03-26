desc "Send daily membership report mailer"
task :send_daily_report => :environment do
  DailyMembershipReportMailer.daily_report.deliver
end
