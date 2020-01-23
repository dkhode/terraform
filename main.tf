variable "apps" {
  type = "list"
  default = [
    {
      name = "app1",
      type = "java",
    },
    {
      name = "app2",
      type = "nodejs",
    },
    {
      name = "microservice1",
      type = "java",
    },
    {
      name = "microservice2",
      type = "net",
    },
  ]
}

data "null_data_source" "apps" {
  count    = "${length(var.apps)}"
  inputs = {
    name = "${ lookup(var.apps[count.index], "name", "") }"
    type = "${ lookup(var.services[count.index], "type", "") }"
  }
}

locals {
  app_type = "${matchkeys(data.null_data_source.apps.*.outputs.name, data.null_data_source.apps.*.outputs.type, list("java"))}"
}


output "matched_app" {
  value = "${local.app_type}"
}
