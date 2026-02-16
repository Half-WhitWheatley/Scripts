# Powershell script allowing user add a selected printer from a predetermined print server.


# Set "name-of-print-server" to the name of the print server you want to be used 
$printserver = "name-of-print-server"

# Outputs list of printers on print server
Get-Printer -ComputerName "$printserver" |
    Export-Csv -Path .\printers.csv -NoTypeInformation

$printername = Read-Host -Prompt "What is the name of the printer you would like to add?"   

# Checks printers.csv for matching printer name
$propername = Select-String -InputObject <./printers.csv> -Pattern <*$printername*>

# Confirms with user that the printer name is correct before adding printer
$Title = "Is $propername correct?"
$Prompt = "Yes or No?"
$Choices = [System.Management.Automation.Host.ChoiceDescription[]] @("&Yes", "&No")
$Default = 0
$Choice = $host.UI.PromptForChoice($Title, $Prompt, $Choices, $Default)
switch($Choice)
{
    0 { Add-Printer -ConnectionName \\$printserver\$propername
        Write-Host "Printer $propername added successfully!"
    }
    1 { Write-Host "Sorry, please try again. Printer name typically starts with 'PRTI-'"
    }
}

Write-Host "Press Any Key To Exit"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")





