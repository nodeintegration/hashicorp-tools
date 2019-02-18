# Just a handy docker image that contains the suite of hashicorp products
## Packer 1.3.4
## Vagrant 2.2.3
## Terraform 0.11.11
## Consul 1.4.2
## Vault 1.0.3
## Nomad 0.8.7


# Todo
* add a wrapper for putting each of these as a wrapper into your shell e.g.
```
function terraform () {
  docker run -it --rm -v $(pwd):/workspace/ nodeintegration/hashicorp-tools:latest terraform $@
}
```
