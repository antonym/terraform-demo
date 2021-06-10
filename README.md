# terraform-demo

This repo is for demonstrating usage of Terraform across multiple providers.

This is experimental and a continual work in progress.  This is by no means production code and
is mainly here for examples and demonstration.

It currently contains demonstration code for:

* Launching instances into AWS EC2
* Launching instances into Google Compute Engine
* Launching instances into VMware Cloud Director

It also contains Ansible playbooks that will apply onto the spawned instances on first boot to provide a
consistent deployment experience across providers and the initial skeleton of a sample web app.
