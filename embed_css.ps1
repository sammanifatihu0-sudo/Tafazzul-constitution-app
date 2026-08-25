$htmlPath = Join-Path $PSScriptRoot "index.html"
$cssPath = Join-Path $PSScriptRoot "css\style.css"

$html = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)
$css = [System.IO.File]::ReadAllText($cssPath, [System.Text.Encoding]::UTF8)

# Replace <link rel="stylesheet" href="css/style.css"> with <style>...</style> and fallback
$replacement = "<link rel=""stylesheet"" href=""css/style.css"">`n  <style>`n$css`n  </style>"
$newHtml = $html -replace '<link rel="stylesheet" href="css/style\.css">', $replacement

[System.IO.File]::WriteAllText($htmlPath, $newHtml, [System.Text.Encoding]::UTF8)
Write-Host "Successfully embedded full CSS into index.html!"
