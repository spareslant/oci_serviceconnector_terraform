# Ship Logs from Monitoring/logging to a Bucket via Service connector hub

Following will be done.


* Internet facing VM in OCI using terraform module. We will be collecting `/var/log/messages` logs from this host.
* A logger from logging service which will be attached to above host
* A bucket creation
* A service connector hub which collects logs from host and metrics from monitoring and send to above bucket.

Three modules were created to do this
* `user_and_groups`
* `networking`
* `instance`
* `data_bucket`
* `connector_hub`
* `logging`

Information was passed from one module to another. It also generates a `vm_keys` dir with the private key for the VM instance.

* `user_and_groups` module creates a separate user (`tf-user`), group (`tf-group`) and compartment (`TFC`). This user has full admin rights in this compartment.
