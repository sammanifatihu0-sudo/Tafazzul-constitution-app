Add-Type -AssemblyName System.Drawing

function Create-AppIcon($size, $filename) {
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

    # Background
    $rect = New-Object System.Drawing.Rectangle(0, 0, $size, $size)
    $bgBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(15, 23, 42))
    $g.FillRectangle($bgBrush, $rect)

    # Gold circular border
    $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(217, 119, 6), ($size / 24))
    $innerPad = [int]($size * 0.08)
    $g.DrawEllipse($pen, $innerPad, $innerPad, ($size - ($innerPad * 2)), ($size - ($innerPad * 2)))

    # Letter T & C or Emblem
    $font = New-Object System.Drawing.Font("Arial", [float]($size * 0.38), [System.Drawing.FontStyle]::Bold)
    $textBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center

    $textRect = New-Object System.Drawing.RectangleF(0, 0, $size, $size)
    $g.DrawString("TC", $font, $textBrush, $textRect, $sf)

    $savePath = Join-Path $PSScriptRoot $filename
    $bmp.Save($savePath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
    Write-Host "Created $filename ($size x $size)"
}

Create-AppIcon 192 "icon-192.png"
Create-AppIcon 512 "icon-512.png"
