# cloudman-boot

This docker container will boot up a cloudman cluster. To use:

```
docker build . -t cloudve/cloudman-boot:latest
docker run cloudve/cloudman-boot:latest
```

It can be additionally contextualized with the following environment
parameters:

---------------------------------------------------------------------------------------
| Parameter               | Description                                | Default      |
|-------------------------|--------------------------------------------|--------------|
| CM_CLUSTER_TYPE         | Type of cluster                            | KUBE_RANCHER |
| CM_INITIAL_STORAGE_SIZE | Initial cluster storage                    | 100Gi        |
| CM_SKIP_CLOUDMAN        | Boot cluster only. Don't install cloudman. | False        |
| KUBE_CLOUD_PROVIDER     | K8S cloud provider                         |              |
| KUBE_CLOUD_CONF         | Cloudlaunch cloud config details           |              |
| RANCHER_SERVER          | Hostname for the server                    |              |
| RANCHER_PWD             | Login password for rancher                 | Random       |
---------------------------------------------------------------------------------------
