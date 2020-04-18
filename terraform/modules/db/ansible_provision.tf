resource "null_resource" "playbook" {
  provisioner "local-exec" {
    command = "sleep 30; ansible-playbook ../../ansible/db/playbook.yml -i ../../ansible/db/inventory"
  }
  depends_on = ["google_compute_instance.db"]
}

resource "null_resource" "post_setup_tcg_playbook" {
  provisioner "local-exec" {
    command = "sleep 30; ansible-playbook ../../ansible/db/playbook_post_setup_tcg.yml -i ../../ansible/web/inventory"
  }
  depends_on = ["google_compute_instance.db", "null_resource.playbook"]
}
