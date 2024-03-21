from checkov.common.models.enums import CheckCategories, CheckResult
from checkov.common.util.type_forcers import force_int, force_list
from checkov.common.multi_signature import MultiSignature
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck
from checkov.common.models.consts import ANY_VALUE

class StorageAccountRule(BaseResourceCheck):
    def __init__(self):
        name = "Ensure storage account has encryption enabled"
        id = "CUSTOM_AZURE_STORAGE_ACCOUNT_ENCRYPTION_ENABLED"
        supported_resources = ["azurerm_virtual_machine"]
        categories = [CheckCategories.SECURITY]

        super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)

        self.multi_signature = MultiSignature(
            attribute_name="encryption",
            attribute_type=dict
        )

    def scan_resource_conf(self, conf):
        encryption_settings = conf.get("encryption", None)

        if not encryption_settings:
            return CheckResult.FAILED
        
        if not encryption_settings.get("services"):
            return CheckResult.FAILED

        if "blob" not in force_list(encryption_settings["services"]):
            return CheckResult.FAILED

        return CheckResult.PASSED

check = StorageAccountRule()
