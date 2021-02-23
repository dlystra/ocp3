# docker-storage

Role to provision docker-storage.

## Requirements

## Role Variables

| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `docker_lv_name` | "var_lib_docker"       | Logical volume name that will be mounted on docker_mount_point |
| `docker_mount_point` | "/var/lib/docker"       | Location to create and mount the logical volume named docker_lv_name |
| `docker_vg_name` | "docker_vg"       | Volume group to use for container runtime storage |