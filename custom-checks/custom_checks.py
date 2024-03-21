from checkov.common.models.enums import CheckCategories
from checkov.terraform.checks.resource.base_resource_value_check import BaseResourceValueCheck
from checkov.common.models.consts import ANY_VALUE


class StorageAccountRecommendedSKU(BaseResourceValueCheck):
    def __init__(self):
        name = "Ensure storage account uses recommended SKU"
        id = "CUSTOM_STORAGE_ACCOUNT_SKU"
        supported_resources = ["azurerm_storage_account"]
        categories = [CheckCategories.BEST_PRACTICES]
        super().__init__(name=name, id=id, supported_resources=supported_resources, categories=categories)

    def get_expected_values(self):
        return ["Standard_LRS", "Standard_GRS", "Standard_RAGRS"]

    def get_inspected_key(self):
        return "sku_name"


check = StorageAccountRecommendedSKU()
