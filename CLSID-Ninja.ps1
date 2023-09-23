param(
  #Search
  [Parameter(Mandatory = $false)]
  [ValidateSet('CLSID','All','Menu')]
  [string]$Search,

  # Additional argument
  [string]$IS

)

Write-Output ""
Write-Output "▄████████  ▄█          ▄████████  ▄█  ████████▄"  
Write-Output "███    ███ ███         ███    ███ ███  ███   ▀███" 
Write-Output "███    █▀  ███         ███    █▀  ███▌ ███    ███" 
Write-Output "███        ███         ███        ███▌ ███    ███" 
Write-Output "███        ███       ▀███████████ ███▌ ███    ███" 
Write-Output "███    █▄  ███                ███ ███  ███    ███" 
Write-Output "███    ███ ███▌    ▄    ▄█    ███ ███  ███   ▄███" 
Write-Output "████████▀  █████▄▄██  ▄████████▀  █▀   ████████▀" 
Write-Output "           ▀"                                      
Write-Output "███▄▄▄▄    ▄█  ███▄▄▄▄        ▄█    ▄████████"     
Write-Output "███▀▀▀██▄ ███  ███▀▀▀██▄     ███   ███    ███"     
Write-Output "███   ███ ███▌ ███   ███     ███   ███    ███"     
Write-Output "███   ███ ███▌ ███   ███     ███   ███    ███"     
Write-Output "███   ███ ███▌ ███   ███     ███ ▀███████████"     
Write-Output "███   ███ ███  ███   ███     ███   ███    ███"     
Write-Output "███   ███ ███  ███   ███     ███   ███    ███"     
Write-Output " ▀█   █▀  █▀    ▀█   █▀  █▄ ▄███   ███    █▀"      
Write-Output "                         ▀▀▀▀▀▀"             
Write-Output "Author: Eilay Yosfan             Version 1.0v"
Write-Output ""

switch ($Search) {
    'Menu'{
    Write-Output " Contact me at -> github.com/YosfanEilay"
    Write-Output "┌~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~╮"
    Write-Output "│                                   Menu                                   │"
    Write-Output "├~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~┤"
    Write-Output "│                                                                          │"
    Write-Output "│1. Show all users CLSID's: .\CLSID-Ninja -Search All                      │"
    Write-Output "│                                                                          │"
    Write-Output "├2. Search specific CLSID:  .\CLSID-Ninja -Search CLSID ""{PUT-YOUR-CLSID}"" │"
    Write-Output "│                                                                          │"
    Write-Output "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~╯"
    Write-Output "╰> Example:"
    Write-Output ' .\CLSID-Ninja -Search CLSID "{0003000A-0000-0000-C000-000000000046}"'
    Write-Output ""
    }
}

switch ($Search) {
  'All' {
    # UsrClass.DAT path
    $UsrClass = "AppData\Local\Microsoft\Windows\UsrClass.DAT"

    # Loop on user names from C:\Users
    $Users = Get-ChildItem "C:\Users"

    # Foreach loop only for offline users
    foreach ($User in $Users) {

      # Get only username in a variable
      $OnlyUserName = $user | Select-Object -Property Name | ForEach-Object { $_.Name }

      # Full path to user UsrClass.DAT
      $FullUsrClass = "C:\Users\$OnlyUserName\$UsrClass"

      # if statment for getting only users with UsrClass.DAT file
      if (Test-Path "$FullUsrClass") {

        # Load UsrClass.DAT in to HKLM and capture the output message
        $output = reg load HKLM\Offline-$OnlyUserName "$FullUsrClass" 2>&1

        # Check if the output contains the success message
        if ($output -like "The operation completed successfully.") {

          # Get data from Registry
          $OfflineUsrRegPath = "HKEY_LOCAL_MACHINE\Offline-$OnlyUserName\CLSID\*"

          # Test if CLSID is actualy exist in the offline user UsrClass.DAT hive
          if (Test-Path -Path "Registry::HKEY_LOCAL_MACHINE\Offline-$OnlyUserName\CLSID") {

            #Store all the CLSID's in a variable
            $CLSIDs = Get-ItemProperty -Path "Registry::$OfflineUsrRegPath" | Select-Object -ExpandProperty PSChildName

            Write-Output "+-------------------------------------------------"
            Write-Output "|User Name:   $OnlyUserName"
            Write-Output "|Load Path:   HKLM:\Offline-$OnlyUserName"
            Write-Output "|Load Status: UsrClass.DAT was loaded to - [HKLM:]"
            Write-Output "|Hive Status: Hive will be unloaded at next reboot"
            Write-Output "+-------------------------------------------------"

            # Counting CLSID results
            $counter = 1
            foreach ($CLSID in $CLSIDs) {
              $PerCLSIDRegPath = "Registry::HKEY_LOCAL_MACHINE\Offline-$OnlyUserName\CLSID\$CLSID"
              $Exclude = @("PSPath","PSParentPath","PSProvider","PSChildName")
              $propertyData = Get-ItemProperty -Path $PerCLSIDRegPath | ForEach-Object {
                $_.PSObject.Properties | Where-Object { $_.Name -notin $Exclude } | ForEach-Object {
                  [pscustomobject]@{
                    Property = $_.Name
                    Value = $_.Value
                  }
                }
              }

              Write-Output "├Count: [#$counter]"
              Write-Output "├CLSID: $CLSID"
              foreach ($item in $propertyData) {
                Write-Output "├Value: $($item.Property)"
                Write-Output "├Data:  $($item.Value)"
              }
              Write-Output "|"
              # Add 1 for the counting
              $counter++
            }

          }
        }
      }
    }




    # Online users part of the code

    # UsrClass.DAT path
    $UsrClass = "AppData\Local\Microsoft\Windows\UsrClass.DAT"

    # Loop on user names from C:\Users
    $Users = Get-ChildItem "C:\Users"

    # Foreach loop only for offline users
    foreach ($User in $Users) {

      # Get only username in a variable
      $OnlyUserName = $user | Select-Object -Property Name | ForEach-Object { $_.Name }

      # Full path to user UsrClass.DAT
      $FullUsrClass = "C:\Users\$OnlyUserName\$UsrClass"

      # if statment for getting only users with UsrClass.DAT file
      if (Test-Path "$FullUsrClass") {

        # Load UsrClass.DAT in to HKLM and capture the output message
        $output = reg load HKLM\Offline-$OnlyUserName "$FullUsrClass" 2>&1

        # Check if the output contains the success message
        if ($output -like "ERROR: The process cannot access the file because it is being used by another process.") {

          # Retrieve the user SID using WMI query
          $SID = (Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.LocalPath.EndsWith($OnlyUserName) }).SID

          # Get data from Registry
          $OnlineUsrRegPath = "HKEY_USERS\$SID\Software\Classes\CLSID\*"

          # Test if CLSID is actualy exist
          if (Test-Path -Path "Registry::$OnlineUsrRegPath") {

            #Store all the CLSID's in a variable
            $CLSIDs = Get-ItemProperty -Path "Registry::$OnlineUsrRegPath" | Select-Object -ExpandProperty PSChildName

            Write-Output ""
            Write-Output ""
            Write-Output "+-------------------------"
            Write-Output "|User Name:   $OnlyUserName"
            Write-Output "|Which Hive:  HKEY_USERS"
            Write-Output "|Hive Status: Hive is Live"
            Write-Output "+-------------------------"

            # Counting CLSID results
            $counter = 1
            foreach ($CLSID in $CLSIDs) {
              $PerCLSIDRegPath = "Registry::HKEY_USERS\$SID\Software\Classes\CLSID\$CLSID"
              $Exclude = @("PSPath","PSParentPath","PSProvider","PSChildName")
              $propertyData = Get-ItemProperty -Path $PerCLSIDRegPath | ForEach-Object {
                $_.PSObject.Properties | Where-Object { $_.Name -notin $Exclude } | ForEach-Object {
                  [pscustomobject]@{
                    Property = $_.Name
                    Value = $_.Value
                  }
                }
              }

              Write-Output "├Count: [#$counter]"
              Write-Output "├CLSID: $CLSID"
              foreach ($item in $propertyData) {
                Write-Output "├Value: $($item.Property)"
                Write-Output "├Data:  $($item.Value)"
              }
              Write-Output "|"
              # Add 1 for the counting
              $counter++
            }

          }
        }


      }
    }
  }
}






switch ($Search) {
  'CLSID' {


    # UsrClass.DAT path
    $UsrClass = "AppData\Local\Microsoft\Windows\UsrClass.DAT"

    # Loop on user names from C:\Users
    $Users = Get-ChildItem "C:\Users"

    # Foreach loop only for offline users
    foreach ($User in $Users) {


      # Get only username in a variable
      $OnlyUserName = $user | Select-Object -Property Name | ForEach-Object { $_.Name }

      # Full path to user UsrClass.DAT
      $FullUsrClass = "C:\Users\$OnlyUserName\$UsrClass"

      # if statment for getting only users with UsrClass.DAT file
      if (Test-Path "$FullUsrClass") {

        # Load UsrClass.DAT in to HKLM and capture the output message
        $output = reg load HKLM\Offline-$OnlyUserName "$FullUsrClass" 2>&1


        # Check if the output contains the success message
        if ($output -like "The operation completed successfully.") {

          # Get data from Registry
          $OfflineUsrRegPath = "HKEY_LOCAL_MACHINE\Offline-$OnlyUserName\CLSID\*"

          # Test if CLSID is actualy exist in the offline user UsrClass.DAT hive
          if (Test-Path -Path "Registry::HKEY_LOCAL_MACHINE\Offline-$OnlyUserName\CLSID") {

            #Store all the CLSID's in a variable
            $CLSIDs = Get-ItemProperty -Path "Registry::$OfflineUsrRegPath" | Select-Object -ExpandProperty PSChildName

            Write-Output "+-------------------------------------------------"
            Write-Output "|User Name:   $OnlyUserName"
            Write-Output "|Load Path:   HKLM:\Offline-$OnlyUserName"
            Write-Output "|Load Status: UsrClass.DAT was loaded to - [HKLM:]"
            Write-Output "|Hive Status: Hive will be unloaded at next reboot"
            Write-Output "+-------------------------------------------------"
            foreach ($CLSID in $CLSIDs) {
              $PerCLSIDRegPath = "Registry::HKEY_LOCAL_MACHINE\Offline-$OnlyUserName\CLSID\$CLSID"
              $Exclude = @("PSPath","PSParentPath","PSProvider","PSChildName")
              $propertyData = Get-ItemProperty -Path $PerCLSIDRegPath | ForEach-Object {
                $_.PSObject.Properties | Where-Object { $_.Name -notin $Exclude } | ForEach-Object {
                  [pscustomobject]@{
                    Property = $_.Name
                    Value = $_.Value
                  }
                }


              }
              if ($CLSID -like $IS) {
                Write-Output "├Status: CLSID Was Found!"
                Write-Output "├CLSID: $CLSID"
                foreach ($item in $propertyData) {
                  Write-Output "├Value: $($item.Property)"
                  Write-Output "├Data:  $($item.Value)"
                  $CLSIDMatched = $true
                }
                Write-Output ""
              }
            }
            # Check the flag and execute the else statement if needed
            if (-not $CLSIDMatched) {
              Write-Output "├The CLSID - $IS"
              Write-Output "├Was not found on user - $OnlyUserName."
              Write-Output ""
            }
          }
        }
      }
    }
    $CLSIDMatched = $false
    # UsrClass.DAT path
    $UsrClass = "AppData\Local\Microsoft\Windows\UsrClass.DAT"

    # Loop on user names from C:\Users
    $Users = Get-ChildItem "C:\Users"

    # Foreach loop only for offline users
    foreach ($User in $Users) {

      # Get only username in a variable
      $OnlyUserName = $user | Select-Object -Property Name | ForEach-Object { $_.Name }

      # Full path to user UsrClass.DAT
      $FullUsrClass = "C:\Users\$OnlyUserName\$UsrClass"

      # if statment for getting only users with UsrClass.DAT file
      if (Test-Path "$FullUsrClass") {

        # Load UsrClass.DAT in to HKLM and capture the output message
        $output = reg load HKLM\Offline-$OnlyUserName "$FullUsrClass" 2>&1

        # Check if the output contains the success message
        if ($output -like "ERROR: The process cannot access the file because it is being used by another process.") {

          # Retrieve the user SID using WMI query
          $SID = (Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.LocalPath.EndsWith($OnlyUserName) }).SID

          # Get data from Registry
          $OnlineUsrRegPath = "HKEY_USERS\$SID\Software\Classes\CLSID\*"

          # Test if CLSID is actualy exist
          if (Test-Path -Path "Registry::$OnlineUsrRegPath") {

            #Store all the CLSID's in a variable
            $CLSIDs = Get-ItemProperty -Path "Registry::$OnlineUsrRegPath" | Select-Object -ExpandProperty PSChildName

            Write-Output "+-------------------------"
            Write-Output "|User Name:   $OnlyUserName"
            Write-Output "|Which Hive:  HKEY_USERS"
            Write-Output "|Hive Status: Hive is Live"
            Write-Output "+-------------------------"

            foreach ($CLSID in $CLSIDs) {
              $PerCLSIDRegPath = "Registry::HKEY_USERS\$SID\Software\Classes\CLSID\$CLSID"
              $Exclude = @("PSPath","PSParentPath","PSProvider","PSChildName")
              $propertyData = Get-ItemProperty -Path $PerCLSIDRegPath | ForEach-Object {
                $_.PSObject.Properties | Where-Object { $_.Name -notin $Exclude } | ForEach-Object {
                  [pscustomobject]@{
                    Property = $_.Name
                    Value = $_.Value
                  }
                }
              }
              if ($CLSID -like $IS) {
                Write-Output "├Status: CLSID Was Found!"
                Write-Output "├CLSID: $CLSID"
                foreach ($item in $propertyData) {
                  Write-Output "├Value: $($item.Property)"
                  Write-Output "├Data:  $($item.Value)"
                  $CLSIDMatched = $true
                }
              }
            }
            # Check the flag and execute the else statement if needed
            if (-not $CLSIDMatched) {
              Write-Output "├The CLSID - $IS"
              Write-Output "├Was not found on user - $OnlyUserName."
              Write-Output ""

            }
          }
        }
      }
    }
    Write-Output ""
  }
}
return

