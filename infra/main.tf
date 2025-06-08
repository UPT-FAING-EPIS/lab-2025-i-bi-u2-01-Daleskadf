terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # Permite versiones 3.x.y
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

provider "azurerm" {
  features {}
}

# --- Variables ---
variable "resource_group_name" {
  type        = string
  description = "Nombre del Grupo de Recursos para el laboratorio."
  default     = "rg-lab01-negocios-db-terraform"
}

variable "location" {
  type        = string
  description = "Ubicación de Azure para los recursos."
  default     = "East US 2" # Cambia a tu región preferida
}

variable "sql_server_name_prefix" {
  type        = string
  description = "Prefijo para el nombre del Azure SQL Server."
  default     = "sqlsrvlab01tf" # Debe ser globalmente único
}

variable "sql_admin_login" {
  type        = string
  description = "Nombre de usuario para el administrador del SQL Server."
  default     = "sqladminuser"
}

# --- Recursos Aleatorios ---
resource "random_string" "unique_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  override_special = "!#%&_-" # Caracteres especiales permitidos por Azure SQL
}

# --- Grupo de Recursos ---
resource "azurerm_resource_group" "lab_rg" {
  name     = var.resource_group_name
  location = var.location
}

# --- Azure SQL Server ---
resource "azurerm_mssql_server" "lab_sql_server" {
  name                         = "${var.sql_server_name_prefix}-${random_string.unique_suffix.result}"
  resource_group_name          = azurerm_resource_group.lab_rg.name
  location                     = azurerm_resource_group.lab_rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = random_password.sql_admin_password.result
  minimum_tls_version          = "1.2" # Buena práctica



  tags = {
    environment = "lab"
    project     = "lab01-dimensional-design"
  }
}

# --- Reglas de Firewall ---
resource "azurerm_sql_firewall_rule" "allow_azure_services" {
  name                = "AllowAllWindowsAzureIps"
  resource_group_name = azurerm_resource_group.lab_rg.name    # Requerido
  server_name         = azurerm_mssql_server.lab_sql_server.name # Requerido, usa el nombre del servidor
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

# (Opcional) Regla para tu IP.
# resource "azurerm_sql_firewall_rule" "allow_my_ip" {
#   name                = "AllowMyDevIP"
#   resource_group_name = azurerm_resource_group.lab_rg.name
#   server_name         = azurerm_mssql_server.lab_sql_server.name # Usa el nombre del servidor
#   start_ip_address    = "YOUR_PUBLIC_IP_ADDRESS"
#   end_ip_address      = "YOUR_PUBLIC_IP_ADDRESS"
# }

# --- Bases de Datos ---
# Ejercicio 01: Envíos
resource "azurerm_mssql_database" "db_envios_erd" {
  name      = "db_envios_erd"
  server_id = azurerm_mssql_server.lab_sql_server.id # Asocia con el servidor
  sku_name  = "Basic"                               # Define el nivel de servicio
  collation = "SQL_Latin1_General_CP1_CI_AS"        # Buena práctica
}

resource "azurerm_mssql_database" "db_envios_dim" {
  name      = "db_envios_dim"
  server_id = azurerm_mssql_server.lab_sql_server.id
  sku_name  = "Basic"
  collation = "SQL_Latin1_General_CP1_CI_AS"
}

# Ejercicio 02: Reservas
resource "azurerm_mssql_database" "db_reservas_erd" {
  name      = "db_reservas_erd"
  server_id = azurerm_mssql_server.lab_sql_server.id
  sku_name  = "Basic"
  collation = "SQL_Latin1_General_CP1_CI_AS"
}

resource "azurerm_mssql_database" "db_reservas_dim" {
  name      = "db_reservas_dim"
  server_id = azurerm_mssql_server.lab_sql_server.id
  sku_name  = "Basic"
  collation = "SQL_Latin1_General_CP1_CI_AS"
}

# Ejercicio 03: Proyectos
resource "azurerm_mssql_database" "db_proyectos_erd" {
  name      = "db_proyectos_erd"
  server_id = azurerm_mssql_server.lab_sql_server.id
  sku_name  = "Basic"
  collation = "SQL_Latin1_General_CP1_CI_AS"
}

resource "azurerm_mssql_database" "db_proyectos_dim" {
  name      = "db_proyectos_dim"
  server_id = azurerm_mssql_server.lab_sql_server.id
  sku_name  = "Basic"
  collation = "SQL_Latin1_General_CP1_CI_AS"
}

# --- Outputs ---
output "sql_server_fqdn" {
  description = "El FQDN del Azure SQL Server creado."
  value       = azurerm_mssql_server.lab_sql_server.fully_qualified_domain_name
}

output "sql_admin_login_output" {
  description = "El login del administrador del SQL Server."
  value       = azurerm_mssql_server.lab_sql_server.administrator_login
}

output "sql_admin_password_output" {
  description = "La contraseña generada para el administrador del SQL Server (sensible)."
  value       = random_password.sql_admin_password.result
  sensitive   = true
}

output "resource_group_created_name" {
  description = "Nombre del grupo de recursos creado."
  value       = azurerm_resource_group.lab_rg.name
}

output "database_names" {
  description = "Nombres de las bases de datos creadas."
  value = {
    envios_erd    = azurerm_mssql_database.db_envios_erd.name
    envios_dim    = azurerm_mssql_database.db_envios_dim.name
    reservas_erd  = azurerm_mssql_database.db_reservas_erd.name
    reservas_dim  = azurerm_mssql_database.db_reservas_dim.name
    proyectos_erd = azurerm_mssql_database.db_proyectos_erd.name
    proyectos_dim = azurerm_mssql_database.db_proyectos_dim.name
  }
}