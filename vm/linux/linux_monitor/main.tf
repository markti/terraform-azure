
module "vm_baseline" {
  
  source                = "../linux_baseline"
  resource_group_name   = var.resource_group_name
  location              = var.location
  app_name              = var.app_name
  env_name              = var.env_name
  name                  = var.name
  subnet_id             = var.subnet_id
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  diag_endpoint         = var.diag_endpoint

}


resource "azurerm_virtual_machine_extension" "vm_ext_linuxagent" {

  name                          = "DependencyAgentLinux"
  virtual_machine_id            = module.vm_baseline.id
  publisher                     = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                          = "DependencyAgentLinux"
  type_handler_version          = "9.10"
  auto_upgrade_minor_version    = true
  depends_on                    = [module.vm_baseline]

  settings = <<SETTINGS
    {
    }
SETTINGS

  tags = {
    app = var.app_name
    env = var.env_name
  }
}

resource "azurerm_virtual_machine_extension" "vm_ext_omsagent" {
  name                          = "OMSExtension"
  
  virtual_machine_id            = module.vm_baseline.id
  
  publisher                     = "Microsoft.EnterpriseCloud.Monitoring"
  type                          = "OmsAgentForLinux"
  type_handler_version          = "1.7"
  auto_upgrade_minor_version    = true

  depends_on                    = [module.vm_baseline]

  settings = <<SETTINGS
    {
      "workspaceId": "${var.log_analytics_workspace_id}",
      "azureResourceId": "${module.vm_baseline.id}",
      "stopOnMultipleConnections": "true"
    }
  SETTINGS

  protected_settings = <<SETTINGS
    {
      "workspaceKey": "${var.log_analytics_workspace_key}"
    }
  SETTINGS

  tags = {
    app = var.app_name
    env = var.env_name
  }
}


/*
resource "azurerm_virtual_machine_extension" "vm_ext_waad" {
  name                          = "${var.name}/LinuxDiagnostic"
  virtual_machine_id            = azurerm_virtual_machine.vm.id
  publisher                     = "Microsoft.Azure.Diagnostics"
  type                          = "LinuxDiagnostic"
  type_handler_version          = "3.0"
  auto_upgrade_minor_version    = true

  settings = <<SETTINGS
    {
      "StorageAccount": "${var.storage_name}",
      "ladCfg": {
          "diagnosticMonitorConfiguration": {
              "eventVolume": "Medium",
              "metrics": {
                  "metricAggregation": [
                      {
                          "scheduledTransferPeriod": "PT1M"
                      },
                      {
                          "scheduledTransferPeriod": "PT1H"
                      }
                  ],
                  "resourceId": "${azurerm_virtual_machine.vm.id}"
              },
              "syslogEvents": {
                  "syslogEventConfiguration": {
                      "LOG_AUTH": "LOG_DEBUG",
                      "LOG_AUTHPRIV": "LOG_DEBUG",
                      "LOG_CRON": "LOG_DEBUG",
                      "LOG_DAEMON": "LOG_DEBUG",
                      "LOG_FTP": "LOG_DEBUG",
                      "LOG_KERN": "LOG_DEBUG",
                      "LOG_LOCAL0": "LOG_DEBUG",
                      "LOG_LOCAL1": "LOG_DEBUG",
                      "LOG_LOCAL2": "LOG_DEBUG",
                      "LOG_LOCAL3": "LOG_DEBUG",
                      "LOG_LOCAL4": "LOG_DEBUG",
                      "LOG_LOCAL5": "LOG_DEBUG",
                      "LOG_LOCAL6": "LOG_DEBUG",
                      "LOG_LOCAL7": "LOG_DEBUG",
                      "LOG_LPR": "LOG_DEBUG",
                      "LOG_MAIL": "LOG_DEBUG",
                      "LOG_NEWS": "LOG_DEBUG",
                      "LOG_SYSLOG": "LOG_DEBUG",
                      "LOG_USER": "LOG_DEBUG",
                      "LOG_UUCP": "LOG_DEBUG"
                  }
              },
              "performanceCounters": {
                  "performanceCounterConfiguration": [
                      {
                          "annotation": [
                              {
                                  "displayName": "CPU IO wait time",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "processor",
                          "condition": "IsAggregate=TRUE",
                          "counter": "percentiowaittime",
                          "counterSpecifier": "/builtin/processor/percentiowaittime",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "CPU user time",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "processor",
                          "condition": "IsAggregate=TRUE",
                          "counter": "percentusertime",
                          "counterSpecifier": "/builtin/processor/percentusertime",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "CPU nice time",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "processor",
                          "condition": "IsAggregate=TRUE",
                          "counter": "percentnicetime",
                          "counterSpecifier": "/builtin/processor/percentnicetime",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "CPU percentage guest OS",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "processor",
                          "condition": "IsAggregate=TRUE",
                          "counter": "percentprocessortime",
                          "counterSpecifier": "/builtin/processor/percentprocessortime",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "CPU interrupt time",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "processor",
                          "condition": "IsAggregate=TRUE",
                          "counter": "percentinterrupttime",
                          "counterSpecifier": "/builtin/processor/percentinterrupttime",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "CPU idle time",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "processor",
                          "condition": "IsAggregate=TRUE",
                          "counter": "percentidletime",
                          "counterSpecifier": "/builtin/processor/percentidletime",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "CPU privileged time",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "processor",
                          "condition": "IsAggregate=TRUE",
                          "counter": "percentprivilegedtime",
                          "counterSpecifier": "/builtin/processor/percentprivilegedtime",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Memory available",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "memory",
                          "counter": "availablememory",
                          "counterSpecifier": "/builtin/memory/availablememory",
                          "type": "builtin",
                          "unit": "Bytes",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Swap percent used",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "memory",
                          "counter": "percentusedswap",
                          "counterSpecifier": "/builtin/memory/percentusedswap",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Memory used",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "memory",
                          "counter": "usedmemory",
                          "counterSpecifier": "/builtin/memory/usedmemory",
                          "type": "builtin",
                          "unit": "Bytes",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Page reads",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "memory",
                          "counter": "pagesreadpersec",
                          "counterSpecifier": "/builtin/memory/pagesreadpersec",
                          "type": "builtin",
                          "unit": "CountPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Swap available",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "memory",
                          "counter": "availableswap",
                          "counterSpecifier": "/builtin/memory/availableswap",
                          "type": "builtin",
                          "unit": "Bytes",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Swap percent available",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "memory",
                          "counter": "percentavailableswap",
                          "counterSpecifier": "/builtin/memory/percentavailableswap",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Mem. percent available",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "memory",
                          "counter": "percentavailablememory",
                          "counterSpecifier": "/builtin/memory/percentavailablememory",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Pages",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "memory",
                          "counter": "pagespersec",
                          "counterSpecifier": "/builtin/memory/pagespersec",
                          "type": "builtin",
                          "unit": "CountPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Swap used",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "memory",
                          "counter": "usedswap",
                          "counterSpecifier": "/builtin/memory/usedswap",
                          "type": "builtin",
                          "unit": "Bytes",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Memory percentage",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "memory",
                          "counter": "percentusedmemory",
                          "counterSpecifier": "/builtin/memory/percentusedmemory",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Page writes",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "memory",
                          "counter": "pageswrittenpersec",
                          "counterSpecifier": "/builtin/memory/pageswrittenpersec",
                          "type": "builtin",
                          "unit": "CountPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Network in guest OS",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "network",
                          "counter": "bytesreceived",
                          "counterSpecifier": "/builtin/network/bytesreceived",
                          "type": "builtin",
                          "unit": "Bytes",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Network total bytes",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "network",
                          "counter": "bytestotal",
                          "counterSpecifier": "/builtin/network/bytestotal",
                          "type": "builtin",
                          "unit": "Bytes",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Network out guest OS",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "network",
                          "counter": "bytestransmitted",
                          "counterSpecifier": "/builtin/network/bytestransmitted",
                          "type": "builtin",
                          "unit": "Bytes",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Network collisions",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "network",
                          "counter": "totalcollisions",
                          "counterSpecifier": "/builtin/network/totalcollisions",
                          "type": "builtin",
                          "unit": "Count",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Packets received errors",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "network",
                          "counter": "totalrxerrors",
                          "counterSpecifier": "/builtin/network/totalrxerrors",
                          "type": "builtin",
                          "unit": "Count",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Packets sent",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "network",
                          "counter": "packetstransmitted",
                          "counterSpecifier": "/builtin/network/packetstransmitted",
                          "type": "builtin",
                          "unit": "Count",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Packets received",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "network",
                          "counter": "packetsreceived",
                          "counterSpecifier": "/builtin/network/packetsreceived",
                          "type": "builtin",
                          "unit": "Count",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Packets sent errors",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "network",
                          "counter": "totaltxerrors",
                          "counterSpecifier": "/builtin/network/totaltxerrors",
                          "type": "builtin",
                          "unit": "Count",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Filesystem transfers/sec",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "filesystem",
                          "condition": "IsAggregate=TRUE",
                          "counter": "transferspersecond",
                          "counterSpecifier": "/builtin/filesystem/transferspersecond",
                          "type": "builtin",
                          "unit": "CountPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Filesystem % free space",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "filesystem",
                          "condition": "IsAggregate=TRUE",
                          "counter": "percentfreespace",
                          "counterSpecifier": "/builtin/filesystem/percentfreespace",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Filesystem % used space",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "filesystem",
                          "condition": "IsAggregate=TRUE",
                          "counter": "percentusedspace",
                          "counterSpecifier": "/builtin/filesystem/percentusedspace",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Filesystem used space",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "filesystem",
                          "condition": "IsAggregate=TRUE",
                          "counter": "usedspace",
                          "counterSpecifier": "/builtin/filesystem/usedspace",
                          "type": "builtin",
                          "unit": "Bytes",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Filesystem read bytes/sec",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "filesystem",
                          "condition": "IsAggregate=TRUE",
                          "counter": "bytesreadpersecond",
                          "counterSpecifier": "/builtin/filesystem/bytesreadpersecond",
                          "type": "builtin",
                          "unit": "CountPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Filesystem free space",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "filesystem",
                          "condition": "IsAggregate=TRUE",
                          "counter": "freespace",
                          "counterSpecifier": "/builtin/filesystem/freespace",
                          "type": "builtin",
                          "unit": "Bytes",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Filesystem % free inodes",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "filesystem",
                          "condition": "IsAggregate=TRUE",
                          "counter": "percentfreeinodes",
                          "counterSpecifier": "/builtin/filesystem/percentfreeinodes",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Filesystem bytes/sec",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "filesystem",
                          "condition": "IsAggregate=TRUE",
                          "counter": "bytespersecond",
                          "counterSpecifier": "/builtin/filesystem/bytespersecond",
                          "type": "builtin",
                          "unit": "BytesPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Filesystem reads/sec",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "filesystem",
                          "condition": "IsAggregate=TRUE",
                          "counter": "readspersecond",
                          "counterSpecifier": "/builtin/filesystem/readspersecond",
                          "type": "builtin",
                          "unit": "CountPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Filesystem write bytes/sec",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "filesystem",
                          "condition": "IsAggregate=TRUE",
                          "counter": "byteswrittenpersecond",
                          "counterSpecifier": "/builtin/filesystem/byteswrittenpersecond",
                          "type": "builtin",
                          "unit": "CountPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Filesystem writes/sec",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "filesystem",
                          "condition": "IsAggregate=TRUE",
                          "counter": "writespersecond",
                          "counterSpecifier": "/builtin/filesystem/writespersecond",
                          "type": "builtin",
                          "unit": "CountPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Filesystem % used inodes",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "filesystem",
                          "condition": "IsAggregate=TRUE",
                          "counter": "percentusedinodes",
                          "counterSpecifier": "/builtin/filesystem/percentusedinodes",
                          "type": "builtin",
                          "unit": "Percent",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Disk read guest OS",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "disk",
                          "condition": "IsAggregate=TRUE",
                          "counter": "readbytespersecond",
                          "counterSpecifier": "/builtin/disk/readbytespersecond",
                          "type": "builtin",
                          "unit": "BytesPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Disk writes",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "disk",
                          "condition": "IsAggregate=TRUE",
                          "counter": "writespersecond",
                          "counterSpecifier": "/builtin/disk/writespersecond",
                          "type": "builtin",
                          "unit": "CountPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Disk transfer time",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "disk",
                          "condition": "IsAggregate=TRUE",
                          "counter": "averagetransfertime",
                          "counterSpecifier": "/builtin/disk/averagetransfertime",
                          "type": "builtin",
                          "unit": "Seconds",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Disk transfers",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "disk",
                          "condition": "IsAggregate=TRUE",
                          "counter": "transferspersecond",
                          "counterSpecifier": "/builtin/disk/transferspersecond",
                          "type": "builtin",
                          "unit": "CountPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Disk write guest OS",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "disk",
                          "condition": "IsAggregate=TRUE",
                          "counter": "writebytespersecond",
                          "counterSpecifier": "/builtin/disk/writebytespersecond",
                          "type": "builtin",
                          "unit": "BytesPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Disk read time",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "disk",
                          "condition": "IsAggregate=TRUE",
                          "counter": "averagereadtime",
                          "counterSpecifier": "/builtin/disk/averagereadtime",
                          "type": "builtin",
                          "unit": "Seconds",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Disk write time",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "disk",
                          "condition": "IsAggregate=TRUE",
                          "counter": "averagewritetime",
                          "counterSpecifier": "/builtin/disk/averagewritetime",
                          "type": "builtin",
                          "unit": "Seconds",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Disk total bytes",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "disk",
                          "condition": "IsAggregate=TRUE",
                          "counter": "bytespersecond",
                          "counterSpecifier": "/builtin/disk/bytespersecond",
                          "type": "builtin",
                          "unit": "BytesPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Disk reads",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "disk",
                          "condition": "IsAggregate=TRUE",
                          "counter": "readspersecond",
                          "counterSpecifier": "/builtin/disk/readspersecond",
                          "type": "builtin",
                          "unit": "CountPerSecond",
                          "sampleRate": "PT15S"
                      },
                      {
                          "annotation": [
                              {
                                  "displayName": "Disk queue length",
                                  "locale": "en-us"
                              }
                          ],
                          "class": "disk",
                          "condition": "IsAggregate=TRUE",
                          "counter": "averagediskqueuelength",
                          "counterSpecifier": "/builtin/disk/averagediskqueuelength",
                          "type": "builtin",
                          "unit": "Count",
                          "sampleRate": "PT15S"
                      }
                  ]
              }
          },
          "sampleRateInSeconds": 15
      }
    }
  SETTINGS

  protected_settings = <<SETTINGS
    {
      "storageAccountName": "${var.storage_name}",
      "storageAccountSasToken": "sv=2019-02-02&ss=bt&srt=co&sp=acluw&se=9001-01-31T05:00:00Z&sig=SEcAY0iZIJfCjT9iagoEyDgjIUoE%2BYnKaeCX43%2FjKSE%3D",
      "storageAccountEndPoint": "https://core.windows.net/"
    }
  SETTINGS

  tags = {
    app = var.app_name
    env = var.env_name
  }
}
*/