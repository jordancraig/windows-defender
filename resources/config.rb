#
# Author:: Jordan Craig (<jordan@jwac.me>)
# Cookbook:: windows_defender
# Resource:: config
#
# Copyright:: 2011-2017, Business Intelligence Associates, Inc
# Copyright:: 2017, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include Chef::Mixin::PowershellOut
include WindowsDefender::Helper

property :timeout, Integer, default: 600

action :enable_monitoring do
  monitoring_state(true)
end

action :disable_monitoring do
  monitoring_state(false)
end

action :enable_feature do
  enable_defender
end

action_class do
  def install_feature_cmdlet
    node['os_version'].to_f < 6.2 ? 'Import-Module ServerManager; Add-WindowsFeature' : 'Install-WindowsFeature'
  end

  def remove_feature_cmdlet
    node['os_version'].to_f < 6.2 ? 'Import-Module ServerManager; Remove-WindowsFeature' : 'Uninstall-WindowsFeature'
  end

  def monitoring_state(state)
    cmd = powershell_out("Set-MpPreference -DisableRealtimeMonitoring $#{state}", timeout: new_resource.timeout)
    Chef::Log.info(cmd.stdout)
    only_if enabled?
  end

  def enable_defender
    cmd = if node['os_version'].to_f < 6.2
            powershell_out!("#{install_feature_cmdlet} WindowsDefender", timeout: new_resource.timeout)
          else
            powershell_out!("#{install_feature_cmdlet} WindowsDefender", timeout: new_resource.timeout)
          end
    Chef::Log.info(cmd.stdout)
  end

  def disable_defender
    cmd = if node['os_version'].to_f < 6.2
            powershell_out!("#{remove_feature_cmdlet} WindowsDefender", timeout: new_resource.timeout)
          else
            powershell_out!("#{remove_feature_cmdlet} WindowsDefender", timeout: new_resource.timeout)
          end
    Chef::Log.info(cmd.stdout)
  end
end
