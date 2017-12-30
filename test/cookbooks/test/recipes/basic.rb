# Test new resource
windows_defender_configure 'disable_catchup_scan' do
  action :configure
  disable_catchup_scan false
end
