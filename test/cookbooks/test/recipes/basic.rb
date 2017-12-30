# Enable Defender feature
windows_defender_config 'enable' do
  action :enable
end

# Check that status returns a value.
windows_defender_status 'status' do
  action :check_enabled
end
