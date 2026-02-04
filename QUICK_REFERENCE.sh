#!/bin/bash

# Quick Reference: Run Clusterloader2 Load Tests
# ================================================

# BASIC USAGE
# ===========
# NODES=100 bash run-load-test.sh

# PARAMETER REFERENCE
# ====================

cat << 'EOF'

REQUIRED PARAMETERS:
  NODES                    - Number of nodes in cluster

OPTIONAL PARAMETERS (Cluster Sizing):
  NODES_PER_NAMESPACE      - Max nodes per namespace (default: 100)
  PODS_PER_NODE            - Pods per node (default: 30)

OPTIONAL PARAMETERS (Throughput):
  CL2_LOAD_TEST_THROUGHPUT           - Pod creation rate pods/sec (default: 10)
  CL2_DELETE_TEST_THROUGHPUT         - Pod deletion rate pods/sec (default: same as load)
  CL2_RATE_LIMIT_POD_CREATION        - Rate limit pod creation (default: true)

OPTIONAL PARAMETERS (Deployment Sizes):
  BIG_GROUP_SIZE           - Size of big deployments (default: 250)
  MEDIUM_GROUP_SIZE        - Size of medium deployments (default: 30)
  SMALL_GROUP_SIZE         - Size of small deployments (default: 5)

OPTIONAL PARAMETERS (Stateful Sets):
  SMALL_STATEFUL_SETS_PER_NAMESPACE  - Count per namespace (default: 1)
  MEDIUM_STATEFUL_SETS_PER_NAMESPACE - Count per namespace (default: 1)

OPTIONAL PARAMETERS (Features):
  ENABLE_CHAOSMONKEY                             - Enable node failures (default: false)
  CL2_ENABLE_API_AVAILABILITY_MEASUREMENT        - Measure API availability (default: false)
  CL2_ENABLE_NETWORK_POLICY_ENFORCEMENT_LATENCY_TEST - Test network policies (default: false)

OPTIONAL PARAMETERS (Scheduler):
  CL2_SCHEDULER_THROUGHPUT_PODS_PER_DEPLOYMENT - Pods per deployment (auto-calculated if not set)

OPTIONAL PARAMETERS (Commands):
  CL2_EXEC_COMMAND                    - Command to execute during test
  CL2_EXIT_AFTER_EXEC                 - Exit after command (default: false)
  CL2_EXEC_TIMEOUT                    - Command timeout (default: 3600s)
  CL2_SLEEP_AFTER_EXEC_DURATION       - Sleep after command (default: 0s)

OPTIONAL PARAMETERS (Images):
  CL2_LATENCY_POD_REGISTRY            - Container registry (default: registry.k8s.io)
  CL2_LATENCY_POD_IMAGE               - Container image (default: registry/pause:3.9)

OPTIONAL PARAMETERS (QPS):
  CL2_DEFAULT_QPS                     - Default QPS (auto: 10 if <=500 nodes, 100 if >500)

OPTIONAL PARAMETERS (Modules):
  CL2_ADDITIONAL_MEASUREMENT_MODULES  - Additional measurement modules
  CL2_ADDITIONAL_PHASES_MODULES       - Additional phase modules

EXAMPLES
========

# Basic test on 100-node cluster
NODES=100 bash run-load-test.sh

# Small cluster
NODES=50 PODS_PER_NODE=20 bash run-load-test.sh

# Large cluster with high throughput
NODES=500 CL2_LOAD_TEST_THROUGHPUT=50 CL2_DEFAULT_QPS=100 bash run-load-test.sh

# High density (many pods per node)
NODES=100 PODS_PER_NODE=50 BIG_GROUP_SIZE=500 bash run-load-test.sh

# With chaos monkey
NODES=100 ENABLE_CHAOSMONKEY=true bash run-load-test.sh

# Custom command execution
NODES=100 CL2_EXEC_COMMAND="some-command" bash run-load-test.sh

# All measurements enabled
NODES=100 \
  CL2_ENABLE_API_AVAILABILITY_MEASUREMENT=true \
  CL2_ENABLE_NETWORK_POLICY_ENFORCEMENT_LATENCY_TEST=true \
  bash run-load-test.sh

EOF
