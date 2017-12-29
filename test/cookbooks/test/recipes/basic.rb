# Check that status returns a value.
windows-defender_status 'Return Defender status' do
  action :status
end
