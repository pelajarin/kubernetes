.PHONY: cluster
cluster:
	kind create cluster --config Cluster.yaml

.PHONY: cluster2
cluster2:
	kind create cluster --config Cluster2.yaml

.PHONY: cluster.del
cluster.del:
	kind delete cluster

.PHONY: ingress
ingress:
	helm upgrade --install ingress-nginx ingress-nginx \
		--repo https://kubernetes.github.io/ingress-nginx \
		--namespace ingress-nginx \
		--values nginx-ingress-values.yaml \
		--create-namespace \
		--debug
