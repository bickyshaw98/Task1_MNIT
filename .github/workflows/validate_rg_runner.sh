templateFile="./EDIAM/bicep/rg.bicep"
uuid="$(cat /proc/sys/kernel/random/uuid)"
location="centralus"
parameterFile="./EDIAM/bicep/rg_parameters.json"
subscription_id=112b128e-2295-43f5-aebe-b882b8d039d3

az deployment sub validate --name $uuid --location $location --template-file $templateFile --parameters $parameterFile --subscription $subscription_id
az deployment sub what-if --name $uuid --location $location --template-file $templateFile --parameters $parameterFile --subscription $subscription_id
az deployment sub create --name $uuid --location $location --template-file $templateFile --parameters $parameterFile --subscription $subscription_id