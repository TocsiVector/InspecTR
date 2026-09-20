<div align="center">

# 🛡️ InspecTR

### `Security Inspection & Enumeration Tool`

<p>
  <img src="https://img.shields.io/badge/Linux-Security-00ff9d?style=for-the-badge&logo=linux&logoColor=white" />
  <img src="https://img.shields.io/badge/Bash-3.0-00ff9d?style=for-the-badge&logo=gnubash&logoColor=white" />
  <img src="https://img.shields.io/badge/CTF-Ready-111827?style=for-the-badge&logo=tryhackme&logoColor=red" />
  <img src="https://img.shields.io/badge/Authorized-Only-111827?style=for-the-badge&logo=hackthebox&logoColor=00ff9d" />
</p>

<p>
  <img src="https://img.shields.io/github/license/TocsiVector/InspecTR?style=flat-square&label=License" />
  <img src="https://img.shields.io/github/stars/TocsiVector/InspecTR?style=flat-square&label=Stars" />
  <img src="https://img.shields.io/github/last-commit/TocsiVector/InspecTR?style=flat-square&label=Last%20Commit" />
  <img src="https://img.shields.io/github/repo-size/TocsiVector/InspecTR?style=flat-square&label=Repo%20Size" />
</p>

<br>

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=22&duration=2200&pause=900&color=00FF9D&center=true&vCenter=true&width=850&lines=Linux+Security+Inspection;System+Enumeration;Privilege+%26+Permission+Review;Network+%26+Service+Inspection;CTF+%7C+eJPT+%7C+OSCP+Learning;Inspect.+Enumerate.+Understand." />

<br><br>

```text
        ╔══════════════════════════════════════════════╗
        ║                                              ║
        ║              🛡️  I N S P E C T R             ║
        ║                                              ║
        ║       SECURITY INSPECTION ENGINE             ║
        ║                                              ║
        ║      INSPECT  →  ENUMERATE  →  REPORT       ║
        ║                                              ║
        ╚══════════════════════════════════════════════╝
```

</div>

---

## 🛡️ About InspecTR

**InspecTR** is a Bash-based Linux security inspection and enumeration assistant designed to systematically collect security-relevant information from Linux systems.

It helps organize a manual Linux enumeration workflow into a structured process.

```text
                    ┌────────────────────────┐
                    │        InspecTR        │
                    │ Security Inspector CLI │
                    └───────────┬────────────┘
                                │
        ┌───────────────────────┼───────────────────────┐
        │                       │                       │
        ▼                       ▼                       ▼
   🖥️ SYSTEM                👤 USERS                🌐 NETWORK
        │                       │                       │
        ▼                       ▼                       ▼
   ⚙️ SERVICES            🔐 PERMISSIONS            🔑 SSH
        │                       │                       │
        ▼                       ▼                       ▼
   📦 PACKAGES             ⚡ PROCESSES              ⏰ CRON
        │                       │                       │
        └───────────────────────┼───────────────────────┘
                                │
                                ▼
                       🔎 SECURITY LEADS
                                │
                                ▼
                           📝 REPORT
```

### Core workflow

```text
┌────────────┐
│  INSPECT   │
└─────┬──────┘
      ↓
┌────────────┐
│ ENUMERATE  │
└─────┬──────┘
      ↓
┌────────────┐
│ FIND LEADS │
└─────┬──────┘
      ↓
┌────────────┐
│ MANUAL     │
│ REVIEW     │
└─────┬──────┘
      ↓
┌────────────┐
│   REPORT   │
└────────────┘
```

---

# ⚡ Features

<table>
<tr>
<td width="50%">

### 🖥️ System Inspection

- Hostname
- Operating system
- Kernel
- Architecture
- Uptime
- CPU information
- RAM information
- Disk information

</td>

<td width="50%">

### 👤 Users & Groups

- Current user
- UID / GID
- Local users
- Local groups
- Logged-in users
- Recent login information
- `/etc/passwd`
- `/etc/group`

</td>
</tr>

<tr>
<td>

### 🔐 Permission Inspection

- Sudo configuration
- SUID files
- SGID files
- Linux capabilities
- Writable directories
- Writable PATH directories
- Ownership and permissions

</td>

<td>

### ⚙️ Process Inspection

- Running processes
- Root-owned processes
- CPU-heavy processes
- Memory-heavy processes
- Process information

</td>
</tr>

<tr>
<td>

### 🔧 Service Enumeration

- Running services
- Enabled services
- Systemd information
- Systemd timers
- Listening services

</td>

<td>

### 🌐 Network Inspection

- Network interfaces
- IP addresses
- Routing table
- Neighbor information
- DNS configuration
- Listening ports
- Active connections

</td>
</tr>

<tr>
<td>

### 🔑 SSH Inspection

- SSH service
- SSH configuration
- `.ssh` directory
- `authorized_keys`
- SSH-related information

</td>

<td>

### ⏰ Scheduled Tasks

- User crontab
- `/etc/cron.d`
- Daily cron
- Hourly cron
- Weekly cron
- Monthly cron
- Systemd timers

</td>
</tr>

<tr>
<td>

### 📦 Package Inspection

- Package manager
- Installed package count
- Security-related utilities
- Common development utilities
- Common networking tools

</td>

<td>

### 🧪 Environment Inspection

- `$PATH`
- `$SHELL`
- Environment information
- `.bashrc`
- `.profile`
- Shell configuration

</td>
</tr>

</table>

---

# 🎯 Assessment Modes

InspecTR provides multiple workflows for different learning and assessment scenarios.

```text
╔════════════════════════════════════════════════════╗
║                    INSPECTR MODES                  ║
╠════════════════════════════════════════════════════╣
║                                                    ║
║  [1] CTF MODE              Challenge Enumeration   ║
║  [2] eJPT MODE             Linux Security Labs    ║
║  [3] OSCP MODE             Deep Enumeration       ║
║  [4] BUG HUNTING           Basic Web Recon        ║
║  [5] GENERAL LINUX         System Inspection      ║
║  [6] FULL SCAN             Complete Inspection    ║
║                                                    ║
╚════════════════════════════════════════════════════╝
```

---

# 🧪 CTF Mode

Designed for authorized CTF and challenge environments.

```text
SYSTEM
   ↓
USERS
   ↓
FILESYSTEM
   ↓
NETWORK
   ↓
SERVICES
   ↓
PERMISSIONS
   ↓
SCHEDULED TASKS
   ↓
INTERESTING FILES
   ↓
FLAG SEARCH
```

Common challenge patterns include:

```text
flag*
*flag*
user.txt
root.txt
```

Use this mode only in authorized CTF environments.

---

# 🎓 eJPT Mode

The eJPT-oriented workflow focuses on Linux enumeration fundamentals.

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

The purpose is to help understand the information that should be collected during an authorized assessment.

---

# 🔴 OSCP Mode

The OSCP-oriented workflow performs broader Linux enumeration.

```text
┌──────────────────────────────┐
│         OSCP MODE            │
├──────────────────────────────┤
│ System                       │
│ Users                        │
│ Filesystem                   │
│ Permissions                  │
│ Processes                    │
│ Services                     │
│ Network                      │
│ SSH                          │
│ Scheduled Tasks              │
│ Environment                  │
│ Packages                     │
│ Interesting Files            │
└──────────────────────────────┘
```

The results are intended for manual investigation.

---

# 🌐 Bug Hunting Mode

Provides basic authorized web reconnaissance.

```text
TARGET
  ↓
DNS RESOLUTION
  ↓
HTTP / HTTPS INFORMATION
  ↓
RESPONSE HEADERS
  ↓
robots.txt
```

This mode is intentionally reconnaissance-oriented and does not automatically exploit targets.

Only use it against assets that are explicitly within your authorized scope.

---

# 🔎 General Linux Mode

General Linux mode provides broad local system inspection.

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
- Security labs
- CTF preparation
- System inspection
- Enumeration practice

---

# 🚀 Full Security Scan

Full Scan combines the major inspection modules.

```text
                  FULL SCAN
                     │
       ┌─────────────┼─────────────┐
       │             │             │
       ▼             ▼             ▼
    SYSTEM         USERS        NETWORK
       │             │             │
       ▼             ▼             ▼
 PERMISSIONS     PROCESSES     SERVICES
       │             │             │
       └─────────────┼─────────────┘
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
         SSH        CRON     PACKAGES
          │          │          │
          └──────────┼──────────┘
                     ▼
               ENVIRONMENT
                     │
                     ▼
             INTERESTING FILES
                     │
                     ▼
                  REPORT
```

---

# 📊 Security-Relevant Findings

InspecTR identifies information that may deserve manual security review.

Example:

```text
[HIGH-INTEREST] Sudo permission requires review.

[REVIEW] SUID executable detected.

[REVIEW] SGID executable detected.

[REVIEW] Linux capability detected.

[REVIEW] Writable PATH directory detected.

[REVIEW] Sensitive file permissions require review.
```

### Important

InspecTR does **not** automatically classify every finding as a vulnerability.

The intended workflow is:

```text
Finding
   ↓
Manual Validation
   ↓
Context Analysis
   ↓
Security Decision
```

This prevents enumeration output from being confused with confirmed vulnerabilities.

---

# 📝 Report Generation

InspecTR can generate assessment reports.

```text
inspectr_reports/
│
└── report_<hostname>_<timestamp>.txt
```

Example:

```text
inspectr_reports/
└── report_kali_20260920_174500.txt
```

Reports can contain:

- Host information
- Current user
- Selected mode
- Enumeration results
- Security-relevant findings
- Command output
- Assessment timestamps

---

# 🖥️ CLI

Run InspecTR:

```bash
./inspectr.sh
```

The interactive interface provides:

```text
╔══════════════════════════════════════════════════╗
║                  I N S P E C T R                 ║
║        Security Inspection & Enumeration        ║
╚══════════════════════════════════════════════════╝

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

# ⚙️ Installation

### 1. Clone

```bash
git clone https://github.com/TocsiVector/InspecTR.git
```

### 2. Enter directory

```bash
cd InspecTR
```

### 3. Make executable

```bash
chmod +x inspectr.sh
```

### 4. Run

```bash
./inspectr.sh
```

---

# 🧰 Command Options

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

# 📂 Project Structure

```text
InspecTR/
│
├── inspectr.sh
├── README.md
└── LICENSE
```

Runtime reports:

```text
inspectr_reports/
└── report_<hostname>_<timestamp>.txt
```

---

# 🧠 Design Philosophy

InspecTR is built around one principle:

> **Understand the system before attempting to act on it.**

The tool emphasizes:

```text
     VISIBILITY
         ↓
     ENUMERATION
         ↓
    INFORMATION
         ↓
   MANUAL ANALYSIS
         ↓
      DECISION
```

It is an **inspection and enumeration assistant**, not an automatic exploitation framework.

---

# 🛡️ Security Philosophy

```text
┌──────────────────────────────────────────┐
│              INSPECTR                    │
├──────────────────────────────────────────┤
│                                          │
│  ✓ Inspect                               │
│  ✓ Enumerate                             │
│  ✓ Collect                               │
│  ✓ Document                              │
│  ✓ Review                                │
│                                          │
│  ✗ No automatic exploitation             │
│  ✗ No credential attacks                 │
│  ✗ No persistence                        │
│  ✗ No destructive actions                │
│                                          │
└──────────────────────────────────────────┘
```

---

# 🧪 Example Workflow

```text
┌──────────────────────┐
│ Start Authorized Lab │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│ Launch InspecTR      │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│ Select Assessment    │
│ Mode                 │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│ Collect Information  │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│ Review Findings      │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│ Generate Report      │
└──────────────────────┘
```

---

# 🧩 Technology

| Component | Details |
|---|---|
| Language | Bash |
| Platform | Linux |
| Interface | CLI |
| Architecture | Single-file utility |
| Reporting | TXT |
| Version | 3.0 |
| License | MIT |

---

# 🗺️ Roadmap

### Current Foundation

```text
████████████████████████████████████████ 100%
```

- [x] Interactive CLI
- [x] System inspection
- [x] User enumeration
- [x] Group enumeration
- [x] Filesystem inspection
- [x] Permission inspection
- [x] SUID / SGID inspection
- [x] Linux capability inspection
- [x] Process enumeration
- [x] Service enumeration
- [x] Network inspection
- [x] SSH inspection
- [x] Scheduled-task inspection
- [x] Package inspection
- [x] Environment inspection
- [x] Interesting-file inspection
- [x] CTF flag search
- [x] Basic authorized web reconnaissance
- [x] Multiple assessment modes
- [x] TXT report generation
- [x] Help option
- [x] Version option

### Future Development

- [ ] Improved modular architecture
- [ ] Better report formatting
- [ ] More configurable scan profiles
- [ ] Additional Linux security checks
- [ ] Improved dependency handling
- [ ] Automated testing
- [ ] Extended documentation
- [ ] Release packaging

---

# 📌 Version

```text
╔══════════════════════════════════════╗
║             InspecTR v3.0            ║
╠══════════════════════════════════════╣
║ Language : Bash                      ║
║ Platform : Linux                     ║
║ Type     : Security Enumeration      ║
║ Interface: CLI                       ║
╚══════════════════════════════════════╝
```

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

# 👨‍💻 Author

<div align="center">

### TocsiVector

**Cybersecurity • Linux • Offensive Security • Security Research**

<br>

<a href="https://github.com/TocsiVector">
<img src="https://img.shields.io/badge/GitHub-TocsiVector-111827?style=for-the-badge&logo=github&logoColor=white" />
</a>

</div>

---

# 📜 License

InspecTR is released under the **MIT License**.

See [`LICENSE`](LICENSE) for details.

---

# ⭐ Support

If InspecTR is useful for your learning, CTFs, labs, or authorized security assessments:

```text
⭐ Star
🐛 Report bugs
💡 Suggest improvements
🔧 Contribute
📚 Share feedback
```

---

<div align="center">

<br>

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=18&duration=2500&pause=1000&color=00FF9D&center=true&vCenter=true&width=700&lines=Inspect.;Enumerate.;Understand.;Report." />

<br><br>

```text
╔══════════════════════════════════════════╗
║                                          ║
║              🛡️ InspecTR                ║
║                                          ║
║     Inspect. Enumerate. Understand.      ║
║                                          ║
╚══════════════════════════════════════════╝
```

**Built for Learning • CTFs • Labs • Authorized Security Assessments**

</div>
