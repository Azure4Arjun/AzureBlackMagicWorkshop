# Initialisieren einer Variable
$AzureCmdlets = 0

# Auslesen aller Module die Azure im Namen haben
$modules = Get-Module -ListAvailable | where { $_.Name -like "*Azure*"}

# Durchlaufen aller Azure Module und z�hlen der dazugeh�rigen Cmdltes
foreach ($module in $modules){
    Import-Module $module.Name
    $TmpCmdlets = get-command -Module $module.Name | measure
    $AzureCmdlets += $TmpCmdlets.Count
    write-host "Cmdlets: $($TmpCmdlets.Count)  Module: $($module.Name)"
}

# Anzahl der zur Verf�gung stehenden Azure Cmdlets
write-host "Total Azure cmdlets: $AzureCmdlets" 
