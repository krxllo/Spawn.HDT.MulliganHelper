# Parameters
Param(
	[Parameter(Mandatory=$True)]
	[string]$ExecutableName,
	
	[Parameter(Mandatory=$True)]
	[string]$TargetDir
)

Write-Host Updating to latest Hearthstone-Deck-Tracker executable...

# Initialize fields with required values
Write-Host Determining latest release...
$ReleasesUrl = "https://api.github.com/repos/HearthSim/Hearthstone-Deck-Tracker/releases"
$ReleaseData = (Invoke-WebRequest $ReleasesUrl | ConvertFrom-Json)[0]
$Tag = $ReleaseData.tag_name
$DownloadUrl = $ReleaseData.assets.browser_download_url
$TempZip= $ReleaseData.assets.name
$TempDir = [IO.Path]::GetFileNameWithoutExtension($TempZip)

# Download latest release
Write-Host Downloading $Tag...
(New-Object System.Net.WebClient).DownloadFile($DownloadUrl, $TempZip)
Write-Host Download finished.

# Extract release files
Write-Host Extracting...
Expand-Archive $TempZip -Force

# Search for target file
Write-Host Searching for target file...
$TargetPath = (Join-Path -Path $TempDir -ChildPath (Get-ChildItem -Path $TempDir -Filter $ExecutableName -Recurse -ErrorAction Stop -File -Name))

# Move target file
Write-Host Found file, moving file to target dir...
Remove-Item $TargetDir -Force -Recurse -ErrorAction SilentlyContinue
$null = (New-Item -Path $TargetDir -ItemType Directory)
Move-Item -Path $TargetPath -Destination $TargetDir

# Clean up
Write-Host Cleaning up...
Remove-Item $TempZip -Force
Remove-Item $TempDir -Recurse -Force

Write-Host Update finished.