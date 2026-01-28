$baseUrl = "https://sharkz-dev.github.io/minemon.github.io"                                                                                                                                                 
  Write-Output "=== MODS ==="                                                                                                                                                                              
  Get-ChildItem -Path ".\mods" -Filter "*.jar" | ForEach-Object {
      $hash = (Get-FileHash -Algorithm MD5 $_.FullName).Hash.ToLower()
      $size = $_.Length
      $name = $_.BaseName

      Write-Output "{"
      Write-Output "    `"id`": `"mod:$name`","
      Write-Output "    `"name`": `"$name`","
      Write-Output "    `"type`": `"FabricMod`","
      Write-Output "    `"required`": { `"value`": true, `"def`": true },"
      Write-Output "    `"artifact`": {"
      Write-Output "        `"size`": $size,"
      Write-Output "        `"MD5`": `"$hash`","
      Write-Output "        `"url`": `"$baseUrl/mods/$($_.Name)`""
      Write-Output "    }"
      Write-Output "},"
      Write-Output ""
  }