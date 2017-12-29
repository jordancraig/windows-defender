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

property :timeout, Integer, default: 600
property :preference, String

action :status do
  return_status
end

action_class do
  def return_status
    cmd = powershell_out!('Get-MpComputerStatus', timeout: new_resource.timeout)
    if cmd.stderr.include? 'extrinsic'
      Chef::Log.error('Defender is disabled. Enable using the enable recipe.')
    elseif cmd.stderr.empty?
      Chef::Log.info(cmd.stdout)
    end
  end

  def return_preference(preference)
    cmd = powershell_out!("Get-MpPreference -#{preference}", timeout: new_resource.timeout)
    Chef::Log.info(cmd.stdout)
  end
end
