templateFile="./bicep/rg.bicep"
uuid="$(cat /proc/sys/kernel/random/uuid)"
location="centralus"


parameterFile="./bicep/rg_parameters_dev.json"

rgName=$1

az deployment sub validate --name $uuid --location $location --template-file $templateFile \
    --parameters $parameterFile \
    --parameters $rgName

az deployment sub what-if --name $uuid --location $location --template-file $templateFile \
    --parameters $parameterFile \
    --parameters $rgName

echo "$rgName"


