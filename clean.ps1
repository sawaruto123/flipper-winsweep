# ================================================================
#  W I N S W E E P  //  NEURAL CLEANSE PROTOCOL v2.1
#  github.com/sawaruto123/flipper-winsweep
# ================================================================

# Force UTF-8 so box-drawing chars render correctly
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$Host.UI.RawUI.WindowTitle = "WINSWEEP // NEURAL CLEANSE PROTOCOL v2.1"

try {
    $sz = $Host.UI.RawUI.WindowSize; $sz.Width = 90; $sz.Height = 46
    $Host.UI.RawUI.WindowSize = $sz
    $bf = $Host.UI.RawUI.BufferSize; $bf.Width = 90
    $Host.UI.RawUI.BufferSize = $bf
} catch {}

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Green"
Clear-Host

# ── Write helpers ────────────────────────────────────────────────
function W($t, $c="Green")  { Write-Host $t -ForegroundColor $c -NoNewline }
function WL($t, $c="Green") { Write-Host $t -ForegroundColor $c }
function NL { Write-Host "" }
function HR { WL ("  " + ([char]0x2550 * 86)) "DarkGreen" }
function HR2 { WL ("  " + ([char]0x2500 * 86)) "DarkGreen" }

# ── Typewriter ───────────────────────────────────────────────────
function Type-Line($text, $color="Green", $delay=12) {
    foreach ($ch in $text.ToCharArray()) {
        W $ch $color
        Start-Sleep -Milliseconds $delay
    }
    Write-Host ""
}

# ── Glitch effect ────────────────────────────────────────────────
function Glitch($final, $color="Green", $cycles=7) {
    $chars = "!@#%^&*<>?/\|~`0123456789ABCDEF"
    $pos = $Host.UI.RawUI.CursorPosition
    for ($i = 0; $i -lt $cycles; $i++) {
        $fake = -join ((1..$final.Length) | ForEach-Object { $chars[(Get-Random -Max $chars.Length)] })
        $Host.UI.RawUI.CursorPosition = $pos
        W $fake "DarkGreen"
        Start-Sleep -Milliseconds 40
    }
    $Host.UI.RawUI.CursorPosition = $pos
    WL $final $color
}

# ── Format bytes (using [long] to avoid Int32 overflow) ──────────
function Format-Size([long]$bytes) {
    if (!$bytes -or $bytes -le 0) { return "0 B" }
    if ($bytes -ge 1GB) { return "{0:N2} GB" -f ($bytes / 1GB) }
    if ($bytes -ge 1MB) { return "{0:N1} MB" -f ($bytes / 1MB) }
    if ($bytes -ge 1KB) { return "{0:N0} KB" -f ($bytes / 1KB) }
    return "$bytes B"
}

# ── Folder helpers ───────────────────────────────────────────────
function Get-FolderSize($path) {
    if (-not (Test-Path $path)) { return [long]0 }
    try {
        $sum = (Get-ChildItem $path -Recurse -Force -ErrorAction SilentlyContinue |
                Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
        if ($sum) { return [long]$sum } else { return [long]0 }
    } catch { return [long]0 }
}

function Clear-Folder($path) {
    [long]$before = Get-FolderSize $path
    if ($before -eq 0) { return [long]0 }
    Get-ChildItem $path -Recurse -Force -ErrorAction SilentlyContinue |
        Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    return $before
}

# ── Progress bar using [long] math ──────────────────────────────
function Show-Bar($label, [int]$pct, [long]$freed, $color="Green", $done=$false) {
    $barW   = 34
    $filled = [int][math]::Round($barW * $pct / 100)
    $empty  = $barW - $filled
    $fill   = [char]0x2588  # █
    $shade  = [char]0x2592  # ▒
    $bar    = ($fill.ToString() * $filled) + ($shade.ToString() * $empty)
    $lpad   = " " * [math]::Max(0, (20 - $label.Length))
    $sizeStr = if ($done -and $freed -gt 0) { Format-Size $freed }
               elseif ($done) { "clean" }
               else { "scanning..." }
    $line = "  {0}{1} {2}{3}{4} {5,4}%  {6}" -f $label, $lpad,
        [char]0x2502, $bar, [char]0x2502, $pct, $sizeStr
    Write-Host "`r$line" -ForegroundColor $color -NoNewline
}

function Run-Step($label, $color="Green", [scriptblock]$action) {
    $frames = @(0,8,18,30,45,60,74,85,93,98,100)
    foreach ($p in $frames) {
        Show-Bar $label $p 0 $color $false
        Start-Sleep -Milliseconds (Get-Random -Min 50 -Max 130)
    }
    [long]$freed = 0
    try { $freed = [long](& $action) } catch {}
    Show-Bar $label 100 $freed $color $true
    Write-Host ""
    return $freed
}

# ════════════════════════════════════════════════════════════════
#  BOOT SEQUENCE
# ════════════════════════════════════════════════════════════════
Clear-Host
NL
WL "  $([char]0x2588*2)    $([char]0x2588*2)$([char]0x2588*2)$([char]0x2588*3)   $([char]0x2588*3)$([char]0x2588*7)   $([char]0x2588*2)    $([char]0x2588*2)$([char]0x2588*7)$([char]0x2588*7)$([char]0x2588*6) " "Green"

# ASCII-art banner (pure ASCII, always renders)
WL "  __    __ ___ _  _ _____      __ ___ ___ ___" "Green"
WL "  \ \  / /|_ _| \| / __\ \    / /| __| __| _ \" "Green"
WL "   \ \/ /  | || .  \__ \\ \/\/ / | _|| _||  _/" "Green"
WL "    \__/  |___|_|\_|___/ \_/\_/  |___|___|_|  " "DarkGreen"
NL
HR
W  "  NEURAL CLEANSE PROTOCOL " "Cyan"
W  "v2.1" "Green"
W  "   //   " "DarkGray"
W  "FLIPPER ZERO" "Green"
W  "   //   " "DarkGray"
WL "SYS:$(($env:COMPUTERNAME).ToUpper())  USR:$(($env:USERNAME).ToUpper())" "DarkGreen"
HR
NL

Start-Sleep -Milliseconds 200

# Boot log
$bootLog = @(
    "[INIT]  .. kernel modules loaded",
    "[INIT]  .. entropy pool seeded",
    "[AUTH]  .. device fingerprint: FLIPPER//ZERO",
    "[AUTH]  .. clearance level OMEGA granted",
    "[NET]   .. secure channel established",
    "[SCAN]  .. filesystem tree mounted",
    "[SCAN]  .. junk node enumeration complete",
    "[WARN]  .. debris detected across 11 sectors",
    "[ARM]   .. neural cleanse sequence READY"
)

foreach ($line in $bootLog) {
    $tag = $line.Substring(0,6)
    $rest = $line.Substring(6)
    $tagColor = switch ($tag.Trim()) {
        "WARN"  { "Yellow" }
        "ARM"   { "Cyan" }
        "AUTH"  { "Green" }
        default { "DarkGreen" }
    }
    W "  $tag" $tagColor
    foreach ($ch in $rest.ToCharArray()) {
        W $ch "Gray"
        Start-Sleep -Milliseconds (Get-Random -Min 3 -Max 11)
    }
    Write-Host ""
    Start-Sleep -Milliseconds (Get-Random -Min 60 -Max 140)
}

NL
HR2
NL

# ── Deep scan with fake hex addresses ───────────────────────────
WL "  [DEEP SCAN]  Traversing memory sectors..." "Yellow"
NL

$addrs = @("0xC0FF3E00","0xDEADB33F","0xBADC0DE1","0xFEEDF4CE",
           "0xC0DEBABE","0xDEFEC8ED","0xCAFED00D","0xB105F00D")
$tags  = @("DIRTY","STALE","ORPHANED","FRAGMENTED","CORRUPT","BLOATED")

foreach ($addr in $addrs) {
    $status = $tags | Get-Random
    $kb = Get-Random -Min 256 -Max 9999
    W "  $addr" "DarkGreen"
    W "  $([char]0x2502)$status$([char]0x2502)" "Yellow"
    WL "  ${kb} KB flagged for purge" "DarkGray"
    Start-Sleep -Milliseconds (Get-Random -Min 55 -Max 150)
}

NL
W "  " "DarkGray"
Glitch ">>> SCAN COMPLETE. INITIATING PURGE SEQUENCE <<<" "Green" 8
NL
HR2
NL

# ════════════════════════════════════════════════════════════════
#  PURGE PHASE
# ════════════════════════════════════════════════════════════════
WL "  [PURGE]  Executing neural cleanse..." "Cyan"
NL

[long]$total = 0

$steps = @(
    @{ label="USER TEMP";     color="Green";     code={ Clear-Folder $env:TEMP } },
    @{ label="SYSTEM TEMP";   color="Green";     code={ Clear-Folder "C:\Windows\Temp" } },
    @{ label="PREFETCH";      color="Cyan";      code={ Clear-Folder "C:\Windows\Prefetch" } },
    @{ label="WIN UPDATE";    color="Cyan";      code={
        Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
        $b = Clear-Folder "C:\Windows\SoftwareDistribution\Download"
        Start-Service -Name wuauserv -ErrorAction SilentlyContinue
        $b
    }},
    @{ label="THUMBNAIL DB";  color="Yellow";    code={
        $p = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer"
        $b = Get-FolderSize $p
        Get-ChildItem $p -Filter "thumbcache_*.db" -Force -ErrorAction SilentlyContinue |
            Remove-Item -Force -ErrorAction SilentlyContinue
        $b
    }},
    @{ label="CHROME CACHE";  color="Yellow";    code={ Clear-Folder "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache" } },
    @{ label="EDGE CACHE";    color="Yellow";    code={ Clear-Folder "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache" } },
    @{ label="FIREFOX CACHE"; color="Yellow";    code={
        $p = "$env:APPDATA\Mozilla\Firefox\Profiles"; [long]$t = 0
        if (Test-Path $p) { Get-ChildItem $p -Directory | ForEach-Object { $t += Clear-Folder (Join-Path $_.FullName "cache2") } }
        $t
    }},
    @{ label="RECYCLE BIN";   color="DarkYellow";code={
        [long]$b = 0
        try {
            $sh = New-Object -ComObject Shell.Application
            $rb = $sh.Namespace(0xA)
            $b  = [long]($rb.Items() | Measure-Object -Property Size -Sum).Sum
            Clear-RecycleBin -Force -ErrorAction SilentlyContinue
        } catch {}
        $b
    }},
    @{ label="DNS CACHE";     color="DarkCyan";  code={ ipconfig /flushdns | Out-Null; [long]0 } },
    @{ label="EVENT LOGS";    color="DarkCyan";  code={
        [long]$b = Get-FolderSize "C:\Windows\System32\winevt\Logs"
        Get-EventLog -List -ErrorAction SilentlyContinue |
            ForEach-Object { Clear-EventLog -LogName $_.Log -ErrorAction SilentlyContinue }
        $b
    }}
)

foreach ($step in $steps) {
    [long]$freed = Run-Step $step.label $step.color $step.code
    $total += $freed
    $tag    = if ($freed -gt 0) { "PURGED" } else { "CLEAN " }
    $tagCol = if ($freed -gt 0) { "Green"  } else { "DarkGray" }
    W "  [$tag] " $tagCol
    W "$($step.label)" "DarkGray"
    W (" " * [math]::Max(1,(16 - $step.label.Length))) "DarkGray"
    WL (Format-Size $freed) "White"
    Start-Sleep -Milliseconds 60
}

NL
HR
NL

# ════════════════════════════════════════════════════════════════
#  SUMMARY — animated ticker with [long] math
# ════════════════════════════════════════════════════════════════
WL "  [COMPLETE]  Neural cleanse finished." "Green"
NL

[long]$display = 0
$ticks = 50
[long]$stepSize = [math]::Max(1, [long]($total / $ticks))
$fill  = [char]0x2588
$shade = [char]0x2592

for ($i = 0; $i -lt $ticks; $i++) {
    $display = [long][math]::Min($total, $display + $stepSize)
    $pct     = if ($total -gt 0) { [int]($display * 40 / $total) } else { 40 }
    $bar     = ($fill.ToString() * $pct) + ($shade.ToString() * (40 - $pct))
    $pos     = $Host.UI.RawUI.CursorPosition
    W "  TOTAL FREED  $([char]0x2502)" "DarkGray"
    W $bar "Green"
    W "$([char]0x2502)  " "DarkGray"
    W (Format-Size $display) "Cyan"
    $Host.UI.RawUI.CursorPosition = $pos
    Start-Sleep -Milliseconds 22
}
# Final line
$bar = $fill.ToString() * 40
W "  TOTAL FREED  $([char]0x2502)" "DarkGray"
W $bar "Green"
W "$([char]0x2502)  " "DarkGray"
WL (Format-Size $total) "Cyan"

NL

# System info
$os  = Get-WmiObject Win32_OperatingSystem -ErrorAction SilentlyContinue
$ram = if ($os) { "{0:N1} GB free" -f ($os.FreePhysicalMemory / 1MB) } else { "N/A" }
$up  = if ($os) {
    $t = (Get-Date) - $os.ConvertToDateTime($os.LastBootUpTime)
    "{0}d {1}h {2}m" -f $t.Days, $t.Hours, $t.Minutes
} else { "N/A" }

$col1 = "DarkGray"; $col2 = "White"
W "  RAM       " $col1; WL $ram $col2
W "  UPTIME    " $col1; WL $up  $col2
W "  OPERATOR  " $col1; WL ($env:USERNAME).ToUpper() $col2
W "  MACHINE   " $col1; WL ($env:COMPUTERNAME).ToUpper() $col2
W "  TIMESTAMP " $col1; WL (Get-Date -Format "yyyy-MM-dd  HH:mm:ss") $col2

NL
HR
NL

Glitch "  >>> SYSTEM PURGED. TRACES ELIMINATED. STAY GHOST. <<<" "Green" 10
NL

# Outro typewriter
W "  " "DarkGray"
$outro = "[ FLIPPER ZERO  //  WINSWEEP v2.1  //  NEURAL CLEANSE COMPLETE ]"
foreach ($ch in $outro.ToCharArray()) {
    $c = @("Green","Green","DarkGreen","Cyan") | Get-Random
    W $ch $c
    Start-Sleep -Milliseconds (Get-Random -Min 12 -Max 50)
}

NL; NL
WL "                      press any key to disconnect_" "DarkGreen"
NL
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
