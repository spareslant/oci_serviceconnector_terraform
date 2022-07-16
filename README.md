## Internet facing VM in OCI using terraform module
Three modules were created to do this
* `user_and_groups`
* `networking`
* `instance`

Information was passed from one module to another. It also generates a `vm_keys` dir with the private key for the VM instance.

* `user_and_groups` module creates a separate user (`tf-user`), group (`tf-group`) and compartment (`TFC`). This user has full admin rights in this compartment.
* `networking` and `instance` modules are called by `tf-user` NOT the tenancy user. Hence we are switching user when creating networking and instance in running terraform.
