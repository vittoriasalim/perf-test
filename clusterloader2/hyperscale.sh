go run ./cmd/clusterloader.go --provider aks -v=4 \
    --testconfig=$HOME/perf-upstream/perf-tests/clusterloader2/testing/load/config.yaml \
    --kubeconfig=$HOME/hs-64 \
    --k8s-clients-number=10 \
    --nodes=8000 \
    --enable-prometheus-server=true \
    --testoverrides=$HOME/perf-upstream/perf-tests/clusterloader2/testing/overrides/hyperscale.yaml \
    --report-dir=report-2