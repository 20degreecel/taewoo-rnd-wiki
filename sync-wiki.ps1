param (
    [string]$SourcePath = "c:\Users\teoyo\Downloads\VSCODE",
    [string]$WikiDocsPath = "c:\Users\teoyo\Downloads\VSCODE\my-wiki\docs"
)

Write-Host "=================="
Write-Host "  Wiki Sync"
Write-Host "=================="

$SyncFolders = @(
    @{ Source = "$SourcePath\회의록"; Dest = "$WikiDocsPath\01-회의록" },
    @{ Source = "$SourcePath\TAEWOO\DETAILING_RND_SOLUTIONS"; Dest = "$WikiDocsPath\02-RND_솔루션" },
    @{ Source = "$SourcePath\ai-slide-deck\docs"; Dest = "$WikiDocsPath\03-PPT_및_프로토타입\ai-slide-deck" },
    @{ Source = "$SourcePath\dong-a-st-prototype\docs"; Dest = "$WikiDocsPath\03-PPT_및_프로토타입\dong-a-st-prototype" },
        @{ Source = "\data\docs"; Dest = "$WikiDocsPath\04-데이터" },
    @{ Source = "C:\Users\teoyo\.gemini\antigravity\brain"; Dest = "$WikiDocsPath\05-AI_작업기록" }
)

Remove-Item -Path "$WikiDocsPath\*" -Recurse -Force -ErrorAction SilentlyContinue

foreach ($folder in $SyncFolders) {
    if (Test-Path $folder.Source) {
        New-Item -ItemType Directory -Path $folder.Dest -Force | Out-Null
                if ($folder.Source -like "*brain*") {
            Get-ChildItem -Path $folder.Source -Filter "*.md" -Recurse | Copy-Item -Destination $folder.Dest -ErrorAction SilentlyContinue
        } else {
            Copy-Item "$($folder.Source)\*.md" -Destination $folder.Dest -ErrorAction SilentlyContinue
        }
    }
}

Remove-Item "$WikiDocsPath\02-RND_솔루션\walkthrough.md" -ErrorAction SilentlyContinue
Remove-Item "$WikiDocsPath\02-RND_솔루션\task.md" -ErrorAction SilentlyContinue

Get-ChildItem -Path $WikiDocsPath -Filter "*.md" -Recurse | Where-Object { $_.Name -ne "intro.md" } | ForEach-Object {
    $fileInfo = $_
    $timestamp = $fileInfo.LastWriteTime.ToString("yyyy-MM-dd_HH-mm-ss")
    $newName = "${timestamp}_$($fileInfo.Name)"
    
    $year = $timestamp.Substring(2, 2)
    $month = $timestamp.Substring(5, 2)
    $day = $timestamp.Substring(8, 2)
    $hour = $timestamp.Substring(11, 2)
    $minute = $timestamp.Substring(14, 2)
    $displayTime = "[$year.$month.$day {0}:{1}] " -f $hour, $minute
    
    $content = [System.IO.File]::ReadAllText($fileInfo.FullName, [System.Text.Encoding]::UTF8)
    
    $lines = $content -split "`r?`n"
    $extractedTitle = ""
    for ($i = 0; $i -lt [math]::Min($lines.Length, 20); $i++) {
        if ($lines[$i] -match "^#\s+(.+)$") {
            $extractedTitle = $matches[1].Trim()
            break
        }
    }
    
    if ([string]::IsNullOrWhiteSpace($extractedTitle)) {
        $extractedTitle = $fileInfo.Name.Replace(".md", "").Replace("_", " ")
    }
    
    $extractedTitle = $extractedTitle -replace "'", "''"
    $frontmatter = "---
sidebar_label: '${displayTime}${extractedTitle}'
title: '${displayTime}${extractedTitle}'
---

"
    $newContent = $frontmatter + $content

    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($fileInfo.FullName, $newContent, $utf8NoBom)
    
    Rename-Item -Path $fileInfo.FullName -NewName $newName -PassThru | Out-Null
}

Write-Host "Sync Complete"

