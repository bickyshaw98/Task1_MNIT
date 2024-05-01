templateFile="./bicep/rg.bicep"
uuid="$(cat /proc/sys/kernel/random/uuid)"
location="centralus"
resource_group="e37d-sharedservice-rg-001"

parameterFile="./bicep/rg_parameters_dev.json"

az deployment group validate --name $uuid --resource-group $resource_group --template-file $template_file --parameters $parameter_file
    
az deployment group what-if --name $uuid --resource-group $resource_group --template-file $template_file --parameters $parameter_file \
    
