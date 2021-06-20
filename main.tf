data "azurerm_resource_group" "RG" {
  name = var.resource_group_name
}

resource "azurerm_app_service_plan" "Plan" {
  name                = var.name_Service_Plan
  location            = var.location
  resource_group_name = data.azurerm_resource_group.RG.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "webapp" {
  name                = var.name_web_app
  location            = var.location
  resource_group_name = data.azurerm_resource_group.RG.name
  app_service_plan_id = azurerm_app_service_plan.Plan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
    }
  }
