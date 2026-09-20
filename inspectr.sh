#!/usr/bin/env bash
# ============================================================================
# INSPECTR
# Security Inspection & Enumeration Tool
# Single-file Bash utility for authorized labs, CTFs and systems you own.
# Version 3.0
# ============================================================================

VERSION="3.0"
APP="INSPECTR"
TAGLINE="Security Inspection & Enumeration Tool"
REPORT_DIR="./inspectr_reports"
REPORT_FILE=""
MODE=""
START_TIME="$(date '+%Y-%m-%d %H:%M:%S')"
HOST="$(hostname 2>/dev/null || printf 'unknown')"
USER_NAME="$(id -un 2>/dev/null || printf 'unknown')"

# ---- Colors (disabled automatically when stdout is not a TTY) ----
if [[ -t 1 ]]; then
    RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
    BLUE='\033[0;34m'; CYAN='\033[0;36m'; MAGENTA='\033[0;35m'
    WHITE='\033[1;37m'; GRAY='\033[0;37m'; NC='\033[0m'
else
    RED=''; GREEN=''; YELLOW=''; BLUE=''; CYAN=''; MAGENTA=''; WHITE=''; GRAY=''; NC=''
fi

# ---- Runtime safety / compatibility ----
export LC_ALL=C
umask 077

command_exists() { command -v "$1" >/dev/null 2>&1; }

say() { printf '%b\n' "$*"; }
separator() { say "${CYAN}────────────────────────────────────────────────────────────${NC}"; }
title() { echo; say "${BLUE}════════════════════════════════════════════════════════════${NC}"; say "${WHITE}$1${NC}"; say "${BLUE}════════════════════════════════════════════════════════════${NC}"; }
section() { echo; say "${MAGENTA}[+] $1${NC}"; separator; }
success() { say "${GREEN}[✓] $1${NC}"; }
warning() { say "${YELLOW}[!] $1${NC}"; }
error_msg() { say "${RED}[✗] $1${NC}"; }
info() { say "${CYAN}[*] $1${NC}"; }
pause_screen() { echo; read -r -p "Press Enter to continue..." _; }

loading() {
    local msg="$1"
    printf '%b' "${CYAN}${msg}${NC}"
    for _ in 1 2 3; do printf '.'; sleep 0.12; done
    echo
}

progress() {
    local msg="$1"
    printf '%b' "${CYAN}[>] ${msg} [${NC}"
    for _ in {1..24}; do printf '%b' "${GREEN}#${NC}"; sleep 0.015; done
    printf '%b\n' "${CYAN}]${NC}"
}

banner() {
    clear 2>/dev/null || true
    say "${CYAN}██╗███╗   ██╗███████╗██████╗ ███████╗ ██████╗████████╗██████╗${NC}"
    say "${CYAN}██║████╗  ██║██╔════╝██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔══██╗${NC}"
    say "${CYAN}██║██╔██╗ ██║███████╗██████╔╝█████╗  ██║        ██║   ██████╔╝${NC}"
    say "${CYAN}██║██║╚██╗██║╚════██║██╔═══╝ ██╔══╝  ██║        ██║   ██╔══██╗${NC}"
    say "${CYAN}██║██║ ╚████║███████║██║     ███████╗╚██████╗   ██║   ██║  ██║${NC}"
    say "${CYAN}╚═╝╚═╝  ╚═══╝╚══════╝╚═╝     ╚══════╝ ╚═════╝   ╚═╝   ╚═╝  ╚═╝${NC}"
    echo
    say "${WHITE}              ${TAGLINE}${NC}"
    say "${GRAY}Version : ${VERSION} | Host: ${HOST} | User: ${USER_NAME}${NC}"
    say "${GRAY}Started : ${START_TIME}${NC}"
    echo
}

safe_name() {
    printf '%s' "$1" | tr -cs '[:alnum:]._-' '_' | cut -c1-80
}

create_report() {
    mkdir -p "$REPORT_DIR" || { error_msg "Cannot create report directory: $REPORT_DIR"; return 1; }
    local ts host_safe
    ts="$(date '+%Y%m%d_%H%M%S')"
    host_safe="$(safe_name "$HOST")"
    REPORT_FILE="${REPORT_DIR}/report_${host_safe}_${ts}.txt"
    {
        echo "===================================================================="
        echo "$APP - $TAGLINE"
        echo "===================================================================="
        echo "Version : $VERSION"
        echo "Host    : $HOST"
        echo "User    : $USER_NAME"
        echo "Mode    : $MODE"
        echo "Started : $START_TIME"
        echo "Created : $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Report  : $REPORT_FILE"
        echo "===================================================================="
        echo
    } > "$REPORT_FILE"
    success "Report: $REPORT_FILE"
}

report() {
    [[ -n "$REPORT_FILE" ]] && printf '%s\n' "$1" >> "$REPORT_FILE"
}

run_capture() {
    # Usage: run_capture "Section title" command args...
    local label="$1"; shift
    section "$label"
    report "### $label"
    report "Command: $*"
    if [[ "$#" -eq 0 ]]; then
        warning "No command supplied."
        return 1
    fi
    if command_exists "$1"; then
        "$@" 2>&1 | tee -a "${REPORT_FILE:-/dev/null}"
    else
        warning "Command not available: $1"
        report "[NOT AVAILABLE] $1"
    fi
    echo
}

run_shell_capture() {
    # Only for fixed, internally-defined pipelines; do not pass untrusted input.
    local label="$1"; shift
    section "$label"
    report "### $label"
    report "Command: $*"
    bash -c "$*" 2>&1 | tee -a "${REPORT_FILE:-/dev/null}"
    echo
}

# ---------------------------------------------------------------------------
# Findings: informational leads, not automatic vulnerability verdicts.
# ---------------------------------------------------------------------------
findings_header() {
    section "INSPECTR FINDINGS / LEADS"
    say "${GRAY}These are enumeration leads. Validate them manually in the authorized lab.${NC}"
}

collect_findings() {
    findings_header
    local count=0
    if command_exists sudo && sudo -n -l >/tmp/inspectr_sudo.$$ 2>/dev/null; then
        if grep -qE 'NOPASSWD|\(ALL|\(root' /tmp/inspectr_sudo.$$; then
            say "${YELLOW}[HIGH-INTEREST]${NC} Non-interactive sudo permission may be available."
            report "[HIGH-INTEREST] Review sudo -n -l output."
            count=$((count+1))
        fi
        cat /tmp/inspectr_sudo.$$ >> "${REPORT_FILE:-/dev/null}" 2>/dev/null || true
        rm -f /tmp/inspectr_sudo.$$
    fi
    if find / -xdev -type f -perm -4000 -print -quit 2>/dev/null | grep -q .; then
        say "${YELLOW}[REVIEW]${NC} SUID executables exist; review unusual entries."
        report "[REVIEW] SUID executables detected."
        count=$((count+1))
    fi
    if command_exists getcap && getcap -r / 2>/dev/null | grep -q .; then
        say "${YELLOW}[REVIEW]${NC} File capabilities detected; review security-sensitive binaries."
        report "[REVIEW] File capabilities detected."
        count=$((count+1))
    fi
    if [[ -n "${PATH:-}" ]]; then
        IFS=: read -r -a path_parts <<< "$PATH"
        for d in "${path_parts[@]}"; do
            [[ -z "$d" || ! -d "$d" ]] && continue
            if [[ -w "$d" ]]; then
                say "${YELLOW}[REVIEW]${NC} Writable PATH directory: $d"
                report "[REVIEW] Writable PATH directory: $d"
                count=$((count+1))
            fi
        done
    fi
    say "${CYAN}Lead count: $count${NC}"
}

system_information() {
    title "SYSTEM INFORMATION"
    run_capture "Basic System" hostname
    run_capture "Kernel" uname -a
    run_capture "Architecture" uname -m
    run_shell_capture "Uptime" 'uptime 2>/dev/null || true'
    if [[ -r /etc/os-release ]]; then
        run_shell_capture "Operating System" "grep -E '^(PRETTY_NAME|NAME|VERSION|ID|VERSION_ID)=' /etc/os-release"
    else
        warning "/etc/os-release not found."
    fi
    run_capture "Memory" free -h
    run_capture "Disk Usage" df -h
}

user_information() {
    title "USERS & GROUPS"
    run_capture "Current Identity" id
    run_capture "Logged-in Users" who
    run_capture "Recent Logins" last -n 10
    if [[ -r /etc/passwd ]]; then run_shell_capture "Local Users" "cut -d: -f1,3,4,6,7 /etc/passwd"; fi
    if [[ -r /etc/group ]]; then run_shell_capture "Groups" "cut -d: -f1,3,4 /etc/group"; fi
    [[ -r /etc/shadow ]] && say "${YELLOW}[REVIEW]${NC} /etc/shadow is readable by current context." && report "[REVIEW] /etc/shadow readable."
}

filesystem_information() {
    title "FILESYSTEM & STORAGE"
    if command_exists findmnt; then run_capture "Mounts" findmnt; else run_capture "Mounts" mount; fi
    run_capture "Disk Usage" df -h
    for d in / /etc /home /tmp /var /opt /usr /root; do
        [[ -d "$d" ]] || continue
        say "${CYAN}$d${NC} -> $(ls -ld "$d" 2>/dev/null)"
    done
    report "### Important directories inspected: / /etc /home /tmp /var /opt /usr /root"
}

permission_information() {
    title "PERMISSIONS & PRIVILEGES"
    if command_exists sudo; then
        run_capture "Sudo Policy (non-interactive)" sudo -n -l
    else warning "sudo is not installed."; fi
    run_shell_capture "SUID Files (same filesystem)" 'find / -xdev -type f -perm -4000 -print 2>/dev/null | sort'
    run_shell_capture "SGID Files (same filesystem)" 'find / -xdev -type f -perm -2000 -print 2>/dev/null | sort'
    if command_exists getcap; then run_capture "Linux Capabilities" getcap -r /; else warning "getcap not installed."; fi
    run_shell_capture "Writable Directories (sample)" 'find / -xdev -type d -writable -print 2>/dev/null | head -n 100'
    collect_findings
}

process_information() {
    title "PROCESSES"
    run_capture "Running Processes" ps aux
    run_shell_capture "Top CPU Processes" 'ps aux --sort=-%cpu 2>/dev/null | head -n 20'
    run_shell_capture "Top Memory Processes" 'ps aux --sort=-%mem 2>/dev/null | head -n 20'
    run_shell_capture "Root-owned Processes" "ps -eo user,pid,ppid,cmd 2>/dev/null | awk '\$1==\"root\" {print}' | head -n 100"
}

service_information() {
    title "SERVICES & SYSTEMD"
    if command_exists systemctl; then
        run_capture "Running Services" systemctl --type=service --state=running
        run_capture "Enabled Services" systemctl list-unit-files --type=service --state=enabled
        run_capture "Systemd Timers" systemctl list-timers --all
    else
        warning "systemctl unavailable; this host may not use systemd."
    fi
    if command_exists ss; then run_capture "Listening Services" ss -tulpn; fi
}

network_information() {
    title "NETWORK INFORMATION"
    command_exists ip && run_capture "Interfaces & Addresses" ip addr
    command_exists ip && run_capture "Routing Table" ip route
    command_exists ip && run_capture "Neighbour Table" ip neigh
    [[ -r /etc/resolv.conf ]] && run_capture "DNS Configuration" cat /etc/resolv.conf
    command_exists ss && run_capture "Listening TCP/UDP Ports" ss -tulpn
    command_exists ss && run_capture "Established Connections" ss -tun
}

ssh_information() {
    title "SSH INFORMATION"
    command_exists ss && run_shell_capture "SSH Listener" "ss -lntp 2>/dev/null | grep -E '(:22[[:space:]]|:22$)' || true"
    if [[ -r /etc/ssh/sshd_config ]]; then
        run_shell_capture "Effective SSH Configuration Lines" "grep -Ev '^[[:space:]]*#|^[[:space:]]*$' /etc/ssh/sshd_config"
    fi
    if [[ -d "$HOME/.ssh" ]]; then
        run_capture "Current User SSH Directory" ls -la "$HOME/.ssh"
        [[ -f "$HOME/.ssh/authorized_keys" ]] && say "${YELLOW}[REVIEW]${NC} authorized_keys exists for current user." && report "[REVIEW] $HOME/.ssh/authorized_keys exists."
    fi
}

scheduled_tasks() {
    title "SCHEDULED TASKS"
    run_shell_capture "Current User Crontab" 'crontab -l 2>/dev/null || true'
    for d in /etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.weekly /etc/cron.monthly; do
        [[ -d "$d" ]] || continue
        run_capture "Cron Directory: $d" ls -la "$d"
    done
    command_exists systemctl && run_capture "Systemd Timers" systemctl list-timers --all
}

package_information() {
    title "PACKAGE & SOFTWARE INFORMATION"
    if command_exists apt; then run_capture "APT Version" apt --version; fi
    if command_exists dpkg-query; then run_shell_capture "Installed Package Count" 'dpkg-query -W 2>/dev/null | wc -l'; fi
    local tools=(nmap curl wget python3 python perl gcc git ssh nc netcat)
    section "Common Tools"
    for tool in "${tools[@]}"; do
        if command_exists "$tool"; then printf '[+] %-10s %s\n' "$tool" "$(command -v "$tool")"; fi
    done
}

environment_information() {
    title "ENVIRONMENT & PATH"
    say "PATH=${PATH:-}"
    say "SHELL=${SHELL:-Unknown}"
    report "PATH=${PATH:-}"
    report "SHELL=${SHELL:-Unknown}"
    if [[ -r /proc/1/environ ]]; then
        section "Environment (selected names only)"
        env | cut -d= -f1 | sort | uniq | head -n 100
    fi
    for f in "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile"; do
        [[ -f "$f" ]] && say "[+] $f -> $(ls -l "$f")"
    done
    collect_findings
}

interesting_files() {
    title "INTERESTING FILE LOCATIONS"
    for f in /etc/passwd /etc/group /etc/hosts /etc/hostname /etc/resolv.conf /etc/fstab; do
        [[ -e "$f" ]] && say "[+] $f"
    done
    run_shell_capture "Readable Config-like Files (sample)" 'find /etc /opt /var /home -type f -readable 2>/dev/null \( -name "*.conf" -o -name "*.cfg" -o -name "*.ini" -o -name "*.env" \) | head -n 200'
}

ctf_flag_search() {
    title "CTF FLAG SEARCH"
    warning "Use only inside an authorized CTF/challenge environment."
    run_shell_capture "Common Flag Filenames" 'find / -xdev -type f \( -iname "flag*" -o -iname "*flag*" -o -iname "user.txt" -o -iname "root.txt" \) 2>/dev/null | head -n 200'
    for d in /tmp /home /opt /var/www; do
        [[ -d "$d" ]] || continue
        run_shell_capture "Flag-like Text in $d" "grep -RniE 'flag\\{|ctf\\{|user\\.txt|root\\.txt' '$d' 2>/dev/null | head -n 100"
    done
}

ctf_mode() {
    MODE="CTF"; create_report || return
    title "CTF MODE"; loading "Initializing CTF workflow"
    system_information; user_information; network_information; service_information
    permission_information; scheduled_tasks; interesting_files; ctf_flag_search
    success "CTF workflow completed."; pause_screen
}

ejpt_mode() {
    MODE="eJPT"; create_report || return
    title "eJPT MODE"; loading "Initializing eJPT workflow"
    system_information; user_information; network_information; service_information
    package_information; ssh_information; permission_information
    success "eJPT-oriented local enumeration completed."; pause_screen
}

oscp_mode() {
    MODE="OSCP"; create_report || return
    title "OSCP MODE"; loading "Initializing OSCP Linux workflow"
    system_information; user_information; filesystem_information; permission_information
    process_information; service_information; network_information; ssh_information
    scheduled_tasks; environment_information; package_information; interesting_files
    success "OSCP-oriented Linux enumeration completed."; pause_screen
}

bughunt_mode() {
    MODE="BUG-HUNTING"; create_report || return
    title "BUG HUNTING MODE"
    warning "Only use against a target explicitly inside your authorized scope."
    read -r -p "Authorized domain/host: " TARGET
    [[ -n "$TARGET" ]] || { error_msg "No target entered."; pause_screen; return; }
    report "### AUTHORIZED TARGET\n$TARGET"
    section "Target"; printf '%s\n' "$TARGET"
    command_exists getent && run_capture "DNS Resolution" getent hosts "$TARGET"
    if command_exists curl; then
        run_capture "HTTPS Headers" curl -I -L --max-time 10 -- "$TARGET"
        run_shell_capture "HTTPS Metadata" "curl -sS -L --max-time 10 -o /dev/null -w 'HTTP Code: %{http_code}\nContent-Type: %{content_type}\nRemote IP: %{remote_ip}\nURL: %{url_effective}\n' -- '$TARGET'"
        run_shell_capture "robots.txt" "curl -sS -L --max-time 10 -- '$TARGET/robots.txt'"
    else warning "curl not available."; fi
    success "Basic authorized web reconnaissance completed."; pause_screen
}

general_mode() {
    MODE="GENERAL"; create_report || return
    title "GENERAL LINUX MODE"; loading "Collecting general system information"
    system_information; user_information; filesystem_information; process_information
    service_information; network_information; package_information; ssh_information
    scheduled_tasks; environment_information
    success "General Linux collection completed."; pause_screen
}

full_scan() {
    MODE="FULL"; create_report || return
    title "FULL INSPECTR SCAN"; warning "This can be slower on large filesystems."
    progress "System"; system_information
    progress "Users"; user_information
    progress "Filesystem"; filesystem_information
    progress "Permissions"; permission_information
    progress "Processes"; process_information
    progress "Services"; service_information
    progress "Network"; network_information
    progress "SSH"; ssh_information
    progress "Scheduled tasks"; scheduled_tasks
    progress "Packages"; package_information
    progress "Environment"; environment_information
    progress "Interesting files"; interesting_files
    title "SCAN COMPLETE"
    say "Report: $REPORT_FILE"
    pause_screen
}

help_menu() {
    clear 2>/dev/null || true
    title "INSPECTR HELP"
    cat <<'HELP'
Purpose:
  Authorized Linux security inspection and enumeration.

Modes:
  1  CTF          Challenge-oriented local enumeration + flag discovery
  2  eJPT         Local enumeration aligned to eJPT-style fundamentals
  3  OSCP         Deeper Linux enumeration and privilege-review leads
  4  Bug Hunt     Basic authorized web reconnaissance helper
  5  General      General Linux information collection
  6  Full Scan    Runs the local enumeration modules
  7  Help
  8  Exit

Reports:
  ./inspectr_reports/

Examples:
  chmod +x inspectr.sh
  ./inspectr.sh
  ./inspectr.sh --help
  ./inspectr.sh --version

Safety:
  Use only on systems, labs, CTFs and targets you are authorized to assess.
HELP
    pause_screen
}

main_menu() {
    while true; do
        banner
        say "${YELLOW}==================== MAIN MENU ====================${NC}"
        echo "1) CTF Mode"
        echo "2) eJPT Mode"
        echo "3) OSCP Mode"
        echo "4) Bug Hunting Mode"
        echo "5) General Linux Mode"
        echo "6) Full Security Scan"
        echo "7) Help"
        echo "8) Exit"
        echo
        read -r -p "INSPECTR > " choice
        case "$choice" in
            1) ctf_mode ;; 2) ejpt_mode ;; 3) oscp_mode ;; 4) bughunt_mode ;;
            5) general_mode ;; 6) full_scan ;; 7) help_menu ;;
            8) echo; success "INSPECTR closed."; exit 0 ;;
            *) error_msg "Invalid option."; sleep 0.8 ;;
        esac
    done
}

cli() {
    case "${1:-}" in
        --help|-h) help_menu; exit 0 ;;
        --version|-v) printf '%s %s\n' "$APP" "$VERSION"; exit 0 ;;
        "") main_menu ;;
        *) error_msg "Unknown argument: $1"; echo "Use --help for usage."; exit 2 ;;
    esac
}

trap 'echo; warning "Interrupted."; exit 130' INT TERM

cli "$@"
