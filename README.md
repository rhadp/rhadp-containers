# Red Hat Automotive Development Platform - Containers

Containers images with tools for developers 👨‍💻👩‍💻 and to run workloads on the Red Hat Automotive Development Platform (RHADP). 

## Container Images

### Runtime
A runtime environment with Python, oc, kubectl, and jumpstarter, based on Fedora 42.

### Builder
A build environment to support application development in CI/CD tools and cloud-based IDEs. 
Based on the Red Hat Universal Base Image 9 (UBI9) container image.

### Codespaces
Based on the `Builder` image with additional Red Hat Dev Spaces and GitHub CodeSpaces configuration.

## Building the container images

Run the following command to build the images locally:

```shell
make build-all
```

Build on GitHub:

This repo contains [actions](https://github.com/rhadp/rhadp-containers/actions), including:
* [![release latest container images](https://github.com/rhadp/rhadp-containers/actions/workflows/build-all.yaml/badge.svg)](https://github.com/rhadp/rhadp-containers/actions/workflows/build-all.yaml)

The workflow creates both the X86 and ARM64 versions of each container.

## Contributing

Fork the repository and submit a pull request.

## Development

A list of ideas, open issues etc related to the Red Hat Automotive Development Platform (RHADP) is [here](https://github.com/orgs/rhadp/projects/1).  

Also check the [Issues](https://github.com/rhadp/rhadp-containers/issues) section of the this repository.

## Disclaimer

This is not an officially supported Red Hat product.