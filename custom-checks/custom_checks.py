from checkov.common.models.enums import CheckResult, CheckCategories
from checkov.terraform.checks.resource.base_resource_value_check import BaseResourceValueCheck


class StorageAccountNameCheck(BaseResourceValueCheck):
    def __init__(self):
        name = "Ensure storage account name follows naming convention"
        id = "CUSTOM001"
        supported_resources = ['azurerm_storage_account']
        categories = [CheckCategories.CONVENTION]
        super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)

    def scan_resource_conf(self, conf):
        if 'name' in conf:
            storage_account_name = conf['name']
            if not storage_account_name.startswith('sa-'):
                return CheckResult.FAILED
        return CheckResult.PASSED


check = StorageAccountNameCheck()
