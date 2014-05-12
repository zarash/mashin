set :output, "#{path}/log/cron.log"

every 3.hours do
  rake "scrap"
end

every "0 1,2,4,5,7,8,10,11,13,14,16,17,18,19,20,22,23 * * *" do
  rake "triger_scrap"
end

every 2.days do
  rake "clear_scrapdb"
end

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
  
# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
