# ================================================================
#  W I N S W E E P  //  NEURAL CLEANSE PROTOCOL v2.0
#  github: YOUR_USERNAME/flipper-winsweep
# ================================================================

$Host.UI.RawUI.WindowTitle = "WINSWEEP // NEURAL CLEANSE PROTOCOL"

# ── Console dimensions ──────────────────────────────────────────
try {
    $sz = $Host.UI.RawUI.WindowSize; $sz.Width = 90; $sz.Height = 44
    $Host.UI.RawUI.WindowSize = $sz
    $bf = $Host.UI.RawUI.BufferSize; $bf.Width = 90
    $Host.UI.RawUI.BufferSize = $bf
} catch {}
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Green"
Clear-Host

# ── Core colour palette ─────────────────────────────────────────
# Primary: Green  |  Accent: Cyan  |  Warn: Yellow  |  Dim: DarkGray
# Alert: Red      |  Done: White   |  Ghost: DarkGreen

# ── Write helpers ───────────────────────────────────────────────
function W($t,$c="Green")  { Write-Host $t -ForegroundColor $c -NoNewline }
function WL($t,$c="Green") { Write-Host $t -ForegroundColor $c }
function NL { Write-Host "" }

# ── Typewriter effect ────────────────────────────────────────────
function Type-Text {
    param($text, $color = "Green", $delay = 18)
    foreach ($ch in $text.ToCharArray()) {
        W $ch $color
        Start-Sleep -Milliseconds $delay
    }
    Write-Host ""
}

# ── Glitch text (flicker between chars) ─────────────────────────
function Glitch-Text {
    param($final, $color = "Green", $cycles = 6)
    $glitchChars = "!@#$%^&*<>?/\|{}[]~`0123456789ABCDEF"
    $pos = $Host.UI.RawUI.CursorPosition
    for ($i = 0; $i -lt $cycles; $i++) {
        $fake = -join ((1..$final.Length) | ForEach-Object { $glitchChars[(Get-Random -Max $glitchChars.Length)] })
        $Host.UI.RawUI.CursorPosition = $pos
        W $fake "DarkGreen"
        Start-Sleep -Milliseconds 45
    }
    $Host.UI.RawUI.CursorPosition = $pos
    WL $final $color
}

# ── Horizontal rule ──────────────────────────────────────────────
function HR($char = "─", $color = "DarkGreen") {
    WL ("  " + ($char * 86)) $color
}

# ── Animated progress bar with live byte counter ─────────────────
function Show-Progress {
    param($label, $pct, $freed = 0, $color = "Green")
    $barW   = 36
    $filled = [math]::Round($barW * $pct / 100)
    $empty  = $barW - $filled
    $bar    = ("█" * $filled) + ("▒" * $empty)
    $lpad   = " " * (24 - $label.Length)
    $sizeStr = if ($freed -gt 0) { Format-Size $freed } else { "  scanning..." }
    $line = "  {0}{1} [{2}] {3,4}%   {4}" -f $label, $lpad, $bar, $pct, $sizeStr
    Write-Host "`r$line" -ForegroundColor $color -NoNewline
}

# ── Run a step with animated bar ─────────────────────────────────
function Run-Step {
    param($label, $color = "Green", [scriptblock]$action)
    $frames = 0,5,12,22,35,50,65,78,88,95,100
    $freed  = 0
    foreach ($p in $frames) {
        Show-Progress $label $p 0 $color
        Start-Sleep -Milliseconds (Get-Random -Min 55 -Max 140)
    }
    try { $freed = & $action } catch {}
    Show-Progress $label 100 $freed $color
    Write-Host ""
    return $freed
}

# ── Folder helpers ───────────────────────────────────────────────
function Get-FolderSize($path) {
    if (-not (Test-Path $path)) { return 0 }
    try {
        return (Get-ChildItem $path -Recurse -Force -ErrorAction SilentlyContinue |
                Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
    } catch { return 0 }
}

function Clear-Folder($path) {
    $before = Get-FolderSize $path
    if ($before -eq 0) { return 0 }
    Get-ChildItem $path -Recurse -Force -ErrorAction SilentlyContinue |
        Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    return $before
}

function Format-Size($bytes) {
    if (!$bytes -or $bytes -eq 0) { return "0 B" }
    if ($bytes -ge 1GB) { return "{0:N2} GB" -f ($bytes/1GB) }
    if ($bytes -ge 1MB) { return "{0:N1} MB" -f ($bytes/1MB) }
    if ($bytes -ge 1KB) { return "{0:N0} KB" -f ($bytes/1KB) }
    return "$bytes B"
}

# ════════════════════════════════════════════════════════════════
#  BOOT SEQUENCE
# ════════════════════════════════════════════════════════════════
Clear-Host
NL
WL "  ██╗    ██╗██╗███╗   ██╗███████╗██╗    ██╗███████╗███████╗██████╗ " "Green"
WL "  ██║    ██║██║████╗  ██║██╔════╝██║    ██║██╔════╝██╔════╝██╔══██╗" "Green"
WL "  ██║ █╗ ██║██║██╔██╗ ██║███████╗██║ █╗ ██║█████╗  █████╗  ██████╔╝" "Green"
WL "  ██║███╗██║██║██║╚██╗██║╚════██║██║███╗██║██╔══╝  ██╔══╝  ██╔═══╝ " "DarkGreen"
WL "  ╚███╔███╔╝██║██║ ╚████║███████║╚███╔███╔╝███████╗███████╗██║     " "DarkGreen"
WL "   ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚══════╝ ╚══╝╚══╝ ╚══════╝╚══════╝╚═╝     " "DarkGreen"
NL
HR "═"
W  "  NEURAL CLEANSE PROTOCOL " "Cyan"; W "v2.0" "DarkGreen"; W "  //  " "DarkGray"
W  "FLIPPER ZERO" "Green"; W "  //  " "DarkGray"; WL "UNAUTHORIZED ACCESS WELCOME" "DarkGreen"
HR "═"
NL

Start-Sleep -Milliseconds 300

# Boot log lines
$bootLines = @(
    @{ text="[INIT]    Loading kernel modules...";            color="DarkGreen"; delay=120 },
    @{ text="[INIT]    Establishing secure channel...";       color="DarkGreen"; delay=100 },
    @{ text="[AUTH]    Identity: FLIPPER//ZERO verified";     color="Green";     delay=80  },
    @{ text="[AUTH]    Clearance level: OMEGA granted";       color="Green";     delay=80  },
    @{ text="[SCAN]    Mounting filesystem tree...";          color="Cyan";      delay=90  },
    @{ text="[SCAN]    Enumerating system junk nodes...";     color="Cyan";      delay=90  },
    @{ text="[WARN]    Debris detected in 11 sectors";        color="Yellow";    delay=70  },
    @{ text="[PROC]    Neural cleanse sequence ARMED";        color="Green";     delay=60  }
)

foreach ($line in $bootLines) {
    W "  " "DarkGray"
    foreach ($ch in $line.text.ToCharArray()) {
        W $ch $line.color
        Start-Sleep -Milliseconds (Get-Random -Min 4 -Max 14)
    }
    Write-Host ""
    Start-Sleep -Milliseconds $line.delay
}

NL
HR "─"
NL

# ── Fake system scan with scrolling hex addresses ────────────────
WL "  [DEEP SCAN]  Traversing memory sectors..." "Yellow"
NL

$sectors = @(
    "0xC0FF3E00", "0xDEADB33F", "0xBADC0DE1", "0xFEEDF4CE",
    "0xC0DEBABE", "0xDEFEC8ED", "0xCAFED00D", "0xB105F00D"
)
foreach ($addr in $sectors) {
    $status = @("DIRTY","STALE","ORPHANED","FRAGMENTED","CORRUPT","BLOATED") | Get-Random
    $kb     = Get-Random -Min 128 -Max 9999
    W "  $addr  " "DarkGreen"
    W "[ $status ] " "Yellow"
    WL "$kb KB flagged for purge" "DarkGray"
    Start-Sleep -Milliseconds (Get-Random -Min 60 -Max 160)
}

NL
W "  " "DarkGray"; Glitch-Text ">>> SCAN COMPLETE. INITIATING PURGE SEQUENCE <<<" "Green" 8
NL
HR "─"
NL

# ════════════════════════════════════════════════════════════════
#  CLEANUP PHASE
# ════════════════════════════════════════════════════════════════
WL "  [PURGE]  Executing neural cleanse..." "Cyan"
NL

$total = 0

# Each step: label | color | scriptblock
$steps = @(
    @{
        label = "USER TEMP"
        color = "Green"
        code  = { Clear-Folder $env:TEMP }
    },
    @{
        label = "SYSTEM TEMP"
        color = "Green"
        code  = { Clear-Folder "C:\Windows\Temp" }
    },
    @{
        label = "PREFETCH CACHE"
        color = "Cyan"
        code  = { Clear-Folder "C:\Windows\Prefetch" }
    },
    @{
        label = "WIN UPDATE"
        color = "Cyan"
        code  = {
            Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
            $b = Clear-Folder "C:\Windows\SoftwareDistribution\Download"
            Start-Service -Name wuauserv -ErrorAction SilentlyContinue
            $b
        }
    },
    @{
        label = "THUMBNAIL DB"
        color = "Yellow"
        code  = {
            $p = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer"
            $b = Get-FolderSize $p
            Get-ChildItem $p -Filter "thumbcache_*.db" -Force -ErrorAction SilentlyContinue |
                Remove-Item -Force -ErrorAction SilentlyContinue
            $b
        }
    },
    @{
        label = "CHROME CACHE"
        color = "Yellow"
        code  = { Clear-Folder "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache" }
    },
    @{
        label = "EDGE CACHE"
        color = "Yellow"
        code  = { Clear-Folder "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache" }
    },
    @{
        label = "FIREFOX CACHE"
        color = "Yellow"
        code  = {
            $p = "$env:APPDATA\Mozilla\Firefox\Profiles"; $t = 0
            if (Test-Path $p) {
                Get-ChildItem $p -Directory | ForEach-Object {
                    $t += Clear-Folder (Join-Path $_.FullName "cache2")
                }
            }
            $t
        }
    },
    @{
        label = "RECYCLE BIN"
        color = "DarkYellow"
        code  = {
            $b = 0
            try {
                $sh = New-Object -ComObject Shell.Application
                $rb = $sh.Namespace(0xA)
                $b  = ($rb.Items() | Measure-Object -Property Size -Sum).Sum
                Clear-RecycleBin -Force -ErrorAction SilentlyContinue
            } catch {}
            $b
        }
    },
    @{
        label = "DNS CACHE"
        color = "DarkCyan"
        code  = { ipconfig /flushdns | Out-Null; 0 }
    },
    @{
        label = "EVENT LOGS"
        color = "DarkCyan"
        code  = {
            $b = Get-FolderSize "C:\Windows\System32\winevt\Logs"
            Get-EventLog -List -ErrorAction SilentlyContinue |
                ForEach-Object { Clear-EventLog -LogName $_.Log -ErrorAction SilentlyContinue }
            $b
        }
    }
)

foreach ($step in $steps) {
    $freed  = Run-Step $step.label $step.color $step.code
    $total += $freed
    $tag    = if ($freed -gt 0) { "PURGED" } else { "CLEAN " }
    $tagCol = if ($freed -gt 0) { "Green" } else { "DarkGray" }
    W "  " "DarkGray"
    W "[$tag] " $tagCol
    W "$($step.label)" "DarkGray"
    W (" " * (18 - $step.label.Length)) "DarkGray"
    WL (Format-Size $freed) "White"
    Start-Sleep -Milliseconds 80
}

NL
HR "═"
NL

# ════════════════════════════════════════════════════════════════
#  FINAL SUMMARY — animated byte counter
# ════════════════════════════════════════════════════════════════
WL "  [COMPLETE]  Neural cleanse finished." "Green"
NL

# Tick up total with acceleration
$display = 0
$ticks   = 50
$step    = [math]::Max(1, [math]::Round($total / $ticks))
for ($i = 0; $i -lt $ticks; $i++) {
    $display = [math]::Min($total, $display + $step)
    $bar     = "█" * [math]::Round(40 * $display / [math]::Max(1,$total))
    $empty   = "░" * (40 - $bar.Length)
    $pos     = $Host.UI.RawUI.CursorPosition
    W "  TOTAL FREED  [" "DarkGray"
    W ($bar + $empty) "Green"
    W "]  " "DarkGray"
    W (Format-Size $display) "Cyan"
    $Host.UI.RawUI.CursorPosition = $pos
    Start-Sleep -Milliseconds 25
}
# Final accurate line
$bar = "█" * 40
W "  TOTAL FREED  [" "DarkGray"; W $bar "Green"; W "]  " "DarkGray"; WL (Format-Size $total) "Cyan"

NL

# System stats
$os  = (Get-WmiObject Win32_OperatingSystem -ErrorAction SilentlyContinue)
$ram = if ($os) { "{0:N1} GB" -f ($os.FreePhysicalMemory / 1MB) } else { "N/A" }
$up  = if ($os) {
    $t = (Get-Date) - $os.ConvertToDateTime($os.LastBootUpTime)
    "{0}d {1}h {2}m" -f $t.Days, $t.Hours, $t.Minutes
} else { "N/A" }

W "  FREE RAM     " "DarkGray"; WL $ram "White"
W "  UPTIME       " "DarkGray"; WL $up  "White"
W "  OPERATOR     " "DarkGray"; WL $env:USERNAME.ToUpper() "White"
W "  TIMESTAMP    " "DarkGray"; WL (Get-Date -Format "yyyy-MM-dd  HH:mm:ss") "White"

NL
HR "═"
NL

# Outro glitch
Glitch-Text "  >>> SYSTEM PURGED. TRACES ELIMINATED. STAY GHOST. <<<" "Green" 10
NL

W "  " "DarkGray"
$outro = "[ FLIPPER ZERO // WINSWEEP // NEURAL CLEANSE COMPLETE ]"
foreach ($ch in $outro.ToCharArray()) {
    $col = @("Green","DarkGreen","Cyan") | Get-Random
    W $ch $col
    Start-Sleep -Milliseconds (Get-Random -Min 15 -Max 55)
}
NL; NL

WL "                        press any key to disconnect_" "DarkGreen"
NL
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
