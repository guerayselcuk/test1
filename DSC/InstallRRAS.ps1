configuration InstallRRAS
{
    node ("localhost")
    {
        WindowsFeature RemoteAccess
        {
           Ensure = "Present"
           Name   = "RemoteAccess"
        }
        WindowsFeature RSAT-RemoteAccess
        {
           Ensure = "Present"
           Name   = "RSAT-RemoteAccess"
        }
        WindowsFeature Routing
        {
           Ensure = "Present"
           Name   = "Routing"
        }
    }
}