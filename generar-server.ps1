$baseUrl = "https://sharkz-dev.github.io/minemon.github.io"

# Siempre guarda / busca relativo a la carpeta del .ps1
$root = $PSScriptRoot
if (-not $root) { $root = (Get-Location).Path }  # por si lo pegas directo en consola

$filePath   = Join-Path $root "servers.dat"
$outputFile = Join-Path $root "servers.json"

if (-not (Test-Path $filePath)) {
    throw "No se encontró servers.dat en: $filePath (estás ejecutando desde otra carpeta o el archivo no existe ahí)"
}

$file = Get-Item $filePath
$hash = (Get-FileHash -Algorithm MD5 $file.FullName).Hash.ToLower()
$size = $file.Length

$data = @{
    id   = "file:servers.dat"
    name = "Server List"
    type = "File"
    artifact = @{
        size = $size
        MD5  = $hash
        url  = "$baseUrl/servers.dat"
        path = "servers.dat"
    }
}

$data | ConvertTo-Json -Depth 10 | Set-Content -Path $outputFile -Encoding UTF8
Write-Host "Listo ✅ Generado: $outputFile"
