# Definieren von loaken Variablen

# Name des Storage Accounts Pr�fix
$basename = "tecgn00"

# NAme der ResourceGroup
$resourceGroupName = "BlackMagicCGN"

#Auslesen aller Storage Accounts in der ResourceGroup
$storages = @(Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName)

# Anlegen eines HashTable
$StampIpList = @{}

# Pr�fen ob ein StorageAccount bereits existiert# SilentlyContinue verhindert Fehlermeldungen, wenn der StorageAccount noch nicht existiert# $a = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName `#                        -Name "testorcgn04" `
#                        -ErrorAction SilentlyContinue

# Durchlaufen alle Storage Account
foreach ($store in $storages)
{
    #Pr�fen ob der Storage Account den Pr�fix beinhaltet
    if ($store.StorageAccountName -like "$($basename)*") 
    { 
        # Erstellen der URL zum Storage Account
        $blobUrl = "$($store.StorageAccountName).blob.core.windows.net"
        # DNS Lookup �ber die URL
        $dnslookup = [System.Net.Dns]::GetHostAddresses($blobUrl)
        # Auslesen der IP Adresse
        $stampIp = $dnslookup.IPAddressToString
        #Hinzuf�gen der IP Adressen in das Array
        $StampIpList[$store.StorageAccountName] += @($stampIp) #$blobUrl
    }
 }
 
$result = ($StampIpList.GetEnumerator() | Sort-Object Value)

#output
write-output $result

 
