#### Manage identity required

it will delete the all resources in xxxxx

```powershell
$AzureContext = (Connect-AzAccount -Identity).context
Get-AzResource -ResourceGroupName xxxxx | Remove-AzResource -Force

```
