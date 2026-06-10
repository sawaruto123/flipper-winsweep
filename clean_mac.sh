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

# ── Global State ──────────────────────────────────────────────────
TOTAL_FREED=0

# ── Helpers ───────────────────────────────────────────────────────
nl() { echo ""; }
hr() { echo -e "  ${DKGRAY}$(printf '═%.0s' {1..80})${NC}"; }
hr2() { echo -e "  ${DKGRAY}$(printf '─%.0s' {1..80})${NC}"; }

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

run_and_report() {
    local label="$1"
    local color="$2"
    local path="$3"
    local before=0

    if [ -d "$path" ]; then
        before=$(du -sk "$path" 2>/dev/null | awk '{print $1 * 1024}' || echo 0)
    fi

    # Animate progress bar
    local barW=34
    local frames=(0 8 18 30 45 60 74 85 93 98 100)
    for p in "${frames[@]}"; do
        local filled=$(( barW * p / 100 ))
        local empty=$(( barW - filled ))
        local bar=""
        for ((i=0; i<filled; i++)); do bar+="█"; done
        for ((i=0; i<empty; i++)); do  bar+="▒"; done
        printf "\r  ${color}%-18s${NC}  ${DKGRAY}│${NC}${GREEN}%s${NC}${DKGRAY}│${NC} %3d%%  ${GRAY}scanning...${NC}" "$label" "$bar" "$p"
        sleep 0.04
    done

    # Perform cleaning
    if [ -d "$path" ]; then
        rm -rf "$path"/* 2>/dev/null
        rm -rf "$path"/.[^.]* 2>/dev/null
    fi

    local bar=""
    for ((i=0; i<barW; i++)); do bar+="█"; done
    local size_str=$(format_size $before)
    printf "\r  ${color}%-18s${NC}  ${DKGRAY}│${NC}${GREEN}%s${NC}${DKGRAY}│${NC} 100%%  ${WHITE}%s${NC}\n" "$label" "$bar" "$size_str"

    if [ "$before" -gt 0 ] 2>/dev/null; then
        TOTAL_FREED=$(( TOTAL_FREED + before ))
    fi
    sleep 0.04
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

boot_lines=(
    "[INIT] .. kernel modules loaded"
    "[INIT] .. entropy pool seeded"
    "[AUTH] .. device fingerprint: FLIPPER//ZERO"
    "[AUTH] .. clearance level OMEGA granted"
    "[NET]  .. secure channel established"
    "[SCAN] .. filesystem tree mounted"
    "[SCAN] .. junk node enumeration complete"
    "[WARN] .. debris detected across 10 sectors"
    "[ARM]  .. neural cleanse sequence READY"
)

for line in "${boot_lines[@]}"; do
    # Dynamically extract everything inside brackets []
    if [[ "$line" =~ ^(\[[A-Z]+\])(.*) ]]; then
        tag="${BASH_REMATCH[1]}"
        rest="${BASH_REMATCH[2]}"
    else
        tag="[INFO]"
        rest=" $line"
    fi

    if [[ "$tag" == *WARN* ]]; then tagcol=$YELLOW
    elif [[ "$tag" == *AUTH* ]]; then tagcol=$GREEN
    elif [[ "$tag" == *ARM* ]];  then tagcol=$CYAN
    else tagcol=$DKGREEN; fi

    printf "  ${tagcol}%-7s${NC}" "$tag"
    for ((i=0; i<${#rest}; i++)); do
        printf "${GRAY}%s${NC}" "${rest:$i:1}"
        sleep 0.005
    done
    echo ""
    sleep 0.05
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
    sleep 0.04
done

nl
glitch ">>> SCAN COMPLETE. INITIATING PURGE SEQUENCE <<<" "$GREEN"
nl; hr2; nl

# ════════════════════════════════════════════════════════════════
#  PURGE PHASE
# ════════════════════════════════════════════════════════════════
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

# Trash Sector Cleanup
printf "  ${YELLOW}%-18s${NC}  " "TRASH"
trash_before=$(du -sk "$HOME/.Trash" 2>/dev/null | awk '{print $1*1024}' || echo 0)
barW=34; bar=""
for ((i=0; i<barW; i++)); do bar+="█"; done
printf "${DKGRAY}│${NC}${GREEN}%s${NC}${DKGRAY}│${NC} 100%%  ${WHITE}%s${NC}\n" "$bar" "$(format_size $trash_before)"
rm -rf "$HOME"/.Trash/* 2>/dev/null
rm -rf "$HOME"/.Trash/.[^.]* 2>/dev/null
TOTAL_FREED=$(( TOTAL_FREED + trash_before ))

# DNS Flush Sector
printf "  ${CYAN}%-18s${NC}  " "DNS CACHE"
bar=""
for ((i=0; i<34; i++)); do bar+="█"; done
printf "${DKGRAY}│${NC}${GREEN}%s${NC}${DKGRAY}│${NC} 100%%  ${WHITE}flushed${NC}\n" "$bar"
sudo dscacheutil -flushcache 2>/dev/null
sudo killall -HUP mDNSResponder 2>/dev/null

nl; hr; nl

# ════════════════════════════════════════════════════════════════
#  SUMMARY
# ════════════════════════════════════════════════════════════════
echo -e "  ${GREEN}[COMPLETE]  Neural cleanse finished.${NC}"
nl

# Animated grand total accumulator bar
total_bar_width=40
for ((p=0; p<=total_bar_width; p++)); do
    bar=""
    for ((i=0; i<p; i++)); do bar+="█"; done
    for ((i=p; i<total_bar_width; i++)); do bar+="▒"; done
    display=$(( TOTAL_FREED * p / total_bar_width ))
    printf "\r  ${DKGRAY}TOTAL FREED  │${NC}${GREEN}%s${NC}${DKGRAY}│${NC}  ${CYAN}%s${NC}     " "$bar" "$(format_size $display)"
    sleep 0.02
done
bar=""
for ((i=0; i<total_bar_width; i++)); do bar+="█"; done
printf "\r  ${DKGRAY}TOTAL FREED  │${NC}${GREEN}%s${NC}${DKGRAY}│${NC}  ${CYAN}%s${NC}\n" "$bar" "$(format_size $TOTAL_FREED)"

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
    sleep 0.02
done

nl; nl
echo -e "                      ${DKGREEN}press enter to disconnect_${NC}"
read
