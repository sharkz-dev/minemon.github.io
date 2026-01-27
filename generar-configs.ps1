$baseUrl = "https://sharkz-dev.github.io/minemon.github.io"
$outputFile = "files.json"

$items = @()

Get-ChildItem -Path ".\config" -Recurse -File | ForEach-Object {
    $hash = (Get-FileHash -Algorithm MD5 $_.FullName).Hash.ToLower()
    $size = $_.Length
    $relative = $_.FullName.Substring((Get-Location).Path.Length + 1).Replace("\", "/")

    $items += @{
        id = "file:$($_.Name)"
        name = $_.Name
        type = "File"
        artifact = @{
            size = $size
            MD5  = $hash
            url  = "$baseUrl/$relative"
            path = $relative
        }
    }
}

$items | ConvertTo-Json -Depth 5 | Out-File $outputFile -Encoding UTF8
