$global:progressPreference = 'SilentlyContinue'

describe 'test::config' {
  context 'windows_defender_config' {
    it "Scans should be set to run on Sundays" {
      (Get-MpPreference | Select -ExpandProperty ScanScheduleDay) | should be 7
    }
  }
}
