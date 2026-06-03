resource "azurerm_application_insights_workbook" "platform" {
  name                = "platform-ops-dashboard"
  resource_group_name = data.terraform_remote_state.platform.outputs.spoke_rg_name
  location            = data.terraform_remote_state.platform.outputs.spoke_rg_location
  display_name        = "Platform Operations Dashboard"

  data_json = jsonencode({
    version = "Notebook/1.0"
    items = [
      {
        type = 1
        content = {
          json = "## Platform Operations — ${var.environment}"
        }
      },
      {
        type = 10
        content = {
          chartId     = "AKS CPU Usage"
          version     = "KqlItem/1.0"
          query       = "KubeNodeInventory | summarize avg(todouble(UsageNanoCores)) / 1000000 by bin(TimeGenerated, 5m) | render timechart"
          queryType   = 0
          resourceType = "microsoft.operationalinsights/workspaces"
        }
      },
      {
        type = 10
        content = {
          chartId     = "Pod Restarts"
          version     = "KqlItem/1.0"
          query       = "KubePodInventory | summarize max(ContainerRestartCount) by Name, bin(TimeGenerated, 5m) | render timechart"
          queryType   = 0
          resourceType = "microsoft.operationalinsights/workspaces"
        }
      },
      {
        type = 10
        content = {
          chartId     = "HTTP Error Rate"
          version     = "KqlItem/1.0"
          query       = "AppRequests | summarize Errors = countif(ResultCode >= 500), Total = count() by bin(TimeGenerated, 5m) | extend ErrorRate = round(100.0 * Errors / Total, 2) | render timechart"
          queryType   = 0
          resourceType = "microsoft.operationalinsights/workspaces"
        }
      }
    ]
  })

  tags = local.tags
}
