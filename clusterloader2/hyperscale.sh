go run ./cmd/clusterloader.go --provider aks -v=4 \
    --testconfig ./testing/load/config.yaml \
    --kubeconfig $HOME/hs-64 \
    --enable-prometheus-server=true \
    --tear-down-prometheus-server=true \
    --testoverrides=/home/vsalim/perf-tests/clusterloader2/testing/overrides/hyperscale.yaml \
    --prometheus-scrape-kube-state-metrics=true \
    --report-dir=report