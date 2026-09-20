<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:020617,50:0f172a,100:111827&height=220&section=header&text=InspecTR&fontSize=72&fontColor=00ff9d&animation=fadeIn&fontAlignY=35&desc=Security%20Inspection%20%26%20Enumeration%20Tool&descAlignY=58&descSize=18" width="100%"/>

<br>

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=20&duration=2800&pause=900&color=00FF9D&center=true&vCenter=true&width=800&lines=Linux+Security+Inspection;System+Enumeration;Privilege+%26+Permission+Review;Network+%26+Service+Inspection;CTF+%7C+eJPT+%7C+OSCP+Learning;Inspect.+Enumerate.+Understand." />

<br><br>

<img src="https://img.shields.io/badge/Platform-Linux-111827?style=for-the-badge&logo=linux&logoColor=white"/>
<img src="https://img.shields.io/badge/Language-Bash-111827?style=for-the-badge&logo=gnubash&logoColor=white"/>
<img src="https://img.shields.io/badge/Version-3.0-111827?style=for-the-badge&logo=github&logoColor=00ff9d"/>
<img src="https://img.shields.io/badge/License-MIT-111827?style=for-the-badge&logo=opensourceinitiative&logoColor=white"/>

<br>

<img src="https://img.shields.io/badge/CTF-Ready-111827?style=for-the-badge&logo=tryhackme&logoColor=red"/>
<img src="https://img.shields.io/badge/Authorized%20Assessment-Only-111827?style=for-the-badge&logo=hackthebox&logoColor=00ff9d"/>
<img src="https://img.shields.io/github/stars/TocsiVector/InspecTR?style=for-the-badge&logo=github&label=Stars"/>
<img src="https://img.shields.io/github/last-commit/TocsiVector/InspecTR?style=for-the-badge&logo=git&label=Last%20Commit"/>

</div>

---

# 🛡️ InspecTR

> **Security Inspection & Enumeration Tool**

**InspecTR** is a single-file Bash-based Linux security inspection and enumeration assistant designed to systematically collect security-relevant information from Linux systems.

It is intended for:

- 🧪 Security labs
- 🎯 CTF environments
- 📚 Cybersecurity learning
- 🐧 Linux security practice
- 🔐 Authorized security assessments
- 🛠️ Systems you own or have explicit permission to assess

InspecTR focuses on **enumeration, inspection, evidence collection, and reporting** rather than automatic exploitation.

---

## ⚡ What is InspecTR?

InspecTR helps turn a manual Linux enumeration workflow into a structured process.

```text
                         ┌─────────────────────┐
                         │      InspecTR       │
                         │  Security Inspector │
                         └──────────┬──────────┘
                                    │
                ┌───────────────────┼───────────────────┐
                │                   │                   │
                ▼                   ▼                   ▼
          🖥️ System            👤 Users            🌐 Network
                │                   │                   │
                ▼                   ▼                   ▼
          ⚙️ Services         🔐 Permissions        🔑 SSH
                │                   │                   │
                ▼                   ▼                   ▼
          📦 Packages         ⚡ Processes           ⏰ Cron
                │                   │                   │
                └───────────────────┼───────────────────┘
                                    │
                                    ▼
                          📊 Security-Relevant
                              Findings / Leads
                                    │
                                    ▼
                              📝 Report
```

The goal is simple:

```text
Inspect → Enumerate → Identify Leads → Review → Report
```

---

# ✨ Features

### 🖥️ System Information

Collects basic host information including:

- Hostname
- Kernel information
- Architecture
- Uptime
- Operating system information
- Memory usage
- Disk usage

---

### 👤 Users & Groups

Inspects:

- Current user identity
- UID/GID
- Logged-in users
- Recent logins
- Local users
- Local groups
- `/etc/passwd`
- `/etc/group`
- Readability of `/etc/shadow` where applicable

---

### 📂 Filesystem & Storage

Inspects:

- Mounted filesystems
- Disk usage
- Important directories
- `/`
- `/etc`
- `/home`
- `/tmp`
- `/var`
- `/opt`
- `/usr`
- `/root`

---

### 🔐 Permissions & Privileges

Reviews security-relevant permission information such as:

- `sudo`
- SUID files
- SGID files
- Linux file capabilities
- Writable directories
- Writable PATH directories
- Permission-related leads

> InspecTR reports these as **review leads**, not automatic vulnerability verdicts.

---

### ⚙️ Process Enumeration

Collects:

- Running processes
- CPU-heavy processes
- Memory-heavy processes
- Root-owned processes

---

### 🔧 Services & Systemd

Inspects:

- Running services
- Enabled services
- Systemd timers
- Listening services
- Listening network sockets

---

### 🌐 Network Inspection

Collects:

- Network interfaces
- IP addresses
- Routing table
- Neighbor table
- DNS configuration
- Listening TCP/UDP ports
- Established connections

---

### 🔑 SSH Inspection

Checks:

- SSH listener information
- SSH configuration
- Current user's `.ssh` directory
- `authorized_keys` presence

---

### ⏰ Scheduled Tasks

Inspects:

- Current user's crontab
- `/etc/cron.d`
- `/etc/cron.daily`
- `/etc/cron.hourly`
- `/etc/cron.weekly`
- `/etc/cron.monthly`
- Systemd timers

---

### 📦 Package & Software Information

Checks:

- APT availability
- Installed package count
- Common security/development utilities

Common tools checked include:

```text
nmap
curl
wget
python3
python
perl
gcc
git
ssh
nc
netcat
```

---

### 🧪 Environment Inspection

Reviews:

- `$PATH`
- `$SHELL`
- Selected environment variable names
- `.bashrc`
- `.bash_profile`
- `.profile`

It also checks for writable PATH directories that may deserve manual review.

---

### 📄 Interesting Files

Checks common Linux files including:

```text
/etc/passwd
/etc/group
/etc/hosts
/etc/hostname
/etc/resolv.conf
/etc/fstab
```

It also samples readable configuration-style files from selected directories.

---

# 🎯 CTF Mode

CTF Mode is designed for authorized challenge environments.

It combines:

```text
System
   ↓
Users
   ↓
Network
   ↓
Services
   ↓
Permissions
   ↓
Scheduled Tasks
   ↓
Interesting Files
   ↓
Flag Search
```

The flag-search functionality looks for common challenge naming patterns such as:

```text
flag*
*flag*
user.txt
root.txt
```

and selected flag-like text patterns.

> ⚠️ Use this functionality only inside an authorized CTF or challenge environment.

---

# 🎓 eJPT Mode

The eJPT-oriented workflow focuses on Linux enumeration fundamentals:

```text
System
   ↓
Users
   ↓
Network
   ↓
Services
   ↓
Packages
   ↓
SSH
   ↓
Permissions
```

This mode is intended as a learning and enumeration assistant rather than an exploitation framework.

---

# 🔴 OSCP Mode

The OSCP-oriented workflow performs deeper Linux enumeration across:

```text
System
Users
Filesystem
Permissions
Processes
Services
Network
SSH
Scheduled Tasks
Environment
Packages
Interesting Files
```

The results are intended for manual analysis and further investigation inside an authorized environment.

---

# 🌐 Bug Hunting Mode

Bug Hunting Mode provides **basic authorized web reconnaissance**.

The user supplies an authorized domain or host.

It can perform:

```text
Target
  ↓
DNS Resolution
  ↓
HTTP/HTTPS Headers
  ↓
HTTP Metadata
  ↓
robots.txt
```

The mode is intentionally limited to basic reconnaissance.

> ⚠️ Only use it against domains or hosts that are explicitly inside your authorized scope.

---

# 🔍 General Linux Mode

General Mode provides a broad Linux information collection workflow:

```text
System
Users
Filesystem
Processes
Services
Network
Packages
SSH
Scheduled Tasks
Environment
```

Useful for:

- Linux learning
- Lab environments
- Security practice
- Initial system inspection

---

# 🚀 Full Security Scan

Full Scan combines the major local enumeration modules.

```text
┌─────────────────────────────┐
│     FULL INSPECTR SCAN      │
└──────────────┬──────────────┘
               │
               ├── System
               ├── Users
               ├── Filesystem
               ├── Permissions
               ├── Processes
               ├── Services
               ├── Network
               ├── SSH
               ├── Scheduled Tasks
               ├── Packages
               ├── Environment
               └── Interesting Files
```

> ⚠️ Full scans may take longer on systems with large filesystems.

---

# 📊 Security Findings

InspecTR can identify **security-relevant leads** that deserve manual review.

Examples include:

```text
[HIGH-INTEREST] Non-interactive sudo permission may be available.

[REVIEW] SUID executables detected.

[REVIEW] File capabilities detected.

[REVIEW] Writable PATH directory detected.

[REVIEW] /etc/shadow readable.
```

These messages should **not automatically be interpreted as vulnerabilities**.

The purpose is to help the assessor identify areas requiring further investigation.

```text
Enumeration Finding
        ↓
Manual Validation
        ↓
Context Analysis
        ↓
Security Decision
```

---

# 📝 Reporting

Each assessment can generate a report inside:

```text
./inspectr_reports/
```

Report naming follows:

```text
report_<hostname>_<timestamp>.txt
```

Example:

```text
inspectr_reports/
└── report_kali_20260920_174500.txt
```

Reports contain information such as:

- InspecTR version
- Host
- User
- Selected mode
- Start time
- Creation time
- Enumeration sections
- Command output
- Security-relevant leads

---

# 🖥️ Main Menu

Running InspecTR without arguments opens the interactive menu:

```text
============================================================
                         INSPECTR
============================================================

Security Inspection & Enumeration Tool

==================== MAIN MENU ====================

1) CTF Mode
2) eJPT Mode
3) OSCP Mode
4) Bug Hunting Mode
5) General Linux Mode
6) Full Security Scan
7) Help
8) Exit

INSPECTR >
```

---

# ⚙️ Requirements

InspecTR is designed for Linux environments with Bash.

Recommended environments:

- Kali Linux
- Debian
- Ubuntu
- Other compatible Linux distributions

Some functionality depends on utilities being available on the host.

InspecTR checks for command availability and reports when a required command is unavailable.

---

# 📥 Installation

Clone the repository:

```bash
git clone https://github.com/TocsiVector/InspecTR.git
```

Enter the directory:

```bash
cd InspecTR
```

Make the script executable:

```bash
chmod +x inspectr.sh
```

Run:

```bash
./inspectr.sh
```

---

# ▶️ Usage

### Interactive mode

```bash
./inspectr.sh
```

### Help

```bash
./inspectr.sh --help
```

or:

```bash
./inspectr.sh -h
```

### Version

```bash
./inspectr.sh --version
```

or:

```bash
./inspectr.sh -v
```

---

# 📁 Project Structure

```text
InspecTR/
│
├── inspectr.sh
├── LICENSE
└── README.md
```

Runtime reports are created separately:

```text
inspectr_reports/
└── report_<hostname>_<timestamp>.txt
```

---

# 🧠 Design Philosophy

InspecTR follows a simple security workflow:

```text
                    ┌───────────────┐
                    │    INSPECT    │
                    └───────┬───────┘
                            ↓
                    ┌───────────────┐
                    │   ENUMERATE   │
                    └───────┬───────┘
                            ↓
                    ┌───────────────┐
                    │  FIND LEADS   │
                    └───────┬───────┘
                            ↓
                    ┌───────────────┐
                    │ MANUAL REVIEW │
                    └───────┬───────┘
                            ↓
                    ┌───────────────┐
                    │    REPORT     │
                    └───────────────┘
```

InspecTR is intentionally designed around **visibility and understanding**, not automatic exploitation.

---

# 🛡️ Security Philosophy

InspecTR follows these principles:

```text
✓ Inspect
✓ Enumerate
✓ Collect
✓ Document
✓ Review manually

✗ No automatic exploitation
✗ No credential attacks
✗ No persistence
✗ No destructive actions
```

The tool should be used as an enumeration and inspection assistant.

---

# ⚠️ Legal & Responsible Use

InspecTR is intended only for:

- Systems you own
- Systems you have explicit permission to assess
- Authorized penetration-testing engagements
- CTF platforms
- Cybersecurity labs
- Educational environments

Do **not** use InspecTR against systems, networks, domains, or infrastructure without authorization.

The user is responsible for ensuring that their use of the tool complies with applicable laws, rules, and authorization requirements.

---

# 🧪 Example Workflow

A basic Linux lab workflow can look like:

```text
1. Start the authorized Linux lab
          ↓
2. Launch InspecTR
          ↓
3. Select General / eJPT / OSCP / CTF
          ↓
4. Review enumeration output
          ↓
5. Inspect security-relevant leads
          ↓
6. Review generated report
          ↓
7. Perform manual investigation
```

---

# 🔬 Example

```bash
chmod +x inspectr.sh
./inspectr.sh
```

Then:

```text
INSPECTR > 6
```

for:

```text
Full Security Scan
```

After completion:

```text
Report:
./inspectr_reports/report_<hostname>_<timestamp>.txt
```

---

# 🧩 Technology

| Component | Technology |
|---|---|
| Language | Bash |
| Platform | Linux |
| Interface | CLI |
| Architecture | Single-file utility |
| Reporting | TXT |
| Target | Authorized Linux systems / labs |
| Current Version | 3.0 |

---

# 🗺️ Roadmap

Current foundation:

```text
[████████████████████████████████████████] 100%
```

### Current

- [x] Single-file Bash architecture
- [x] Interactive CLI
- [x] Colored terminal output
- [x] System inspection
- [x] User/group enumeration
- [x] Filesystem inspection
- [x] Permission inspection
- [x] Process enumeration
- [x] Service enumeration
- [x] Network inspection
- [x] SSH inspection
- [x] Scheduled-task inspection
- [x] Package information
- [x] Environment inspection
- [x] Interesting-file inspection
- [x] CTF flag search
- [x] Basic authorized web reconnaissance
- [x] Multiple assessment modes
- [x] TXT report generation
- [x] `--help`
- [x] `--version`

### Future Development

- [ ] Improved module architecture
- [ ] Better report formatting
- [ ] More configurable scan profiles
- [ ] Additional Linux security checks
- [ ] Improved dependency detection
- [ ] Extended documentation
- [ ] Automated testing
- [ ] Release packaging

> Roadmap items are planned development goals and may change.

---

# 🧱 Architecture

```text
                    INSPECTR
                       │
                       ▼
                 CLI Controller
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
      Modes         Inspection       Reporting
        │              │              │
        │              ├─ System      │
        │              ├─ Users       │
        │              ├─ Filesystem  │
        │              ├─ Permissions │
        │              ├─ Processes   │
        │              ├─ Services    │
        │              ├─ Network     │
        │              ├─ SSH         │
        │              ├─ Cron        │
        │              ├─ Packages    │
        │              └─ Environment │
        │                             │
        └─────────────────────────────┤
                                      ▼
                               TXT Report
```

---

# 🎨 Terminal Experience

InspecTR includes terminal-oriented visual feedback such as:

```text
[+] Section
────────────────────────────────────────────────────────────

[*] Collecting information...

[>] System [########################]

[✓] Completed

[!] Review required

[✗] Error
```

The script also adapts its color output depending on whether the output is attached to a terminal.

---

# 📌 Version

```text
InspecTR v3.0
```

Current implementation:

```text
Language : Bash
Type     : Linux Security Inspection & Enumeration
Interface: CLI
```

---

# 👨‍💻 Author

<div align="center">

### TocsiVector

Cybersecurity | Linux | Offensive Security | Security Research

<br>

<a href="https://github.com/TocsiVector">
<img src="https://img.shields.io/badge/GitHub-TocsiVector-111827?style=for-the-badge&logo=github&logoColor=white"/>
</a>

</div>

---

# 📜 License

This project is licensed under the **MIT License**.

See the [`LICENSE`](LICENSE) file for details.

---

# ⭐ Support the Project

If you find InspecTR useful for learning, CTFs, labs, or authorized security assessment:

- ⭐ Star the repository
- 🐛 Report reproducible bugs
- 💡 Suggest improvements
- 🔧 Contribute improvements
- 📚 Share feedback

---

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:020617,50:0f172a,100:111827&height=140&section=footer&text=Inspect.%20Enumerate.%20Understand.&fontSize=26&fontColor=00ff9d&animation=fadeIn" width="100%"/>

### 🛡️ InspecTR

**Security Inspection & Enumeration Tool**

`Built for learning • CTFs • Labs • Authorized Security Assessments`

</div>
