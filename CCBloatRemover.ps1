Register-WmiEvent -Query "SELECT * FROM __InstanceCreationEvent WITHIN 1 WHERE TargetInstance ISA 'Win32_Process'" -Action {
    $processName = $event.SourceEventArgs.NewEvent.TargetInstance.Name
    $processId = $event.SourceEventArgs.NewEvent.TargetInstance.ProcessId

    if ($processName -match "Adobe" -or $processName -match "Creative" -or $processName -match "Adobe" -or $processName -match "CCX" -or $processName -match "CoreSync") {
        Write-Host $processName
        Stop-Process -Id  $processId -Force
    }
} -SourceIdentifier "ProcessCreationWatcher"

while ($true) {
    Start-Sleep -Seconds 1
}

Unregister-Event -SourceIdentifier "ProcessCreationWatcher"
