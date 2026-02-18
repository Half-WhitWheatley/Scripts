# Powershell script allowing user add a selected printer from a predetermined print server.


# Set "name-of-print-server" to the name of the print server you want to be used 
$printserver = "name-of-print-server"

# Outputs list of printers on print server
$printerlist = Get-Printer -ComputerName "$printserver" | Select-Object -ExpandProperty Name

$printername = Read-Host -Prompt "What is the name of the printer you would like to add?"   

# Checks $printerlist for matching printer name
$propername = ($printerlist -match $printername)

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
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
