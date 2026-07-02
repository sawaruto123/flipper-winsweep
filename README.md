# Flipper-HackSim

> A cinematic PowerShell hacking simulator for Flipper Zero BadUSB and Windows.

Flipper-HackSim is a Hollywood-style cyberattack simulator designed for entertainment, demonstrations, presentations, and prank scenarios. The script creates an immersive cyberpunk terminal experience featuring simulated network intrusions, fake privilege escalation, ransomware alerts, animated progress bars, and terminal effects.

**No real hacking, exploitation, malware installation, credential theft, persistence, or system modification is performed.**

---

## Features

### Cyberpunk Terminal Experience

- Full-screen terminal interface
- Animated boot sequence
- Glitch-text effects
- Dynamic typing animations
- Real-time progress bars
- Hollywood-style hacking visuals
- Interactive simulation flow

### Simulated Cyber Attack Sequence

Includes realistic-looking but completely fake:

- Network reconnaissance
- Firewall bypasses
- Privilege escalation
- Exploit deployment
- Reverse shell creation
- System enumeration
- Persistence installation
- Data exfiltration
- Ransomware attack
- System recovery

### Dynamic Visual Effects

- Randomized fake IP addresses
- Animated terminal output
- Color-coded warnings and alerts
- Progress tracking bars
- System breach notifications
- Recovery sequences

---

## Requirements

### Operating System

- Windows 10
- Windows 11

### Software

- PowerShell 5.0 or later

### Permissions

- Standard user permissions
- Administrator privileges not required

---

## Installation

Clone the repository:

```bash
git clone https://github.com/sawaruto123/flipper-hacksim.git
cd flipper-hacksim
```

Or download:

```text
hack_sim.ps1
```

---

## Usage

### PowerShell

```powershell
powershell -ExecutionPolicy Bypass -File .\hack_sim.ps1
```

### Flipper Zero BadUSB

1. Transfer `hack_sim.ps1` to the target machine.
2. Launch PowerShell using your BadUSB payload.
3. Execute:

```powershell
powershell -ExecutionPolicy Bypass -File hack_sim.ps1
```

4. Sit back and enjoy the show.

---

## Simulation Stages

### Stage 1 — Boot Sequence

```text
[BOOT] Loading kernel modules...
[BOOT] Initializing memory pools...
[NET] Establishing secure channel...
[AUTH] Spoofing MAC address...
[SCAN] Probing internal network...
```

### Stage 2 — Breach Sequence

```text
Bypassing Windows Defender
Extracting SAM hashes
Cracking NTLMv2
Establishing reverse shell
```

### Stage 3 — Security Alerts

```text
[ALERT] Unauthorized process detected
[ALERT] Firewall bypass successful
[WARN] Ransomware payload staged
```

### Stage 4 — Interactive Shell

```text
root@target:~# ps aux
root@target:~# netstat -anop tcp
root@target:~# wget payload.exe
root@target:~# ./payload.exe
```

### Stage 5 — System Enumeration

Displays simulated:

- Computer name
- User information
- Operating system
- Public IP address
- Local IP address
- Domain information
- Administrative privileges

### Stage 6 — Persistence Installation

```text
Installing backdoor...
Writing registry run key...
Injecting into svchost.exe...
Adding firewall exception...
```

### Stage 7 — Data Exfiltration

Simulated extraction of:

- Browser passwords
- Wi-Fi credentials
- Session tokens
- Screenshots
- Clipboard history

### Stage 8 — Ransomware Event

```text
***********************************************
*   WARNING: YOUR FILES HAVE BEEN ENCRYPTED   *
***********************************************
```

### Stage 9 — Recovery

```text
Payment detected!
Recovering files...
Restoring system integrity...
```

The simulation automatically restores the system and concludes without making any changes.

---

## Example Output

```text
══════════════════════════════════════════════════════════════

GHOST PROTOCOL v1.0
UNAUTHORIZED ACCESS TERMINAL

══════════════════════════════════════════════════════════════

[BOOT] Loading kernel modules...
[NET] Establishing secure channel...
[AUTH] Spoofing MAC address...

[INITIATING BREACH SEQUENCE]

Bypassing Windows Defender [████████████████████] 100%
Extracting SAM hashes      [████████████████████] 100%

>>> SYSTEM BREACH. FULL CONTROL ACQUIRED. <<<

[PERSIST] Installing backdoor...

>>> BACKDOOR ACTIVE. PERSISTENT ACCESS GUARANTEED. <<<

[EXFIL] Harvesting user data...

WARNING: YOUR FILES HAVE BEEN ENCRYPTED

[DECRYPT] Payment detected!

>>> SYSTEM RESTORED. NO PERMANENT DAMAGE. STAY SAFE. <<<
```

---

## Use Cases

- Flipper Zero demonstrations
- Cybersecurity presentations
- Classroom demonstrations
- Red-team themed showcases
- Convention displays
- Streaming content
- YouTube videos
- Entertainment and prank scenarios

---

## Safety Notice

Flipper-HackSim is a visual simulation only.

The script does **not**:

- Access personal files
- Open network connections
- Steal passwords
- Modify the registry
- Disable antivirus software
- Create persistence
- Encrypt files
- Install malware
- Download payloads
- Execute remote code

All hacking-related messages shown during execution are fictional and generated locally for entertainment purposes.

---

## Screenshots

Add screenshots or GIFs here:

```md
![Boot Sequence](images/boot-sequence.png)

![Breach Simulation](images/breach-sequence.png)

![Ransomware Alert](images/ransomware-alert.png)
```

---

## License

MIT License

Copyright (c) 2026 Wasi Syed

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software.
