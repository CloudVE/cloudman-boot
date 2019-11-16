Role Name
=========
cloudman-boot

Description
-----------
The role is used to setup cloudman on a selected k8s cluster.
Currently, only Rancher is supported.

Role Variables
--------------
cm_cluster_type: KUBE_RANCHER (only supported value at present)
rancher_name: Which will be used as a name for the Docker image.
rancher_port: The port on which the Rancher management server will be mapped on the host.
