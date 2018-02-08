### Define variables
$location = 'Australia Southeast'
$resourceGroupName = 'pluralsight-arm-nested'
$resourceDeploymentSolutionName = 'pluralsight-arm-nested-deployment'
$templateBaseUri = 'https://raw.githubusercontent.com/sanathkumarshetty/Azure-ARM/master/'
$templateFile = 'azureDeploy.json'


$template = $templateBaseUri + '/' + $templateFile
$templateParametersFile = 'azureDeploy.parameters.json'
$templateParameters = $templateBaseUri + '/' + $templateParametersFile

$tenantID = "dfcdef42-195d-4e0d-9808-2d488688da0e"  #ashoktenantID
$SPNID = "275b388b-537d-4bfc-8859-f7b34444ca77" #ashokSPN
$SPNSecret ="PG4LuPgK1aNZpnErJq+fc7NmLOh2fzSNFaF9c9l8H9E=" #ashokSPNSecret 


$pass = ConvertTo-SecureString $SPNSecret -AsPlainText –Force
$cred = New-Object -TypeName pscredential –ArgumentList $SPNID, $pass
Logout-AzureRmAccount  -ErrorAction SilentlyContinue
Get-AzureRmContext 
Login-AzureRmAccount -Credential $cred -ServicePrincipal –TenantId $tenantID 

 

### Create Resource Group
New-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Location $Location `
    -Verbose -Force

### Deploy IaaS Solution
New-AzureRmResourceGroupDeployment `
    -Name $resourceDeploymentSolutionName `
    -ResourceGroupName $resourceGroupName `
    -TemplateUri $template `
    -TemplateParameterUri $templateParameters `
    -Debug
    