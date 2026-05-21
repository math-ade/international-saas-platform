# 🚀 Automated HA Cluster & Observability Stack<img width="1408" height="768" alt="image_5b989db9" src="https://github.com/user-attachments/assets/46f467ef-4d11-48a1-8316-ad969c859765" />


A production-grade, 4-node high-availability infrastructure managed via **Ansible** with a proactive monitoring and self-healing system.

## 🏗️ Architecture
- **Control Plane (Node 1):** Ansible Controller, Prometheus engine, and Grafana dashboards.
- **Load Balancer (LB1):** HAProxy managing active-passive traffic failover.
- **Workers (Node 2 & 3):** Containerized Nginx web servers.

## 🛠️ Key Technical Achievements
- **Infrastructure as Code (IaC):** Automated 100% of the server configuration using Ansible.
- **Disaster Recovery (DR):** Successfully performed a manual recovery of the control node from a storage crash, ensuring zero data loss of metrics databases.
- **Proactive Monitoring:** Deployed a Prometheus/Grafana stack to visualize real-time hardware vitals.
- **Event-Driven Self-Healing:** Developed a remediation script triggered by Prometheus alerts to automatically fix overloaded nodes.

## 🚀 How to Run
1. Configure `hosts.ini` with your node IPs.
2. Run the deployment: `ansible-playbook -i hosts.ini deploy_web.yml -K`
3. Access the dashboard: `http://<Node1_IP>:3000`
# international-saas-platform
