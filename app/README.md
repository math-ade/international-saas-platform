# Enterprise GitOps Platform & Multi-Node SaaS Compute Infrastructure Cluster

An enterprise-grade, fully automated, high-availability Multi-Tenant SaaS Infrastructure platform engineered over an air-gapped bare-metal cluster network topology. This project completely eliminates manual human provisioning loops, using custom localized GitOps automation pipelines, Infrastructure-as-Code (IaC) templates, and multi-stage container isolation strategies to maintain continuous cloud-native availability under strict local runtime constraints.

---

## 🏗️ System Architecture & Network Topology

![System Infrastructure Diagram](./architecture-diagram.png)

### 🗺️ Infrastructure Node Breakdown

*   **Node 1 (Brain Node — `192.168.56.50`):** Acts as the centralized cluster orchestrator, running **Ansible Core**, automated integration testing matrices, and local GitOps hook environments.
*   **Node 2 (ALB Ingress Node — `192.168.56.51`):** Serves as the single public gateway entry point, executing **HAProxy Layer-7 Reverse Proxy** to route and balance external incoming consumer queries cleanly down to the backend compute layers.
*   **Node 3 (Compute Worker 1 — `192.168.56.52`):** Running an isolated **Podman-Kubernetes runtime pod** mapped to host port `9000` executing the asynchronous application stack.
*   **Node 4 (Compute Worker 2 — `192.168.56.103`):** Running a redundant, identical **Podman-Kubernetes runtime pod** to provide automated fault-tolerance and dynamic cluster resilience.

---

## 🛠️ Deep-Dive Technical Stack Analysis

### 1. Application Layer (Python & FastAPI)
*   **Asynchronous Microservices:** Employs [FastAPI](https://tiangolo.com) for high-throughput, asynchronous non-blocking request handling across multi-tenant data loops.
*   **Telemetry Telemetry Extractor:** Implements the official [Prometheus Client Library](https://github.com) to stream native performance counters directly from runtime workers via an isolated `/metrics` endpoint.

### 2. Containerization (Multi-Stage Environments)
*   **Optimized Compilations:** Uses multi-stage build strategies to strip away development dependencies, compilers, and security exploit vectors, outputting a tiny footprint layer based on a hardened non-root alpine footprint.

### 3. Orchestration & Isolation (Daemonless Podman-K8s)
*   **Bypassing Daemon Failure Points:** Leverages [Podman Pod structures](https://podman.io) to interpret declarative, enterprise-standard Kubernetes pod specifications (`saas_deployment.yaml`) natively on the host network interfaces without running complex master storage frameworks.

### 4. Continuous Delivery Framework (Hands-Free GitOps Pipeline)
*   **Zero-Dependency Deployment Loops:** Runs a custom Git hook script (`post-commit`) that captures repository commits to automatically re-compile application images, package dependencies into system artifacts, distribute binaries across node boundaries via Ansible, drop active legacy pods safely, run integration checks, and re-sync load balancer rule mappings.

---

## 🔄 End-to-End Delivery Pipeline Flow

Whenever an update is committed to the application files, the automation pipeline fires sequentially:

```text
[ Git Commit Triggered ]
          │
          ▼
[ Pipeline Step 1: Compiles Fresh Container Image Layer Natively ]
          │
          ▼
[ Pipeline Step 2: Wipes Old Archive Artifacts & Distributes Images Across Private Network ]
          │
          ▼
[ Pipeline Step 3: Dismantles Old Pod States & Launches Updated Kubernetes Specs on Worker Pool ]
          │
          ▼
[ Pipeline Step 4: Executes Dynamic Integration Test Matrix Against Isolated Port 9000 ]
          │
          ▼
[ Pipeline Step 5: Modifies Ingress Firewalls & Refreshes HAProxy Round-Robin Proxy Paths ]
          │
          ▼
[ 🎉 GITOPS DELIVERY PIPELINE COMPLETELY SUCCESSFUL! ]
```

---

## 📂 Repository Layout Directory Map

```text
├── .git/hooks/                 # Local GitOps continuous delivery engine
│   └── post-commit             # Automated master execution hook script
├── app/                        # Core Application Subsystem
│   ├── src/
│   │   └── main.py             # FastAPI App Engine with custom Prometheus metrics
│   ├── Containerfile           # Multi-stage container compilation instructions
│   └── requirements.txt        # Hardened dependency version manifest rules
├── terraform/                  # Multi-Cloud Migration Modules
│   └── main.tf                 # Reusable AWS Cloud Infrastructure topologies
├── k8s/                        # Native Kubernetes Declarative Spec Layouts
│   └── saas_deployment.yaml    # Master architectural infrastructure manifest
├── test_api.yml                # Automated dynamic variable integration test matrix
├── setup_alb.yml               # HAProxy Ingress controller deployment framework
└── fix_security.yml            # Automated CentOS Stream Firewall & SELinux updates
```

---

## 🚀 How to Execute and Validate the Cluster Platform

To simulate a real-world developer environment change and trigger the complete automated deployment workflow, make a commit from your active workspace folder:

```bash
git commit --allow-empty -m "build: trigger hands-free deployment loop"
```

To monitor real-time node metrics inside your telemetry system, append this cluster definition rule to your active server configuration file:

```yaml
scrape_configs:
  - job_name: 'python-saas-cluster'
    static_configs:
      - targets: ['192.168.56.52:9000', '192.168.56.103:9000']
```
