#from checkov.common.models.enums import CheckCategories
#from checkov.common.models.consts import ANY_VALUE
#from checkov.terraform.checks.resource.base_resource_value_check import BaseResourceValueCheck
#
#class StorageAccountSKURule(BaseResourceValueCheck):
#    def __init__(self):
#        name = "Ensure storage account SKU is not Premium_LRS"
#        id = "CUSTOM_AZURE_STORAGE_ACCOUNT_SKU"
#        supported_resources = ["azurerm_storage_account"]
#        categories = [CheckCategories.CONVENTION]
#
#        super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)
#
#    def get_inspected_key(self):
#        return "sku"
#
#    def get_expected_values(self):
#        return ["Standard_LRS", "Standard_GRS", "Standard_RAGRS", "Standard_ZRS", "Premium_ZRS", "Standard_GZRS", "Standard_RAGZRS"]
#
#    def get_comparison_value(self):
#        return ANY_VALUE
#
#check = StorageAccountSKURule()
