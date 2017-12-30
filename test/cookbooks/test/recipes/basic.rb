# Enable Defender feature
windows_defender_config 'enable' do
  action :enable_feature
end
# Check that status returns a value.
windows_defender_status 'status' do
  action :check_enabled
end

# Check when scans run.
windows_defender_status 'scan schedule' do
  action :scanday
end

# Set scans to run on Sundays
windows_defender_config 'scan on sundays' do
  action :scanday
  day 7
end
