#----------------------
#     TO BE DONE
#----------------------

$file='Hub-and-Spoke.bicep'

New-AzResourceGroupDeployment -DeploymentName ext1 -ResourceGroupName $rgName -TemplateFile $file `
    -TemplateParameterObject @{
        deployPeering=$true
        deployRouting=$true
        deployVm1=$true
        deployVm2=$false
        deployVm3=$false
        deployVm4=$false
        deployBastion=$true
        deployFirewall=$false
    }










Get-AzResourceGroupDeployment -ResourceGroupName $rgName | Select-Object DeploymentName,ProvisioningState,Timestamp | Sort-Object Timestamp -Descending | Select-Object -First 4





Get-AzResource -ResourceName $rgName | Sort-Object ResourceType | Format-Table Name,ResourceType,Location

New-AzResourceGroup -Name $rgName -Location $location
Get-AzResourceGroup | Format-Table ResourceGroupName,Location,ProvisioningState

$location='westeurope'
$rgName='Contoso-RG'