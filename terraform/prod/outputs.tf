output "web_external_ip" {
  value = "${module.web.web_external_ip}"
}

output "db_external_ip" {
  value = "${module.db.db_external_ip}"
}