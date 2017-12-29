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

action :enable do
  monitoring_state(true)
end

action :disable do
  monitoring_state(false)
end

action_class do
  def monitoring_state(state)
    converge_by("Setting Defender status to #{state}") do
      cmd = powershell_out!("Set-MpPreference -DisableRealtimeMonitoring $#{state}", timeout: new_resource.timeout)
      Chef::Log.info(cmd.stdout)
      only_if enabled?
    end
  end
end
