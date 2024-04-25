templateFile="./bicep/rg.bicep"
uuid="$(cat /proc/sys/kernel/random/uuid)"
location="centralus"


parameterFile="./bicep/rg_parameters_dev.json"



az deployment sub validate --name $uuid --location $location --template-file $templateFile --parameters $parameterFile
az deployment sub what-if --name $uuid  --location $location --template-file $templateFile --parameters $parameterFile

