# Check that status returns a value.
windows_defender_status 'status' do
  action :status
end