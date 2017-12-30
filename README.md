# Windows Defender
[![Build status](https://ci.appveyor.com/api/projects/status/6sqy0tv3allk79d3?svg=true)](https://ci.appveyor.com/project/jordancraig/windows-defender)

Provides a set of specific resources that can be used to manage Windows Defender on supported systems.

## Requirements

### Platforms
- Windows 2016
- Windows 2012R2
- Windows 2012
- Windows 10
- Windows 8.1
- Windows 8

*** Supported on 2012R2 Core and other 2012 systems with Desktop Experience enabled. ***

### Chef
- Chef 12.7+

## Usage

### Configure Resource


#### Properties
##### check_for_signature
`Boolean: true | false`
Indicates whether to check for new virus and spyware definitions before Windows Defender runs a scan. If you specify a value of $True, Windows Defender checks for new definitions. If you specify $False or do not specify a value, the scan begins with existing definitions. This value applies to scheduled scans and to scans that you start from the command line, but it does not affect scans that you start from the user interface.

##### disable_archive_scanning
`Boolean: true | false`
Indicates whether to scan archive files, such as .zip and .cab files, for malicious and unwanted software. If you specify a value of $True or do not specify a value, Windows Defender scans archive files.

##### disable_auto_exclusions
`Boolean: true | false`
Indicates whether to disable the Automatic Exclusions feature for the server.

##### disable_behavioural_monitoring
`Boolean: true | false`
Indicates whether to enable behavior monitoring. If you specify a value of $True or do not specify a value, Windows Defender enables behavior monitoring.

##### disable_catchup_full_scan
`Boolean: true | false`
Indicates whether Windows Defender runs catch-up scans for scheduled full scans. A computer can miss a scheduled scan, usually because the computer is turned off at the scheduled time. If you specify a value of $True, after the computer misses two scheduled full scans, Windows Defender runs a catch-up scan the next time someone logs on to the computer. If you specify a value of $False or do not specify a value, the computer does not run catch-up scans for scheduled full scans.
