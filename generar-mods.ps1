$baseUrl = "https://sharkz-dev.github.io/minemon.github.io"
$outputFile = "mods.json"

$items = @()

Get-ChildItem -Path ".\mods" -Filter "*.jar" -File | ForEach-Object {
    $hash = (Get-FileHash -Algorithm MD5 $_.FullName).Hash.ToLower()
    $size = $_.Length
    $name = $_.BaseName

    $items += @{
        id = "mod:$name"
        name = $name
        type = "FabricMod"
        required = @{
            value = $true
            def   = $true
        }
        artifact = @{
            size = $size
            MD5  = $hash
            url  = "$baseUrl/mods/$($_.Name)"
        }
    }
}

$items | ConvertTo-Json -Depth 6 | Out-File $outputFile -Encoding UTF8
