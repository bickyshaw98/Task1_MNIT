import re
storage_account_name = "st12mskuexszw4"
class StorageAccountNameValidator:
    def __init__(self, storage_account_name):
        self.storage_account_name = storage_account_name

    def validate_name(self):
        if not self.storage_account_name.startswith('sa-'):
            return False
        return True

def main():
    # Example Bicep resource configuration
    storage_account_name = 'sa-example'
    
    validator = StorageAccountNameValidator(storage_account_name)
    if validator.validate_name():
        print("Storage account name follows naming convention.")
    else:
        print("Storage account name does not follow naming convention.")

if __name__ == "__main__":
    main()
