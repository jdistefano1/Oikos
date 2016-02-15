$programFiles = [environment]::getfolderpath("programfiles")
add-type -Path $programFiles'\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll'
Write-Host 'Insert information for Site'
$siteurl = Read-Host "Site Url"
$username = Read-Host "User Name"
$password = Read-Host -AsSecureString "Password"
  
try
{
    [Microsoft.SharePoint.Client.ClientContext]$ClientContext = New-Object Microsoft.SharePoint.Client.ClientContext($siteurl)
    $ClientContext.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $password)
    $site = $ClientContext.Site;
 
    $sideLoadingGuid = new-object System.Guid "AE3A1339-61F5-4f8f-81A7-ABD2DA956A7D"
    $site.Features.Add($sideLoadingGuid, $true, [Microsoft.SharePoint.Client.FeatureDefinitionScope]::None);
      
    $ClientContext.ExecuteQuery();
      
    Write-Host -ForegroundColor Green 'SideLoading feature enabled :)'
}
catch
{
    Write-Host -ForegroundColor Red 'Error ' $siteurl, ':' $Error[0].ToString();
}