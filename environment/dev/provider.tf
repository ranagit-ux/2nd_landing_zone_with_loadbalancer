terraform {
  required_providers {
    azurerm={
        source="hashicorp/azurerm"
        version="4.6.0"
    }
  }
}

provider "azurerm" {
    features{}
    subscription_id = "b7d2b67b-62bb-4340-a048-868c00c1a9be"
  
}
