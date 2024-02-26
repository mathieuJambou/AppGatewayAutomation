$connectionName = "AzureRunAsConnection"
try
{
    # Get the connection "AzureRunAsConnection "

    $servicePrincipalConnection = Get-AutomationConnection -Name $connectionName

    "Logging in to Azure..."
    $connectionResult =  Connect-AzAccount -Tenant $servicePrincipalConnection.TenantID `
                             -ApplicationId $servicePrincipalConnection.ApplicationID   `
                             -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint `
                             -ServicePrincipal
    "Logged in."

}
catch {
    if (!$servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found."
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}

if($appgw.OperationalState -eq "Stopped")
{
	"Application Gateway stopped with VM Running. Starting it..."
	Start-AzApplicationGateway -ApplicationGateway $appgw
	"Started"
}  

if($appgw.OperationalState -ne "Stopped")
{
	"Application Gateway started with VM deallocated. Stopping it..."
	Stop-AzApplicationGateway -ApplicationGateway $appgw
	"Stopped"
}  
