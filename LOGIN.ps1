# Azure Pass        Paul@adatum6404.onmicrosoft.com
# Subscription ID:  bd91dc26-8119-4bbf-882f-84be1cf33026
# Tenant ID:        89ee3811-46d2-4152-af70-352fcce4d323

Logout-AzAccount
Login-AzAccount

Get-AzContext | fl
Get-AzSubscription | ft Name,Id,State

$subscriptionId = 'bd91dc26-8119-4bbf-882f-84be1cf33026'
Set-AzContext -Subscription $subscriptionId

Get-AzContext | fl Account,Subscription,Tenant

Get-AzResourceGroup | Sort-Object ResourceGroupName | ft ResourceGroupName,Location,ProvisioningState