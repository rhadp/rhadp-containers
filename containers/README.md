## Containers

Container images with tools for RHAS developers.

Based on the official [Red Hat Universal Base Image 9](https://catalog.redhat.com/en/software/container-stacks/detail/609560d9e2b160d361d24f98).

## Images

Container images that build on each other:

```
base (ubi 9.7)
├── builder
│   └── codespaces
└── runtime
    └── pipeline
```

### base
Base image with Python 3.12, uv, OpenShift CLI, and essential tools.

### builder
Adds development tools: Podman, C/C++ toolchain (gcc, clang, llvm), and Rust.

### runtime
Adds virtualization packages (QEMU, KVM, libvirt) and Jumpstarter for hardware automation.

### codespaces
Development environment with Jumpstarter, Ansible, and cloud SDKs (AWS, Azure, GCP).

### pipeline
CI/CD image with Jumpstarter, cloud SDKs, and S3 upload utilities.
