# Flipper-WinSweep

> Cyberpunk-themed Windows cleanup utility for Flipper Zero BadUSB and PowerShell.

WinSweep is a Windows maintenance and cleanup utility wrapped in a cinematic cyberpunk terminal experience. Designed for Flipper Zero BadUSB deployments and standalone PowerShell execution, it removes temporary files, browser caches, update residue, and other system clutter while providing immersive visual feedback and cleanup statistics.

---

## Features

### Neural Cleanse Interface

- Animated boot sequence
- Cyberpunk-inspired terminal UI
- Dynamic status messages
- Progress tracking
- Cleanup analytics
- System health summary

### System Cleanup

WinSweep automatically cleans:

- User Temp Files
- Windows Temp Files
- Windows Prefetch Cache
- Windows Update Download Cache
- Thumbnail Cache
- Google Chrome Cache
- Microsoft Edge Cache
- Mozilla Firefox Cache
- Recycle Bin
- DNS Resolver Cache
- Windows Event Logs

### Post-Cleanup Report

After execution, WinSweep displays:

- Total space recovered
- Available memory
- System uptime
- Current user
- Machine name
- Execution timestamp

---

## Requirements

### Operating System

- Windows 10
- Windows 11

### Software

- PowerShell 5.0+

### Permissions

- Administrator privileges recommended
- Some cleanup operations may be limited without elevation

---

## Installation

Clone the repository:

```bash
git clone https://github.com/sawaruto123/flipper-winsweep.git
cd flipper-winsweep
```

Or download:

```text
clean.ps1
```

---

## Usage

### PowerShell

```powershell
powershell -ExecutionPolicy Bypass -File .\clean.ps1
```

### Administrator Mode

```powershell
Start-Process powershell -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -File .\clean.ps1"
```

### Flipper Zero BadUSB

1. Transfer `clean.ps1` to the target machine.
2. Launch PowerShell using your BadUSB payload.
3. Execute:

```powershell
powershell -ExecutionPolicy Bypass -File clean.ps1
```

4. Allow the cleanup sequence to complete.

---

## Cleanup Targets

| Category | Target |
|-----------|-----------|
| User Temp | `%TEMP%` |
| Windows Temp | `C:\Windows\Temp` |
| Prefetch | `C:\Windows\Prefetch` |
| Windows Update Cache | `C:\Windows\SoftwareDistribution\Download` |
| Thumbnail Cache | `%LOCALAPPDATA%\Microsoft\Windows\Explorer` |
| Chrome Cache | `%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache` |
| Edge Cache | `%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache` |
| Firefox Cache | `%APPDATA%\Mozilla\Firefox\Profiles\*\cache2` |
| Recycle Bin | System Recycle Bin |
| DNS Cache | Windows DNS Resolver |
| Event Logs | Windows Event Viewer Logs |

---

## Example Output

```text
═══════════════════════════════════════════════════════

NEURAL CLEANSE PROTOCOL v2.2

═══════════════════════════════════════════════════════

[SCAN] Temporary Files
[SCAN] Browser Cache
[SCAN] Windows Update Residue
[SCAN] Event Logs

[CLEAN] Purging Temp Files...
[CLEAN] Clearing Browser Cache...
[CLEAN] Flushing DNS Resolver...

═══════════════════════════════════════════════════════

NEURAL CLEANSE COMPLETE

Storage Recovered : 3.42 GB
Available RAM     : 12.8 GB
System Uptime     : 4 Days 12 Hours
Machine           : DESKTOP-XXXXXXX

STATUS : CLEAN
```

---

## Why WinSweep?

Unlike traditional cleanup scripts, WinSweep combines practical Windows maintenance with an immersive operator experience.

Benefits include:

- Faster removal of temporary files
- Recovery of wasted storage space
- Reduced browser cache bloat
- Removal of Windows Update leftovers
- Cleaner system maintenance workflow
- Flipper Zero friendly deployment

---

## Notes

- Browser cache paths may vary between versions.
- Running browsers may lock active cache files.
- Administrator privileges improve cleanup coverage.
- Storage recovery depends on system state and permissions.
- Event log cleanup may be restricted by policy.

---

## Disclaimer

This project is intended for authorized system maintenance, education, and administrative use.

Always review scripts before executing them in production environments. Test thoroughly before deployment. The author assumes no responsibility for data loss, configuration issues, or unintended consequences resulting from the use of this software.

---

## License

MIT License

Copyright (c) 2026 Wasi Syed
