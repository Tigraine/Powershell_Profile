$Global:CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$UserType = "User"
$CurrentUser.Groups | foreach { 
    if ($_.value -eq "S-1-5-32-544") {
        $UserType = "Admin" } 
    }

function prompt {
     # Fun stuff if using the standard PowerShell prompt; not useful for Console2.
     # This, and the variables above, could be commented out.
     if($UserType -eq "Admin") {
       $host.UI.RawUI.WindowTitle = "" + $(get-location) + " : Admin"
       $host.UI.RawUI.ForegroundColor = "white"
      }
     else {
       $host.ui.rawui.WindowTitle = $(get-location)
     }

    Write-Host("")
    $status_string = ""
    $symbolicref = git symbolic-ref HEAD
    if($symbolicref -ne $NULL) {
        $status_string += "GIT [" + $symbolicref.substring($symbolicref.LastIndexOf("/") +1) + "] "
    }
    else {
        $status_string = "PS "
    }

    if ($status_string.StartsWith("GIT")) {
        Write-Host ($status_string + $(get-location) + ">") -nonewline -foregroundcolor yellow
    }
    else {
        Write-Host ($status_string + $(get-location) + ">") -nonewline -foregroundcolor green
    }
    return " "
 }