# Deploy Bicep file to resource group
$file='Hub-and-Spoke.bicep'

az deployment group create --name ext1 --resource-group $rgName --template-file $file `
    --parameters `
        deployPeering=$true `
        deployRouting=$true `
        deployVm1=$true `
        deployVm2=$false `
        deployVm3=$false `
        deployVm4=$false `
        deployBastion=$true `
        deployFirewall=$false 

# List deployment history
az deployment group list --resource-group $rgName --query --% "reverse(sort_by([].{Name:name,provisioningState:properties.provisioningState,duration:properties.duration,timestamp:properties.timestamp}, &timestamp)) | [0:4]" --output table

# Delete all resources of resource group
$uri="https://raw.githubusercontent.com/www42/arm/master/templates/empty.json"
az deployment group create --name tabulaRasa06 --resource-group $rgName --mode Complete --template-uri $uri --no-wait

# List all resources of resource group
az resource list --resource-group $rgName --query --% "sort_by([].{name:name,Type:type,location:location},&Type)" --output table

# Create resource group
az group create --name $rgName --location $location
az group list --output table

$location='westeurope'
$rgName='Contoso-RG'


# Zip DSC configurations
Compress-Archive -Path DSC/*.ps1 -DestinationPath DSC/dscConfigs.zip -Force