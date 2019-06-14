Using module .\Modules\Generic.AzStorage\Generic.AzStorage.psm1

function  Invoke-DeployPackages {
    [CmdletBinding()]
        param(
            [Parameter(Position=0,mandatory=$true,HelpMessage="Please provide the path to the folder containing the msi files")]
            [string] $folderpath,        
            [Parameter(Position=1,mandatory=$true,HelpMessage="Please provide the target resource group")]
            [string] $resourceGroup,
            [Parameter(Position=2,mandatory=$true,HelpMessage="Please provide the target resource group")]
            [string] $storageName)
    
        process{
            $ErrorActionPreference = "Stop"

            $storage = [StorageAccount]::new($resourceGroup, $storageName)
            #$storage = Get-StorageAccount $resourceGroup, $storageName

            $filesToUpload = Get-ChildItem $folderPath

            foreach($file in  $filesToUpload ){
                
                Write-Host $installer.FullName
                $storage.UpdatesBlob.UploadBlob($file.FullName)               
            }
        }
}

