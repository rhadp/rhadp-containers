# RHADP Container Images Makefile
# Build container images locally using Podman

# Default registry and namespace
REGISTRY ?= localhost
NAMESPACE ?= rhadp

# Image names and tags
BUILDER_IMAGE = $(REGISTRY)/$(NAMESPACE)/builder
RUNTIME_IMAGE = $(REGISTRY)/$(NAMESPACE)/runtime
CODESPACES_IMAGE = $(REGISTRY)/$(NAMESPACE)/codespaces
TAG ?= latest

# Build tool
CONTAINER_TOOL ?= podman

# Build arguments
BUILD_ARGS ?= --build-arg TARGETARCH=$(shell uname -m | sed 's/x86_64/amd64/')

.PHONY: help all build-all builder runtime codespaces clean clean-all push-all

# Build all images
build-all: builder runtime codespaces
	@echo "✅ All images built successfully!"

# Build the builder image
builder:
	@echo "🔨 Building builder image..."
	$(CONTAINER_TOOL) build $(BUILD_ARGS) \
		-f containers/builder/Containerfile \
		-t $(BUILDER_IMAGE):$(TAG) \
		containers/builder/
	@echo "✅ Builder image built: $(BUILDER_IMAGE):$(TAG)"

# Build the runtime image
runtime:
	@echo "🔨 Building runtime image..."
	$(CONTAINER_TOOL) build $(BUILD_ARGS) \
		-f containers/runtime/Containerfile \
		-t $(RUNTIME_IMAGE):$(TAG) \
		containers/runtime/
	@echo "✅ Runtime image built: $(RUNTIME_IMAGE):$(TAG)"

# Build the codespaces image (depends on builder)
codespaces: builder
	@echo "🔨 Building codespaces image..."
	$(CONTAINER_TOOL) build $(BUILD_ARGS) \
		-f containers/codespaces/Containerfile \
		-t $(CODESPACES_IMAGE):$(TAG) \
		containers/codespaces/
	@echo "✅ Codespaces image built: $(CODESPACES_IMAGE):$(TAG)"

# Clean up locally built images
clean:
	@echo "🧹 Cleaning up locally built images..."
	-$(CONTAINER_TOOL) rmi $(BUILDER_IMAGE):$(TAG) 2>/dev/null || true
	-$(CONTAINER_TOOL) rmi $(RUNTIME_IMAGE):$(TAG) 2>/dev/null || true
	-$(CONTAINER_TOOL) rmi $(CODESPACES_IMAGE):$(TAG) 2>/dev/null || true
	@echo "✅ Local images cleaned"

# Clean up all related images including base images
clean-all: clean
	@echo "🧹 Cleaning up all related images..."
	-$(CONTAINER_TOOL) rmi quay.io/devfile/base-developer-image:ubi9-latest 2>/dev/null || true
	-$(CONTAINER_TOOL) rmi fedora:42 2>/dev/null || true
	-$(CONTAINER_TOOL) rmi ghcr.io/astral-sh/uv:latest 2>/dev/null || true
	-$(CONTAINER_TOOL) system prune -f 2>/dev/null || true
	@echo "✅ All images cleaned"

# Push all images to registry
push-all: build-all
	@echo "📤 Pushing all images to $(REGISTRY)..."
	$(CONTAINER_TOOL) push $(BUILDER_IMAGE):$(TAG)
	$(CONTAINER_TOOL) push $(RUNTIME_IMAGE):$(TAG)
	$(CONTAINER_TOOL) push $(CODESPACES_IMAGE):$(TAG)
	@echo "✅ All images pushed successfully!"

# Individual push targets
push-builder: builder
	$(CONTAINER_TOOL) push $(BUILDER_IMAGE):$(TAG)

push-runtime: runtime
	$(CONTAINER_TOOL) push $(RUNTIME_IMAGE):$(TAG)

push-codespaces: codespaces
	$(CONTAINER_TOOL) push $(CODESPACES_IMAGE):$(TAG)

# Show image info
info:
	@echo "📊 Image Information:"
	@echo "Builder:    $(BUILDER_IMAGE):$(TAG)"
	@echo "Runtime:    $(RUNTIME_IMAGE):$(TAG)"
	@echo "Codespaces: $(CODESPACES_IMAGE):$(TAG)"
	@echo ""
	@echo "Registry:   $(REGISTRY)"
	@echo "Namespace:  $(NAMESPACE)"
	@echo "Tag:        $(TAG)"
	@echo "Tool:       $(CONTAINER_TOOL)"
