#
# Author:: Jordan Craig (<jordan@jwac.me>)
# Cookbook:: windows_defender
# Resource:: configure
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
include Chef::Property

property :timeout, Integer, default: 600
property :disable_block_first, [true, false], default: true
property :disable_catchup_scan, [true, false], default: true

action :configure do
  props = []
  return_properties.each do |p|
    props << p if property_is_set?(p)
  end
  configure(props)
end

action_class.class_eval do
  def configure(props)
    props.each do |p|
      cmd = powershell_out("Set-MpPreference -#{find_command(p)} $#{Property.get(p)}", timeout: new_resource.timeout)
      Chef::Log.info(cmd.to_s)
      Chef::Log.info(cmd.stdout)
    end
    only_if enabled?
  end
end
