#
# Author:: Jordan Craig (<jordan@jwac.me>)
# Cookbook:: windows_defender
# Resource:: helper
#
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

module WindowsDefender
  module Helper
    $days = %w(Everyday Monday Tuesday Wednesday Thursday Friday Saturday Sunday Never)

    def enabled?
      @enabled ||= begin
        cmd = if node['os_version'].to_f < 6.2
                powershell_out('Import-Module ServerManager; @(Get-WindowsFeature Windows-Defender | ?{$_.Installed -ne $TRUE}).count', 600)
              else
                powershell_out('@(Get-WindowsFeature Windows-Defender | ?{$_.InstallState -ne \'Installed\'}).count', 600)
              end
        cmd.stderr.empty? && cmd.stdout.chomp.to_i == 0
      end
    end
  end
end

Chef::Recipe.send(:include, WindowsDefender::Helper)
