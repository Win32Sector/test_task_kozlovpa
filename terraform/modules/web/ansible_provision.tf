resource "null_resource" "playbook" {
  provisioner "local-exec" {
    command = "sleep 30; ansible-playbook ../../ansible/web/playbook.yml -i ../../ansible/web/inventory"
  }
  depends_on = ["google_compute_instance.web"]
}
