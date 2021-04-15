param vmName string = 'VM1'
param location string = resourceGroup().location

resource vm 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS2_v2'
    }
    storageProfile: {
      imageReference:{
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: '${vmName}-Disk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: '${vmName}'
      adminUsername: 'Student'
      adminPassword: 'Pa55w.rd1234'
    }
    networkProfile:{
      networkInterfaces: [
        {
          id: vmNic.id
        }
      ]
    }
  }
}
resource vmDsc 'Microsoft.Compute/virtualMachines/extensions@2020-12-01' = {
  parent: vm
  name: 'CreateRRAS'
  location: location
  properties: {
    publisher: 'Microsoft.Powershell'
    type: 'DSC'
    typeHandlerVersion: '2.19'
    autoUpgradeMinorVersion: true
    settings: {
      configuration: {
        url: 'https://raw.githubusercontent.com/www42/test1/dsc/DSC/dscConfigs.zip'
        script: 'InstallRRAS.ps1'
        function: 'InstallRRAS'
      }
    }
  }
}
resource vmNic 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: '${vmName}-Nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          subnet: {
            id: virtualNetwork.properties.subnets[0].id
          }
        }
      }
    ]
  }
}
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'Vnet1'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '172.16.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet0'
        properties: {
          addressPrefix: '172.16.0.0/24'
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '172.16.255.0/24'
        }
      }
    ]
  }
}
resource bastion 'Microsoft.Network/bastionHosts@2020-08-01' = {
  name: 'BastionHost'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          publicIPAddress: {
            id: bastionPip.id
          }
          subnet: {
            id: virtualNetwork.properties.subnets[1].id
          }
        }
      }
    ]
  }
}
resource bastionPip 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'BastionHost-Pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}
