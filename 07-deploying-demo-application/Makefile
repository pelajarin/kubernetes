.PHONY: cluster
cluster:
	kind create cluster --config Cluster.yaml

.PHONY: cluster.rm
cluster.rm:
	kind delete cluster

# # i cannot make nginx gateway to work, it just reset/hang my connection :/
# .PHONY: gateway
# gateway:
# 	@echo "# Installing Gateway API Resources"
# 	kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v2.0.1" | kubectl apply -f -
# 	@echo "# Installing NGINX Gateway Fabric"
# 	helm install ngf "oci://ghcr.io/nginx/charts/nginx-gateway-fabric" \
# 		--create-namespace \
# 		--namespace nginx-gateway \
# 		--values nginx-gateway-fabric-values.yaml
#
# .PHONY: gateway.rm
# gateway.rm:
# 	helm uninstall ngf --namespace nginx-gateway
#
# .PHONY: gateway.example
# gateway.example:
# 	kubectl apply --filename Example.yaml
#
# .PHONY: gateway.example.rm
# gateway.example.rm:
# 	kubectl delete --filename Example.yaml

.PHONY: gateway
gateway:
	@echo "# Installing Gateway API CRDs from the Standard channel."
	kubectl apply --filename https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.1/standard-install.yaml
	@echo "# Installing Traefik RBACs."
	kubectl apply --filename https://raw.githubusercontent.com/traefik/traefik/v3.4/docs/content/reference/dynamic-configuration/kubernetes-gateway-rbac.yml
	@echo "# Installing Traefik Helm Chart"
	helm repo add traefik https://traefik.github.io/charts
	helm repo update
	helm install traefik traefik/traefik \
		--create-namespace \
		--namespace traefik-gateway-api \
		--values traefik-values.yaml

.PHONY: cnpg
cnpg:
	@echo "# Adding CNPG chart repository to helm"
	helm repo add cnpg https://cloudnative-pg.github.io/charts
	@echo "# Installing CNPG operator chart"
	helm upgrade --install cnpg \
		--namespace cnpg-system \
		--create-namespace \
		--set config.clusterWide=false \
		cnpg/cloudnative-pg
	@echo "# Applying CNPG cluster yaml"
	kubectl apply --filename Clustercnpg.yaml

.PHONY: registry
registry:
	docker run --detach \
		--name registry \
		--publish 5000:5000 \
		--restart unless-stopped \
		registry:3.0.0

.PHONY: stack
stack:
	kubectl apply \
		--filename ./Namespace.yaml \
		--filename ./ConfigMap.yaml \
		--filename ./Deployment.yaml \
		--filename ./Gateway.yaml \
		--filename ./HTTPRoute.yaml \
		--filename ./Job.yaml \
		--filename ./Secret.yaml \
		--filename ./Service.yaml

.PHONY: stack.rm
stack.rm:
	kubectl delete \
		--filename ./Namespace.yaml \
		--filename ./ConfigMap.yaml \
		--filename ./Deployment.yaml \
		--filename ./Gateway.yaml \
		--filename ./HTTPRoute.yaml \
		--filename ./Job.yaml \
		--filename ./Secret.yaml \
		--filename ./Service.yaml
