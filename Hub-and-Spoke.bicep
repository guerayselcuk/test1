// Parameters to customize deployment
param deployPeering  bool = true
param deployGateway  bool = true
param deployRouting  bool = true
param deployVm1      bool = true
param deployVm2      bool = true
param deployVm3      bool = true
param deployVm4      bool = true
param deployBastion  bool = true
param deployFirewall bool = true

// Location
param location string = resourceGroup().location

// Hub
param hubName                    string = 'VNET1'
/* does not work !
param hubAddressSpace            array  = [
                                          '192.168.0.0/16'
                                          '10.0.0.4/16'
                                          ]
*/                                          
param hubAddressSpace            string = '192.168.0.0/16'
param hubSubnet1Name             string = 'VNET1-Subnet1'
param hubSubnet1AddressPrefix    string = '192.168.0.0/24'
param hubSubnet2Name             string = 'VNET1-Subnet2'
// param hubSubnet2AddressPrefix    string = '10.0.0.0/24'
param hubSubnet2AddressPrefix    string = '192.168.1.0/24'
param hubSubnet3Name             string = 'GatewaySubnet'       // Do not change!
param hubSubnet3AddressPrefix    string = '192.168.255.0/27'
param hubSubnet4Name             string = 'AzureBastionSubnet'  // Do not change!
param hubSubnet4AddressPrefix    string = '192.168.255.32/27'
param hubSubnet5Name             string = 'AzureFirewallSubnet' // Do not change!
param hubSubnet5AddressPrefix    string = '192.168.255.64/26'
// Spoke 1
param spoke1Name                 string = 'VNET2'
param spoke1AddressSpace         string = '172.16.0.0/16'
param spoke1Subnet1Name          string = 'VNET2-Subnet1'
param Spoke1Subnet1AddressPrefix string = '172.16.0.0/24'
// Spoke 2
param spoke2Name                 string = 'VNET3'
param spoke2AddressSpace         string = '10.20.0.0/16'
param spoke2Subnet1Name          string = 'VNET3-Subnet1'
param Spoke2Subnet1AddressPrefix string = '10.20.0.0/24'

param gatewayName                string = 'Gateway1'
param routeTableName             string = 'Table1'
param bastionName                string = 'Bastion1'
param firewallName               string = 'Firewall1'
param vm1Name                    string = 'VM1'
param vm2Name                    string = 'VM2'
param vm3Name                    string = 'VM3'
param vm4Name                    string = 'VM4'

// Virtual Networks
resource hub 'Microsoft.Network/virtualNetworks@2020-08-01' = {
  name: hubName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        hubAddressSpace
      ]
    }
    subnets: [
      {
        name: hubSubnet1Name
        properties: {
          addressPrefix: hubSubnet1AddressPrefix
        }
      }
      {
        name: hubSubnet2Name
        properties: {
          addressPrefix: hubSubnet2AddressPrefix
        }
      }
      {
        name: hubSubnet3Name
        properties: {
          addressPrefix: hubSubnet3AddressPrefix
        }
      }
      {
        name: hubSubnet4Name
        properties: {
          addressPrefix: hubSubnet4AddressPrefix
        }
      }
      {
        name: hubSubnet5Name
        properties: {
          addressPrefix: hubSubnet5AddressPrefix
        }
      }
    ]
  }
}
resource spoke1 'Microsoft.Network/virtualNetworks@2020-08-01' = {
  name: spoke1Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        spoke1AddressSpace
      ]
    }
    subnets: [
      {
        name: spoke1Subnet1Name
        properties: {
          addressPrefix: Spoke1Subnet1AddressPrefix
        }
      }
    ]
  }
}
resource spoke2 'Microsoft.Network/virtualNetworks@2020-08-01' = {
  name: spoke2Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        spoke2AddressSpace
      ]
    }
    subnets: [
      {
        name: spoke2Subnet1Name
        properties: {
          addressPrefix: Spoke2Subnet1AddressPrefix
        }
      }
    ]
  }
}

/*
// Virtual Network Peerings
resource hubSpoke1Peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-08-01' = if (deployPeering) {
  name: '${hubName}/${hubName}-to-${spoke1Name}-Peering'
}
resource spoke1HubPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-08-01' = if (deployPeering) {
  name: '${spoke1Name}/${spoke1Name}-to-${hubName}-Peering'
}
resource hubSpoke2Peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-08-01' = if (deployPeering) {
  name: '${hubName}/${hubName}-to-${spoke2Name}-Peering'
}
resource spoke2HubPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-08-01' = if (deployPeering) {
  name: '${spoke2Name}/${spoke2Name}-to-${hubName}-Peering'
}

// Virtual Gateway
resource gateway 'Microsoft.Network/virtualNetworkGateways@2020-08-01' = if (deployGateway) {
  name: gatewayName
  location: location
  properties: {
    
  }
}
// Routing
resource routeTable 'Microsoft.Network/routeTables@2020-08-01' = if (deployRouting) {
  name: routeTableName
  location: location
}

// Virtual Machines
resource vm1 'Microsoft.Compute/virtualMachines@2020-12-01' = if (deployVm1) {
  name: vm1Name
  location: location  
}
resource vm2 'Microsoft.Compute/virtualMachines@2020-12-01' = if (deployVm2) {
  name: vm2Name
  location: location  
}
resource vm3 'Microsoft.Compute/virtualMachines@2020-12-01' = if (deployVm3) {
  name: vm3Name
  location: location  
}
resource vm4 'Microsoft.Compute/virtualMachines@2020-12-01' = if (deployVm4) {
  name: vm4Name
  location: location  
}

// Bastion Host
resource bastion 'Microsoft.Network/bastionHosts@2020-08-01' = if (deployBastion) {
  name: bastionName
  location: location
}

// Azure Firewall
resource firewall 'Microsoft.Network/azureFirewalls@2020-08-01' = if (deployFirewall) {
  name: firewallName
  location: location
}

*/
