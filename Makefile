IMAGE := ghcr.io/wutz/juicefs
TAG   := 1.1-quincy
.PHONY: all
all:
	@echo "make image or push"

.PHONY: image
image:
	docker build \
		-t $(IMAGE):$(TAG) \
		-t $(IMAGE):latest \
		.

.PHONY: push
push: image
	docker push \
		$(IMAGE):$(TAG)
	docker push \
		$(IMAGE):latest
