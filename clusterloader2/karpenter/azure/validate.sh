# Remove the failed Karpenter release
helm uninstall karpenter -n karpenter 2>/dev/null || true

# Delete the namespace if needed
kubectl delete namespace karpenter 2>/dev/null || true

# Wait a moment
sleep 2

# Whitelist Karpenter images in Azure Policy
echo "Whitelisting Karpenter container images..."
kubectl patch k8sazurev2customcontainerallowedimages azurepolicy-k8sazurev2customcontainerallow-db27d7bfaf0671f6e28a \
  --type='json' \
  -p='[{"op":"add","path":"/spec/parameters/allowedImages/-","value":"public.ecr.aws/karpenter/*"}]' 2>/dev/null || true

# Add Helm repo if not already added
echo "Adding Karpenter Helm repository..."
helm repo add karpenter https://charts.karpenter.sh
helm repo update

# Try the simpler installation without Azure Workload Identity first
echo "Installing Karpenter..."
helm install karpenter karpenter/karpenter \
  --namespace karpenter \
  --create-namespace \
  --set settings.clusterName=karpenterconfig \
  --wait

# Apply the configuration
kubectl apply -f ./karpenter/azure/karpenter.azure.yml

# # Patch the On-Demand NodePool
# kubectl patch nodepool default --type='json' -p="[{'op': 'replace', 'path': '/spec/template/spec/requirements/2/values', 'value': ['$VM_SIZE']}]"

# # Patch the Spot NodePool
# kubectl patch nodepool spot --type='json' -p="[{'op': 'replace', 'path': '/spec/template/spec/requirements/2/values', 'value': ['$VM_SIZE']}]"

# kubectl get nodepool default -o yaml
# kubectl get nodepool spot -o yaml