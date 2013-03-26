every 1.days do

  # rebuild the sphinx index, used for the search feature
  rake "fs:index"

end

every :day, :at => "11:30pm" do
  rake send_daily_report
end
