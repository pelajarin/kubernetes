.PHONY: cluster
cluster:
	kind create cluster --config Cluster.yaml

.PHONY: cluster.del
cluster.del:
	kind delete cluster

.PHONY: gateway
gateway:
	@echo "# Installing Gateway API Resources"
	kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.6.2" | kubectl apply -f -
	@echo "# Installing NGINX Gateway Fabric"
	helm install ngf oci://ghcr.io/nginx/charts/nginx-gateway-fabric \
		-n nginx-gateway \
		--values nginx-gateway-fabric-values.yaml \
		--create-namespace
