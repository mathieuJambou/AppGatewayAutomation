Connect-AzAccount

# Get Azure Application Gateway
$appgw=Get-AzApplicationGateway -Name APPGatewayName -ResourceGroupName APPGatewayRG

# Stop the Azure Application Gateway
Stop-AzApplicationGateway -ApplicationGateway $appgw
 
# Start the Azure Application Gateway (optional)
#Start-AzApplicationGateway -ApplicationGateway $appgw