$global:pastaOrigem  = "<INSERIR REP DE ORIGEM>"
$global:pastaDestino = "<INSERIR REP DE DESTINO>"

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $global:pastaOrigem
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

$action = {
    $caminho  = $Event.SourceEventArgs.FullPath
    $destino  = $caminho.Replace($global:pastaOrigem, $global:pastaDestino)

    if (Test-Path $caminho -PathType Container) { return }

    if (!(Test-Path "\\tsclient\C")) { return }

    $dir = Split-Path $destino
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }

    try {
        Start-Sleep -Milliseconds 300 
        Copy-Item -Path $caminho -Destination $destino -Force -ErrorAction Stop
    } catch {}
}

Register-ObjectEvent $watcher "Changed" -Action $action | Out-Null
Register-ObjectEvent $watcher "Created" -Action $action | Out-Null

while ($true) { Start-Sleep 1 }