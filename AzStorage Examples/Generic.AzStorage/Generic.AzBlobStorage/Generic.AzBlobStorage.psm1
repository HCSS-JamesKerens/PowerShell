using namespace System.IO

class GenericBlob
{
    [string]$Container
    [Microsoft.WindowsAzure.Commands.Common.Storage.LazyAzureStorageContext]$Context
    
    GenericBlob(
        [string]$container, 
        [Microsoft.WindowsAzure.Commands.Common.Storage.LazyAzureStorageContext]$ctx)
        {
            $this.Container = $container
            $this.Context = $ctx
        }

        [void]UploadBlob([string]$fileToUpload){

            $fileInfo = Get-ChildItem $fileToUpload

            Set-Location $fileInfo.Directory.FullName

            Set-AzStorageBlobContent -Container $this.Container `
                -File $fileInfo.Name `
                -Blob "$($fileInfo.Name)" `
                -Context $this.Context `
                -Force
        }       
}

#If you had a blob container named "updates and you wanted to pull in all of the generic commands"
class UpdatesBlob : GenericBlob {
    UpdatesBlob(
        [Microsoft.WindowsAzure.Commands.Common.Storage.LazyAzureStorageContext]$ctx) : base('updates', $ctx)
    {
        
    } 
}