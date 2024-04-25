templateFile="./bicep/rg.bicep"
uuid="$(cat /proc/sys/kernel/random/uuid)"
location="centralus"

environment=$1
if [ "$environment" == "dev" ]; then
    parameterFile="./bicep/rg_parameters_dev.json"
elif [ "$environment" == "test" ]; then
    parameterFile="./bicep/rg_parameters_test.json"
else
    echo "Invalid environment specified"
    exit 1
fi


az deployment sub validate --name $uuid --location $location --template-file $templateFile \
    --parameters $parameterFile \
    --parameters agencyCode=e37

az deployment sub what-if --name $uuid --location $location --template-file $templateFile \
    --parameters $parameterFile \
    --parameters agencyCode=e37