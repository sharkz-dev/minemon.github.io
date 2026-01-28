$baseUrl = "https://sharkz-dev.github.io/minemon.github.io/options-optimizadas"

# Carpeta donde está el script
$root = $PSScriptRoot
if (-not $root) { $root = (Get-Location).Path }

$filePath   = Join-Path $root "options.txt"
$outputFile = Join-Path $root "options.json"

if (-not (Test-Path $filePath)) {
    throw "No se encontró options.txt en: $filePath"
}

$file = Get-Item $filePath
$hash = (Get-FileHash -Algorithm MD5 $file.FullName).Hash.ToLower()
$size = $file.Length

$data = @{
    id   = "file:options.txt"
    name = "Options"
    type = "File"
    artifact = @{
        size = $size
        MD5  = $hash
        url  = "$baseUrl/options.txt"
        path = "options.txt"
    }
}

$data | ConvertTo-Json -Depth 10 | Set-Content -Path $outputFile -Encoding UTF8
Write-Host "Listo ✅ Generado: $outputFile"
