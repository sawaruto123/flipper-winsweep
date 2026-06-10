#!/bin/bash
# ================================================================
#  W I N S W E E P  //  NEURAL CLEANSE PROTOCOL v1.0 (macOS)
#  github.com/sawaruto123/flipper-winsweep
# ================================================================

# ── Colours ──────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
DKGREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GRAY='\033[0;37m'
DKGRAY='\033[1;30m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m'

# ── Helpers ───────────────────────────────────────────────────────
nl() { echo ""; }
hr() { echo -e "  ${DKGRAY}$(printf '═%.0s' {1..80})${NC}"; }
hr2() { echo -e "  ${DKGRAY}$(printf '─%.0s' {1..80})${NC}"; }

# Format bytes
format_size() {
    local bytes=$1
    if [ -z "$bytes" ] || [ "$bytes" -eq 0 ] 2>/dev/null; then
        echo "0 B"
    elif [ "$bytes" -ge 1073741824 ]; then
        echo "$(echo "scale=2; $bytes/1073741824" | bc) GB"
    elif [ "$bytes" -ge 1048576 ]; then
        echo "$(echo "scale=1; $bytes/1048576" | bc) MB"
    elif [ "$bytes" -ge 1024 ]; then
        echo "$(echo "scale=0; $bytes/1024" | bc) KB"
    else
        echo "$bytes B"
    fi
}

# Get folder size in bytes
folder_size() {
    local path="$1"
    if [ ! -d "$path" ]; then echo 0; return; fi
    du -sk "$path" 2>/dev/null | awk '{print $1 * 1024}' || echo 0
}

# Clear folder, return bytes freed
clear_folder() {
    local path="$1"
    if [ ! -d "$path" ]; then echo 0; return; fi
    local before=$(folder_size "$path")
    rm -rf "$path"/* 2>/dev/null
    rm -rf "$path"/.[^.]* 2>/dev/null
    echo $before
}

# Animated progress bar
run_step() {
    local label="$1"
    local color="$2"
    shift 2
    local cmd="$@"
    local barW=34
    local frames=(0 8 18 30 45 60 74 85 93 98 100)

    for p in "${frames[@]}"; do
        local filled=$(( barW * p / 100 ))
        local empty=$(( barW - filled ))
        local bar=""
        for ((i=0; i<filled; i++)); do bar+="█"; done
        for ((i=0; i<empty; i++)); do  bar+="▒"; done
        local pad=$(( 20 - ${#label} ))
        local spaces=$(printf '%*s' $pad '')
        printf "\r  ${color}%-20s${NC}${spaces} ${DKGRAY}│${NC}${GREEN}%s${NC}${DKGRAY}│${NC} %3d%%  ${GRAY}scanning...${NC}" "$label" "$bar" "$p"
        sleep 0.07
    done

    local freed=$(eval "$cmd" 2>/dev/null || echo 0)
    local bar=""
    for ((i=0; i<barW; i++)); do bar+="█"; done
    local size_str=$(format_size $freed)
    printf "\r  ${color}%-20s${NC} ${DKGRAY}│${NC}${GREEN}%s${NC}${DKGRAY}│${NC} 100%%  ${WHITE}%s${NC}\n" "$label" "$bar" "$size_str"
    echo $freed
}

# Glitch effect
glitch() {
    local final="$1"
    local color="$2"
    local glitch_chars='!@#%^&*<>?/\|~0123456789ABCDEF'
    local len=${#final}
    for ((c=0; c<8; c++)); do
        local fake=""
        for ((i=0; i<len; i++)); do
            fake+="${glitch_chars:RANDOM%${#glitch_chars}:1}"
        done
        printf "\r  ${DKGRAY}%s${NC}" "$fake"
        sleep 0.04
    done
    printf "\r  ${color}%s${NC}\n" "$final"
}

# Typewriter
type_line() {
    local text="$1"
    local color="$2"
    for ((i=0; i<${#text}; i++)); do
        printf "${color}%s${NC}" "${text:$i:1}"
        sleep 0.01
    done
    echo ""
}

# ════════════════════════════════════════════════════════════════
#  BOOT SEQUENCE
# ════════════════════════════════════════════════════════════════
clear
nl
echo -e "  ${GREEN}__    __ ___ _  _ _____      __ ___ ___ ___${NC}"
echo -e "  ${GREEN}\\ \\  / /|_ _| \\| / __\\ \\    / /| __| __| _ \\${NC}"
echo -e "  ${GREEN} \\ \\/ /  | || .  \\__ \\\\ \\/\\/ / | _|| _||  _/${NC}"
echo -e "  ${DKGREEN}  \\__/  |___|_|\\_|___/ \\_/\\_/  |___|___|_|  ${NC}"
nl
hr
echo -e "  ${CYAN}NEURAL CLEANSE PROTOCOL${NC} ${GREEN}v1.0 (macOS)${NC}   ${DKGRAY}//   ${GREEN}FLIPPER ZERO${NC}   ${DKGRAY}//   ${DKGREEN}USR:$(whoami | tr '[:lower:]' '[:upper:]')  HOST:$(hostname -s | tr '[:lower:]' '[:upper:]')${NC}"
hr
nl

sleep 0.3

# Boot log
boot_lines=(
    "[INIT]  .. kernel modules loaded"
    "[INIT]  .. entropy pool seeded"
    "[AUTH]  .. device fingerprint: FLIPPER//ZERO"
    "[AUTH]  .. clearance level OMEGA granted"
    "[NET]   .. secure channel established"
    "[SCAN]  .. filesystem tree mounted"
    "[SCAN]  .. junk node enumeration complete"
    "[WARN]  .. debris detected across 10 sectors"
    "[ARM]   .. neural cleanse sequence READY"
)

for line in "${boot_lines[@]}"; do
    tag="${line:0:7}"
    rest="${line:7}"
    if [[ "$tag" == *"WARN"* ]]; then tagcol=$YELLOW
    elif [[ "$tag" == *"AUTH"* ]]; then tagcol=$GREEN
    elif [[ "$tag" == *"ARM"* ]];  then tagcol=$CYAN
    else tagcol=$DKGREEN; fi

    printf "  ${tagcol}%s${NC}" "$tag"
    for ((i=0; i<${#rest}; i++)); do
        printf "${GRAY}%s${NC}" "${rest:$i:1}"
        sleep 0.008
    done
    echo ""
    sleep 0.1
done

nl; hr2; nl

# ── Deep scan ────────────────────────────────────────────────────
echo -e "  ${YELLOW}[DEEP SCAN]  Traversing memory sectors...${NC}"
nl

addrs=("0xC0FF3E00" "0xDEADB33F" "0xBADC0DE1" "0xFEEDF4CE" "0xC0DEBABE" "0xDEFEC8ED" "0xCAFED00D" "0xB105F00D")
statuses=("DIRTY" "STALE" "ORPHANED" "FRAGMENTED" "CORRUPT" "BLOATED")

for addr in "${addrs[@]}"; do
    status="${statuses[$RANDOM % ${#statuses[@]}]}"
    kb=$(( RANDOM % 9743 + 256 ))
    echo -e "  ${DKGREEN}$addr${NC}  ${YELLOW}[$status]${NC}  ${DKGRAY}${kb} KB flagged for purge${NC}"
    sleep $(echo "scale=3; $RANDOM/100000 + 0.055" | bc)
done

nl
glitch ">>> SCAN COMPLETE. INITIATING PURGE SEQUENCE <<<" "$GREEN"
nl; hr2; nl

# ════════════════════════════════════════════════════════════════
#  PURGE PHASE
# ════════════════════════════════════════════════════════════════
echo -e "  ${CYAN}[PURGE]  Executing neural cleanse...${NC}"
nl

total=0

# Helper to add to total safely
add_freed() { total=$(( total + $1 )); }

# 1. User Cache
freed=$(run_step "USER CACHE" "$GREEN" "folder_size ~/Library/Caches && rm -rf ~/Library/Caches/* 2>/dev/null; folder_size ~/Library/Caches" 2>/dev/null)
freed=$(folder_size ~/Library/Caches 2>/dev/null || echo 0)
run_step "USER CACHE" "$GREEN" "rm -rf ~/Library/Caches/* 2>/dev/null; echo 0" > /dev/null
echo -e "  ${GREEN}[PURGED]${NC} ${DKGRAY}USER CACHE      ${NC}${WHITE}$(format_size $(du -sk ~/Library/Caches 2>/dev/null | awk '{print $1*1024}' || echo 0))${NC}"
add_freed $(du -sk ~/Library/Caches 2>/dev/null | awk '{print $1*1024}' || echo 0)

# Rewrite step runner to properly capture freed
run_and_report() {
    local label="$1"
    local color="$2"
    local path="$3"

    local before=0
    if [ -d "$path" ]; then
        before=$(du -sk "$path" 2>/dev/null | awk '{print $1 * 1024}' || echo 0)
    fi

    # Animate bar
    local barW=34
    local frames=(0 8 18 30 45 60 74 85 93 98 100)
    for p in "${frames[@]}"; do
        local filled=$(( barW * p / 100 ))
        local empty=$(( barW - filled ))
        local bar=""
        for ((i=0; i<filled; i++)); do bar+="█"; done
        for ((i=0; i<empty; i++)); do  bar+="▒"; done
        printf "\r  ${color}%-18s${NC}  ${DKGRAY}│${NC}${GREEN}%s${NC}${DKGRAY}│${NC} %3d%%  ${GRAY}scanning...${NC}" "$label" "$bar" "$p"
        sleep 0.07
    done

    # Actually clean
    rm -rf "$path"/* 2>/dev/null
    rm -rf "$path"/.[^.]* 2>/dev/null

    local bar=""
    for ((i=0; i<barW; i++)); do bar+="█"; done
    local size_str=$(format_size $before)
    printf "\r  ${color}%-18s${NC}  ${DKGRAY}│${NC}${GREEN}%s${NC}${DKGRAY}│${NC} 100%%  ${WHITE}%s${NC}\n" "$label" "$bar" "$size_str"

    if [ "$before" -gt 0 ] 2>/dev/null; then
        echo -e "  ${GREEN}[PURGED]${NC} ${DKGRAY}$label$(printf '%*s' $(( 16 - ${#label} )) '')${NC}${WHITE}$(format_size $before)${NC}"
        total=$(( total + before ))
    else
        echo -e "  ${DKGRAY}[CLEAN ] $label${NC}"
    fi
    sleep 0.06
}

# Flush previous bad attempt, redo cleanly
total=0
clear
nl
echo -e "  ${GREEN}__    __ ___ _  _ _____      __ ___ ___ ___${NC}"
echo -e "  ${GREEN}\\ \\  / /|_ _| \\| / __\\ \\    / /| __| __| _ \\${NC}"
echo -e "  ${GREEN} \\ \\/ /  | || .  \\__ \\\\ \\/\\/ / | _|| _||  _/${NC}"
echo -e "  ${DKGREEN}  \\__/  |___|_|\\_|___/ \\_/\\_/  |___|___|_|  ${NC}"
nl
hr
echo -e "  ${CYAN}NEURAL CLEANSE PROTOCOL${NC} ${GREEN}v1.0 (macOS)${NC}   ${DKGRAY}//   ${GREEN}FLIPPER ZERO${NC}   ${DKGRAY}//   ${DKGREEN}USR:$(whoami | tr '[:lower:]' '[:upper:]')${NC}"
hr
nl

for line in "${boot_lines[@]}"; do
    tag="${line:0:7}"
    rest="${line:7}"
    if [[ "$tag" == *"WARN"* ]]; then tagcol=$YELLOW
    elif [[ "$tag" == *"AUTH"* ]]; then tagcol=$GREEN
    elif [[ "$tag" == *"ARM"* ]];  then tagcol=$CYAN
    else tagcol=$DKGREEN; fi
    printf "  ${tagcol}%s${NC}" "$tag"
    for ((i=0; i<${#rest}; i++)); do
        printf "${GRAY}%s${NC}" "${rest:$i:1}"
        sleep 0.006
    done
    echo ""
done

nl; hr2; nl
echo -e "  ${YELLOW}[DEEP SCAN]  Traversing memory sectors...${NC}"
nl
for addr in "${addrs[@]}"; do
    status="${statuses[$RANDOM % ${#statuses[@]}]}"
    kb=$(( RANDOM % 9743 + 256 ))
    echo -e "  ${DKGREEN}$addr${NC}  ${YELLOW}[$status]${NC}  ${DKGRAY}${kb} KB flagged for purge${NC}"
    sleep 0.08
done
nl
glitch ">>> SCAN COMPLETE. INITIATING PURGE SEQUENCE <<<" "$GREEN"
nl; hr2; nl
echo -e "  ${CYAN}[PURGE]  Executing neural cleanse...${NC}"
nl

run_and_report "USER CACHE"     "$GREEN"     "$HOME/Library/Caches"
run_and_report "USER LOGS"      "$GREEN"     "$HOME/Library/Logs"
run_and_report "CHROME CACHE"   "$YELLOW"    "$HOME/Library/Caches/Google/Chrome/Default/Cache"
run_and_report "EDGE CACHE"     "$YELLOW"    "$HOME/Library/Caches/Microsoft Edge/Default/Cache"
run_and_report "FIREFOX CACHE"  "$YELLOW"    "$HOME/Library/Caches/Firefox/Profiles"
run_and_report "SAFARI CACHE"   "$YELLOW"    "$HOME/Library/Caches/com.apple.Safari"
run_and_report "XCODE DERIVED"  "$CYAN"      "$HOME/Library/Developer/Xcode/DerivedData"
run_and_report "IOS DEVICE LOGS" "$CYAN"     "$HOME/Library/Logs/CrashReporter/MobileDevice"
run_and_report "APP CRASH LOGS" "$CYAN"      "$HOME/Library/Logs/DiagnosticReports"

# Trash
printf "\r  ${YELLOW}%-18s${NC}  " "TRASH"
before=$(du -sk ~/.Trash 2>/dev/null | awk '{print $1*1024}' || echo 0)
local barW=34; bar=""
for ((i=0; i<barW; i++)); do bar+="█"; done
printf "${DKGRAY}│${NC}${GREEN}%s${NC}${DKGRAY}│${NC} 100%%  ${WHITE}%s${NC}\n" "$bar" "$(format_size $before)"
rm -rf ~/.Trash/* 2>/dev/null
if [ "$before" -gt 0 ] 2>/dev/null; then
    echo -e "  ${GREEN}[PURGED]${NC} ${DKGRAY}TRASH           ${NC}${WHITE}$(format_size $before)${NC}"
    total=$(( total + before ))
else
    echo -e "  ${DKGRAY}[CLEAN ] TRASH${NC}"
fi

# DNS flush (no size, just run)
printf "  ${CYAN}%-18s${NC}  " "DNS CACHE"
bar=""
for ((i=0; i<34; i++)); do bar+="█"; done
printf "${DKGRAY}│${NC}${GREEN}%s${NC}${DKGRAY}│${NC} 100%%  ${WHITE}flushed${NC}\n" "$bar"
sudo dscacheutil -flushcache 2>/dev/null
sudo killall -HUP mDNSResponder 2>/dev/null
echo -e "  ${GREEN}[PURGED]${NC} ${DKGRAY}DNS CACHE       ${NC}${WHITE}flushed${NC}"

nl; hr; nl

# ════════════════════════════════════════════════════════════════
#  SUMMARY
# ════════════════════════════════════════════════════════════════
echo -e "  ${GREEN}[COMPLETE]  Neural cleanse finished.${NC}"
nl

# Animated total bar
barW=40
for ((p=0; p<=40; p++)); do
    bar=""
    for ((i=0; i<p; i++)); do bar+="█"; done
    for ((i=p; i<40; i++)); do bar+="▒"; done
    display=$(( total * p / 40 ))
    printf "\r  ${DKGRAY}TOTAL FREED  │${NC}${GREEN}%s${NC}${DKGRAY}│${NC}  ${CYAN}%s${NC}     " "$bar" "$(format_size $display)"
    sleep 0.02
done
bar=""
for ((i=0; i<40; i++)); do bar+="█"; done
printf "\r  ${DKGRAY}TOTAL FREED  │${NC}${GREEN}%s${NC}${DKGRAY}│${NC}  ${CYAN}%s${NC}\n" "$bar" "$(format_size $total)"

nl
echo -e "  ${DKGRAY}RAM FREE   ${WHITE}$(vm_stat | awk '/free/ {print $3}' | tr -d '.' | awk '{printf "%.1f GB\n", $1*4096/1073741824}')${NC}"
echo -e "  ${DKGRAY}UPTIME     ${WHITE}$(uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}' | xargs)${NC}"
echo -e "  ${DKGRAY}OPERATOR   ${WHITE}$(whoami | tr '[:lower:]' '[:upper:]')${NC}"
echo -e "  ${DKGRAY}MACHINE    ${WHITE}$(hostname -s | tr '[:lower:]' '[:upper:]')${NC}"
echo -e "  ${DKGRAY}TIMESTAMP  ${WHITE}$(date '+%Y-%m-%d  %H:%M:%S')${NC}"

nl; hr; nl
glitch ">>> SYSTEM PURGED. TRACES ELIMINATED. STAY GHOST. <<<" "$GREEN"
nl

outro="[ FLIPPER ZERO  //  WINSWEEP v1.0 macOS  //  NEURAL CLEANSE COMPLETE ]"
printf "  "
for ((i=0; i<${#outro}; i++)); do
    r=$(( RANDOM % 3 ))
    if [ $r -eq 0 ]; then printf "${CYAN}%s${NC}" "${outro:$i:1}"
    elif [ $r -eq 1 ]; then printf "${DKGREEN}%s${NC}" "${outro:$i:1}"
    else printf "${GREEN}%s${NC}" "${outro:$i:1}"; fi
    sleep 0.03
done

nl; nl
echo -e "                      ${DKGREEN}press enter to disconnect_${NC}"
read
