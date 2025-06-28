data "azurerm_mssql_server" "sqlserverblock" {
    name                = var.sqlservername
    resource_group_name = var.rgname
}

resource "azurerm_mssql_database" "sql_databaseBlock" {
    name                = var.database_name
    server_id           = data.azurerm_mssql_server.sqlserverblock.id
    sku_name            = var.sku_name  
}