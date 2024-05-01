templateFile="./bicep/main.bicep"
uuid="$(cat /proc/sys/kernel/random/uuid)"
location="centralus"
resource_group="e37d-sharedservice-rg-001"

parameterFile="./bicep/main_parameters.json"

az deployment group create --name $uuid --resource-group $resource_group --template-file $template_file --parameters $parameter_file