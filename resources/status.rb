#
# Author:: Jordan Craig (<jordan@jwac.me>)
# Cookbook:: windows_defender
# Resource:: status
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
property :preference, String

action :check_enabled do
  Chef::Log.info("Windows Defender enabled status is currently: #{enabled?}")
end

action :status do
  guard_interpreter :powershell_script
  only_if enabled?
  return_status
end

action :scanday do
  preference = new_resource.preference
  scan_day(preference)
end

action_class do
  def return_status
    if enabled?
      cmd = powershell_out('Get-MpComputerStatus | Select -ExpandProperty RealTimeProtectionEnabled', timeout: new_resource.timeout)
      Chef::Log.info(cmd.stdout)
    else
      Chef::Log.warn('Defender not enabled.')
    end
  end

  def scan_day(preference)
    days = %w(Everyday Monday Tuesday Wednesday Thursday Friday Saturday Sunday Never)
    cmd = powershell_out("Get-MpPreference | Select -ExpandProperty #{preference}", timeout: new_resource.timeout)
    Chef::Log.info(days[cmd.stdout])
    only_if enabled?
  end
end
