# Script to get wezterm-gui PID(s), find the latest gui-sock file, set WEZTERM_UNIX_SOCKET environment variable, 
# spawn a new tab in the current directory, and bring the WezTerm window to the forefront

# Get the current working directory (from where the script is called)
$currentDir = (Get-Location).Path

# Get the PID(s) of wezterm-gui processes
$processIds = Get-Process -Name wezterm-gui -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Id

if ($processIds.Count -eq 0) {
    Write-Host "No 'wezterm-gui' processes found. Starting a new WezTerm instance..."
    Write-Host "Opening WezTerm in directory: $currentDir"
    
    # Start a new WezTerm instance in the current directory
    Start-Process "wezterm-gui" -ArgumentList "start", "--cwd", "`"$currentDir`""
    Write-Host "New WezTerm instance started successfully in $currentDir!"
} else {
    # Base directory for socket files (using your confirmed location; customize if needed)
    $socketDir = "C:\Users\f77714c\.local\share\wezterm"
    
    # Collect existing socket files corresponding to the PIDs
    $existingSockets = @()
    foreach ($processId in $processIds) {
        $socketPath = Join-Path $socketDir "gui-sock-$processId"
        if (Test-Path $socketPath) {
            $fileItem = Get-Item $socketPath
            $existingSockets += [PSCustomObject]@{
                Path = $socketPath
                ProcessId = $processId
                CreationTime = $fileItem.CreationTime
            }
            Write-Host "Found socket file: $socketPath (Created: $($fileItem.CreationTime))"
        } else {
            Write-Host "No socket file found for PID $processId (skipping)."
        }
    }
    
    if ($existingSockets.Count -eq 0) {
        Write-Error "No valid gui-sock files found for the detected PIDs ($($processIds -join ', ')). Check the directory: $socketDir"
    } else {
        # Select the socket with the latest creation time
        $latestSocket = $existingSockets | Sort-Object CreationTime -Descending | Select-Object -First 1
        
        # Set the environment variable
        $env:WEZTERM_UNIX_SOCKET = $latestSocket.Path
        
        # Output confirmation
        Write-Host "Selected latest socket (PID $($latestSocket.ProcessId), Created: $($latestSocket.CreationTime)): $env:WEZTERM_UNIX_SOCKET"
        Write-Host "You can now run WezTerm CLI commands in this session."
        
        # Get the current working directory (from where the script is called)
        Write-Host "Spawning new tab in current directory: $currentDir"

        # Spawn the new tab in the current directory
        $spawnCommand = "wezterm cli spawn --cwd `"$currentDir`""
        Invoke-Expression $spawnCommand

        # Check if the spawn was successful
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed to spawn new tab. Exit code: $LASTEXITCODE. Ensure WezTerm CLI is installed and the socket is valid."
        } else {
            Write-Host "New tab spawned successfully in $currentDir!"
            
            # Bring the WezTerm window for the selected PID to the forefront
            $pidToActivate = $latestSocket.ProcessId
            Write-Host "Activating WezTerm window for PID $pidToActivate..."
            
            # Define Win32 API for SetForegroundWindow
            Add-Type @"
            using System;
            using System.Runtime.InteropServices;
            public class WindowActivator {
                [DllImport("user32.dll")]
                [return: MarshalAs(UnmanagedType.Bool)]
                public static extern bool SetForegroundWindow(IntPtr hWnd);
            }
"@
            
            # Get the process and its main window handle
            $process = Get-Process -Id $pidToActivate -ErrorAction SilentlyContinue
            if ($process -and $process.MainWindowHandle -ne [IntPtr]::Zero) {
                [WindowActivator]::SetForegroundWindow($process.MainWindowHandle) | Out-Null
                Write-Host "WezTerm window (PID $pidToActivate) brought to the forefront successfully!"
            } else {
                Write-Warning "Could not find a valid main window for PID $pidToActivate. Ensure WezTerm is running and not minimized/hidden."
            }
        }
    }
}
