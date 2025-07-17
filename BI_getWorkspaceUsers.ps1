 Import the Power BI Management module
Import-Module MicrosoftPowerBIMgmt

# Connect to the Power BI Service Account
#Connect-PowerBIServiceAccount

# Retrieve all workspaces
$workspaces = Get-PowerBIWorkspace -Scope Organization -All

# Initialize an array to hold the workspace and user information
$workspaceUsers = @()

# Loop through each workspace
foreach ($workspace in $workspaces) {
    # Retrieve all users for the current workspace
    $users = Get-PowerBIWorkspaceUser -Id $workspace.Id

    # Loop through each user and add their details to the array
    foreach ($user in $users) {
        $workspaceUsers += [PSCustomObject]@{
            WorkspaceId = $workspace.Id
            WorkspaceName = $workspace.Name
            UserName = $user.DisplayName
            UserEmail = $user.EmailAddress
            AccessRight = $user.AccessRight
        }
    }
}

# Export the array to a CSV file
$workspaceUsers | Export-Csv -Path "WorkspaceUsers.csv" -NoTypeInformation

# Disconnect from the Power BI Service Account
#Disconnect-PowerBIServiceAccount
