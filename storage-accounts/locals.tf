locals {
  storage_acc_name = format(
    "%s%s",
    var.name_prefix,
    var.name_suffix
  )
}