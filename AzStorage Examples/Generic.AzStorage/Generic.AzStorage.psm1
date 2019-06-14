Using module .\Generic.AzBlobStorage\Generic.AzBlobStorage.psm1


function Get-StorageAccount($ResourceGroupName,$StorageAccountName) {

    return [StorageAccount]::new($ResourceGroupName, $StorageAccountName)
} 

class StorageAccount{
    [Microsoft.Azure.Commands.Management.Storage.Models.PSStorageAccount]$Account

    #Blobs
    [UpdatesBlob]$UpdatesBlob

    StorageAccount([string]$resourceGroup, [string]$name){

        $this.Account = Get-AzStorageAccount -ResourceGroupName $resourceGroup -Name $name

        $this.UpdatesBlob = [UpdatesBlob]::new($this.Account.Context)
    }
}