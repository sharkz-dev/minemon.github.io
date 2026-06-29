$outputFile = "fabric.json"

Get-ChildItem -Path ".\fabric" -Filter "*.jar" -File | ForEach-Object {
    $hash = (Get-FileHash -Algorithm MD5 $_.FullName).Hash.ToLower()
    $size = $_.Length

    $item = @{
        id = "net.fabricmc:fabric-loader:0.19.3"
        name = "Fabric (fabric-loader)"
        type = "Fabric"
        artifact = @{
            size = $size
            MD5  = $hash
            url  = "https://maven.fabricmc.net/net/fabricmc/fabric-loader/0.19.3/fabric-loader-0.19.3.jar"
        }
    }

    $item | ConvertTo-Json -Depth 6 | Out-File $outputFile -Encoding UTF8
}