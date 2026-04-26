Add-Type -AssemblyName System.IO.Compression.FileSystem

$WorkingDir = "C:\Users\HP\android-audit"
$ExtractionDir = "$WorkingDir\dex-extracted"

New-Item -ItemType Directory -Force -Path $ExtractionDir | Out-Null

$ApkArchive = [System.IO.Compression.ZipFile]::OpenRead("$WorkingDir\UnCrackable-Level1.apk")

foreach ($EntryItem in $ApkArchive.Entries) {
    if ($EntryItem.Name -match "^classes.*\.dex$") {
        $TargetPath = Join-Path $ExtractionDir $EntryItem.Name
        [System.IO.Compression.ZipFileExtensions]::ExtractToFile($EntryItem, $TargetPath, $true)
        Write-Host "Extrait : $($EntryItem.Name)"
    }
}

$ApkArchive.Dispose()
Write-Host "Termine !"