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
        Registry NoIEenhancedSecurity
        {
            Ensure = 'Present'
            Key = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
            ValueName = 'IsInstalled'
            ValueData = [int]0
        }
    }
}