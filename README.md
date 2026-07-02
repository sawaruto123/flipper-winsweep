# WinSweep – Neural Cleanse Protocol v2.2

> A cyberpunk-themed Windows cleanup utility designed for Flipper Zero BadUSB deployment and standalone PowerShell execution.

WinSweep provides an immersive terminal-style experience while performing system maintenance tasks such as removing temporary files, browser caches, Windows update leftovers, and other unnecessary data. The script delivers real-time progress updates and generates a final system status report upon completion.

---

## Features

### Immersive User Experience

* Animated startup sequence
* Cyberpunk-inspired terminal interface
* Dynamic status messages
* Progress tracking visualization
* Detailed completion report

### System Cleanup

The script performs the following cleanup operations:

* User temporary files
* Windows temporary files
* Windows Prefetch files
* Windows Update download cache
* Thumbnail cache
* Google Chrome cache
* Microsoft Edge cache
* Mozilla Firefox cache
* Recycle Bin contents
* DNS cache refresh
* Windows Event Logs

### System Reporting

After completion, WinSweep displays:

* Total storage recovered
* Available system memory
* System uptime
* Current user
* Computer name
* Execution timestamp

---

## Requirements

### Operating System

* Windows 10
* Windows 11

### Software

* PowerShell 5.0 or later

### Permissions

* Administrator privileges recommended
* Some cleanup tasks may be limited without elevated permissions

---

## Installation

Clone or download the repository:

```bash
git clone https://github.com/yourusername/winsweep.git
cd winsweep
```

Or simply download:

```text
clean.ps1
```

to your desired directory.

---

## Usage

### Standard PowerShell Execution

Open PowerShell and run:

```powershell
powershell -ExecutionPolicy Bypass -File .\clean.ps1
```

### Administrator Mode (Recommended)

```powershell
Start-Process powershell -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -File .\clean.ps1"
```

### Flipper Zero BadUSB Deployment

1. Transfer `clean.ps1` to the target machine.
2. Launch PowerShell through your BadUSB payload.
3. Execute:

```powershell
powershell -ExecutionPolicy Bypass -File clean.ps1
```

4. Allow the cleanup process to complete.

---

## Cleanup Targets

| Category             | Target                                                  |
| -------------------- | ------------------------------------------------------- |
| User Temp            | `%TEMP%`                                                |
| Windows Temp         | `C:\Windows\Temp`                                       |
| Prefetch             | `C:\Windows\Prefetch`                                   |
| Windows Update Cache | `C:\Windows\SoftwareDistribution\Download`              |
| Thumbnail Cache      | `%LOCALAPPDATA%\Microsoft\Windows\Explorer`             |
| Chrome Cache         | `%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache`  |
| Edge Cache           | `%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache` |
| Firefox Cache        | `%APPDATA%\Mozilla\Firefox\Profiles\*\cache2`           |
| Recycle Bin          | System Recycle Bin                                      |
| DNS Cache            | Local DNS Resolver                                      |
| Event Logs           | Windows Event Viewer Logs                               |

---

## Example Output

```text
[BOOTING NEURAL CLEANSE PROTOCOL...]

> Scanning Temp Files
> Purging Browser Cache
> Clearing Windows Update Residue
> Flushing DNS Cache
> Removing Event Logs

====================================
NEURAL CLEANSE COMPLETE
====================================

Storage Recovered : 3.42 GB
Available RAM     : 12.8 GB
System Uptime     : 4 Days 12 Hours
User              : Administrator
Machine           : DESKTOP-XXXXXXX

STATUS: CLEAN
```

---

## Notes

* Browser cache locations may vary depending on installed browser versions.
* Some files may remain if actively used by running applications.
* Administrator privileges improve cleanup coverage.
* Event log clearing may be restricted by system policy.
* Storage recovery estimates depend on file accessibility and permissions.

---

## Disclaimer

This script is intended for system maintenance, educational purposes, and authorized administrative use.

Always review scripts before executing them on production systems. Test in a controlled environment when possible. The author assumes no responsibility for data loss, configuration changes, or unintended consequences resulting from the use of this software.

---

## License

MIT License

Copyright (c) 2026 Wasi Syed

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software.
