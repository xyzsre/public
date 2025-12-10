

#!/bin/bash

# 1. Validate Vagrantfile
echo "1. Validating Vagrantfile..."
vagrant validate

# 2. Check initial status
echo "2. Checking initial Vagrant status..."
vagrant status

# 3. Start hosts one by one
echo "3. Starting host1..."
vagrant up host1

echo "4. Starting host2..."
vagrant up host2

echo "5. Starting host3..."
vagrant up host3

# 4. Final status check
echo "6. Final Vagrant status check..."
vagrant status

# 5. Update package lists on all hosts
echo "7. Updating package lists on all hosts..."
vagrant ssh host1 -c "sudo apt update"
vagrant ssh host2 -c "sudo apt update"
vagrant ssh host3 -c "sudo apt update"

# 6. Install Kubernetes on all hosts
vagrant ssh host1 -c "sudo bash /vagrant/kubernetes-install.sh"
vagrant ssh host2 -c "sudo bash /vagrant/kubernetes-install.sh"
vagrant ssh host3 -c "sudo bash /vagrant/kubernetes-install.sh"

# 7. Verify Kubernetes installation on all hosts
echo "9. Verifying Kubernetes installation on all hosts..."
vagrant ssh host1 -c "sudo bash /vagrant/verification.sh"
vagrant ssh host2 -c "sudo bash /vagrant/verification.sh"
vagrant ssh host3 -c "sudo bash /vagrant/verification.sh"

# 8. Simple verification on all hosts
echo "10. Running simple verification on all hosts..."
vagrant ssh host1 -c "sudo bash /vagrant/simple-verification.sh"
vagrant ssh host2 -c "sudo bash /vagrant/simple-verification.sh"
vagrant ssh host3 -c "sudo bash /vagrant/simple-verification.sh"

# 9. Setup control plane on host1 with Calico CNI and Metrics Server
echo "11. Setting up Kubernetes control plane on host1..."
vagrant ssh host1 -c "sudo bash /vagrant/setup-control-plane.sh"

# 10. Setup kubectl configuration for vagrant user
# echo "12. Setting up kubectl configuration for vagrant user..."
# sudo cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config && sudo chown vagrant:vagrant /home/vagrant/.kube/config

# 11. Install conntrack on worker nodes
# echo "13. Installing conntrack on worker nodes..."
# sudo apt install -y conntrack

# 12. Join worker nodes to cluster
# echo "14. Joining worker nodes to cluster..."
sudo kubeadm join 192.168.56.10:6443 --token n2fbfo.idwy66xjx6gpcp0p --discovery-token-ca-cert-hash sha256:02e518e50fe51375dc983f314be9c4c593eb4072b6b0b14b79722fd428ac8a86

# 13. Verify cluster status with kubectl configuration
# echo "15. Verifying cluster status with kubectl configuration..."
kubectl get nodes
kubectl get pods -n kube-system
kubectl get pods -A
kubectl get pods -A -o wide
kubectl get pods -A -o wide | grep -E "host2|host3"

# echo "=== SETUP COMPLETE ==="
# echo "Kubernetes cluster is ready with:"
# echo "- Control plane: host1 (192.168.56.10)"
# echo "- Worker nodes: host2, host3"
# echo "- CNI: Calico"
# echo "- Metrics Server: installed"
# echo "- All nodes joined successfully"
# echo ""
# echo "Simple kubectl commands now work on host1:"
# echo "kubectl get nodes"
# echo "kubectl get pods -n kube-system"


# Deploy First Application
# Deploy nginx
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=NodePort

# Access the application
kubectl get services


# 14. Deploy test application (nginx with 3 replicas)
# echo "16. Creating manifests folder and deploying nginx application..."
cd /vagrant/manifests/
kubectl apply -f nginx-deployment.yaml


# 15. Verify nginx deployment
# echo "17. Verifying nginx deployment..."
kubectl get deployments
kubectl get pods
kubectl get services
kubectl get pods -o wide


# 16. Detailed nginx verification
# echo "18. Detailed nginx verification..."
kubectl describe deployment nginx-deployment
kubectl describe service nginx-service
curl -I http://10.104.179.193
kubectl logs nginx-deployment-7cfcf9b64b-nzxpd --tail=10

# ALIAS
alias kgn="kubectl get nodes"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kgl="kubectl get pods -o wide"
alias kglw="kubectl get pods -o wide | grep -E 'host2|host3'"
alias kgd="kubectl get deployments"
alias ktn="kubectl top nodes"
alias ktp="kubectl top pods"


# 17. Fix Metrics Server TLS issues
# echo "19. Fixing Metrics Server TLS issues..."
kubectl get deployment -n kube-system
kubectl delete deployment metrics-server -n kube-system
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml --validate=false
kubectl get pods -A | grep metric
kubectl patch deployment metrics-server -n kube-system --patch-file metrics-server-patch.yaml
kubectl get pods -A | grep metric


# 18. Verify Metrics Server is working
# echo "20. Verifying Metrics Server functionality..."
sleep 30
kubectl get pods -n kube-system | grep metrics
kubectl top nodes
kubectl top pods


# 19. Install Helm and deploy test application
# echo "21. Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# 20. Verify Helm installation
# echo "22. Verifying Helm installation..."
helm version

# 21. Add Helm repositories
# echo "23. Adding Helm repositories..."
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update


# 22. Create and deploy Helm chart
echo "24. Creating and deploying Helm chart..."
helm create simple-helm-app
helm install my-simple-app ./simple-helm-app --set replicaCount=2

# 23. Verify Helm deployment
# echo "25. Verifying Helm deployment..."
sleep 20
kubectl get pods
helm list
helm status my-simple-app
kubectl get services


# 24. Verify and test simple app functionality
# echo "26. Verifying and testing simple app functionality..."
kubectl describe deployment my-simple-app-simple-helm-app
kubectl get pods -o wide
kubectl get service
kubectl describe service my-simple-app-simple-helm-app

curl -I http://10.100.56.161
curl -s http://10.100.56.161 | head -10
curl -I http://192.168.183.70
kubectl top pods | grep simple-app


# 25. Cleanup deployments and services
# echo "27. Cleaning up deployments and services..."
helm uninstall my-simple-app
kubectl delete deployment nginx-deployment
kubectl delete service nginx-service

# TEST
kubectl apply -f simple-app.yaml
kubectl get pods
kubectl delete deployment simple-app

# 26. Verify cleanup
# echo "28. Verifying cleanup..."
sleep 10
kubectl get pods
kubectl get services
helm list
kubectl get nodes
kubectl top nodes

# echo "=== CLEANUP COMPLETE ==="
# echo "All test deployments and services removed"
# echo "Kubernetes cluster remains healthy and ready"

# 27. Deploy PHP Hello World application
# echo "29. Deploying PHP Hello World application..."
kubectl apply -f php-hello-world.yaml


# 28. Verify PHP Hello World deployment
# echo "30. Verifying PHP Hello World deployment..."
kubectl get deployments
kubectl get pods
kubectl get services
kubectl get pods -o wide


# 29. Test PHP Hello World application functionality
# echo "31. Testing PHP Hello World application functionality..."
kubectl describe deployment php-hello-world
kubectl describe service php-hello-world
curl -I http://10.103.156.170
curl -s http://10.103.156.170 | head -10
curl -I http://192.168.119.6
kubectl top pods | grep php-hello-world

# echo "=== PHP HELLO WORLD DEPLOYMENT COMPLETE ==="
# echo "PHP Hello World application successfully deployed with:"
# echo "- 3 replicas running on all 3 nodes"
# echo "- ClusterIP service: 10.103.156.170"
# echo "- NodePort service: 30080"
# echo "- PHP version: 8.1 with Apache"
# echo "- Pod distribution across all cluster nodes"


# 30. Update PHP application...
# echo "32. Updating PHP application ..."
kubectl apply -f php-hello-worldv2.yaml

# 31. Restart deployment to apply ConfigMap changes
# echo "33. Restarting deployment to apply ConfigMap changes..."
kubectl rollout restart deployment php-hello-world

kubectl delete -f php-hello-worldv2.yaml


# 32. Verify updated deployment
# echo "34. Verifying updated PHP deployment..."
sleep 20
kubectl get pods
kubectl get services
curl -I http://10.103.156.170
kubectl get configmap

# echo "=== PHP APPLICATION UPDATE COMPLETE ==="
# echo "PHP Hello World application updated successfully:"
# echo "- All 3 pods restarted with new configuration"


# 33. Create storage class for WordPress deployment
# echo "35. Creating storage class for WordPress deployment..."
kubectl apply -f storage-class.yaml

# 34. Deploy WordPress application with MySQL database
# echo "36. Deploying WordPress application with MySQL database..."
kubectl apply -f wordpress-deployment.yaml


# 35. Verify WordPress deployment
# echo "37. Verifying WordPress deployment..."
sleep 30
kubectl get pods
kubectl get services
kubectl get pods -o wide


# 36. Test WordPress application functionality
# echo "38. Testing WordPress application functionality..."
curl -I http://10.109.32.44
kubectl describe deployment wordpress
kubectl describe deployment wordpress-mysql
kubectl logs wordpress-65784c64d9-sr94g --tail=5


# echo "=== WORDPRESS DEPLOYMENT COMPLETE ==="
# echo "WordPress application successfully deployed with:"
# echo "- WordPress frontend accessible at: http://192.168.56.10:30082"
# echo "- MySQL database backend deployed"
# echo "- Persistent storage configured"
# echo "- Ready for WordPress setup and configuration"
# echo "- Database credentials: wordpress/wordpress123"

# 37. Verify WordPress file storage locations on nodes
# echo "39. Verifying WordPress file storage locations on nodes..."
kubectl get pods -o wide
kubectl get pv
kubectl get pvc

# 38. Check WordPress files on host3 (where pods are running)
# echo "40. Checking WordPress files on host3 (where pods are running)..."
sudo ls -la /tmp/
sudo ls -la /tmp/wordpress-data/
sudo ls -la /tmp/wordpress-data/wp-content/
sudo ls -la /tmp/wordpress-mariadb-data/


# 39. Verify storage usage and disk space
# echo "41. Verifying storage usage and disk space..."
sudo df -h /tmp/wordpress-data /tmp/wordpress-mariadb-data
sudo du -sh /tmp/wordpress-data /tmp/wordpress-mariadb-data


# 40. Check WordPress configuration files
# echo "42. Checking WordPress configuration files..."
sudo cat /tmp/wordpress-data/wp-config.php | head -10
sudo ls -la /tmp/wordpress-data/wp-content/themes/
sudo ls -la /tmp/wordpress-data/wp-content/plugins/


# echo "=== WORDPRESS STORAGE VERIFICATION COMPLETE ==="
# echo "WordPress files are stored at:"
# echo "- WordPress files: /tmp/wordpress-data/ "
# echo "- MariaDB data: /tmp/wordpress-mariadb-data/ "
# echo "- Persistent Volumes: wordpress-pv (5Gi), wordpress-mariadb-pv (8Gi)"
# echo "- Both PVs are bound and operational"
# echo "- WordPress configuration file created and ready"


# 41. Clean up WordPress deployment and storage
# echo "43. Cleaning up WordPress deployment and storage..."
kubectl delete -f wordpress-deployment.yaml
kubectl delete -f storage-class.yaml


# 42. Verify WordPress cleanup
# echo "44. Verifying WordPress cleanup..."
kubectl get pods
kubectl get services
kubectl get pv
kubectl get pvc


# 43. Clean up remaining files on host3
# echo "45. Cleaning up remaining files on host3..."
sudo rm -rf /tmp/wordpress-data /tmp/wordpress-mariadb-data
sudo ls -la /tmp/ | grep wordpress 


# echo "=== WORDPRESS CLEANUP COMPLETE ==="
# echo "WordPress deployment and storage completely removed:"
# echo "- All WordPress pods and services deleted"
# echo "- All PersistentVolumes and Claims deleted"
# echo "- StorageClass deleted"
# echo "- Local files on hosts cleaned up"



# 44. Clean up PHP Hello World deployment
# echo "46. Cleaning up PHP Hello World deployment..."
kubectl delete -f /vagrant/manifests/php-hello-world.yaml


# 45. Verify PHP Hello World cleanup
# echo "47. Verifying PHP Hello World cleanup..."
kubectl get pods
kubectl get services
kubectl get all



# 46. Install Rancher Kubernetes Management Platform
# echo "49. Installing Rancher Kubernetes Management Platform..."
kubectl apply -f rancher-namespace.yaml


# 47. Install cert-manager for Rancher SSL certificates
# echo "50. Installing cert-manager for Rancher SSL certificates..."
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.yaml

# kubectl delete -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.yaml


# 48. Wait for cert-manager to be ready
# echo "51. Waiting for cert-manager to be ready..."
sleep 60 
kubectl get pods -n cert-manager


# 49. Add Rancher Helm repository
# echo "52. Adding Rancher Helm repository..."
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo update


# 50. Install Rancher using Helm
# echo "53. Installing Rancher using Helm..."
helm install rancher rancher-stable/rancher --namespace cattle-system --set hostname=rancher.local --set bootstrapPassword=rancher123 --set replicas=1


# 51. Wait for Rancher to be ready
# echo "54. Waiting for Rancher to be ready..."
sleep 180
kubectl get pods -n cattle-system
kubectl get services -n cattle-system
kubectl get ingress -n cattle-system
kubectl get deployments -n cattle-system


# 52. Create NodePort service for Rancher access
# echo "55. Creating NodePort service for Rancher access..."
kubectl apply -f rancher-nodeport.yaml


# 53. Verify Rancher installation
# echo "56. Verifying Rancher installation..."
kubectl get pods -n cattle-system
kubectl get services -n cattle-system
kubectl get ingress -n cattle-system
kubectl get deployments -n cattle-system
curl -k -I https://192.168.56.10:30444


# tshoot
kubectl get pods -A | grep cattle
kubectl describe pod X -n cattle-system
kubectl logs X -n cattle-system --all-containers=true
kubectl get events -n cattle-system --sort-by='.lastTimestamp' | tail -10
kubectl get jobs -n cattle-system
kubectl get secrets -n cattle-system | grep helm
kubectl get deployment rancher -n cattle-system -o yaml | grep -A 5 -B 5 replicas
kubectl get ingress -n cattle-system
kubectl delete pods -n cattle-system -l pod-impersonation.cattle.io/token --force --grace-period=0
kubectl get pods -n cattle-system
curl -k -I https://192.168.56.10:30444
kubectl get deployment -n cattle-system
helm uninstall rancher --namespace cattle-system
kubectl delete -f rancher-nodeport.yaml
kubectl delete -f rancher-namespace.yaml
kubectl delete namespace cattle-capi-system --force --grace-period=0
kubectl delete namespace cattle-fleet-local-system --force --grace-period=0
kubectl delete namespace cattle-turtles-system --force --grace-period=0


# 54. Test Rancher accessibility
# echo "57. Testing Rancher accessibility..."
curl -k -I https://192.168.56.10:30444
kubectl get secret --namespace cattle-system bootstrap-secret -o jsonpath='{.data.bootstrapPassword}' | base64 -d


# echo "=== RANCHER INSTALLATION COMPLETE ==="
# echo "Rancher Kubernetes Management Platform successfully installed:"
# echo "- Rancher accessible at: https://192.168.56.10:30444"
# echo "- Bootstrap password: rancher123"
# echo "- Namespace: cattle-system"
# echo "- cert-manager installed for SSL certificates"
# echo "- NodePort service created for external access"
# echo "- Ready for cluster management and configuration"

# 55. Stop all Vagrant hosts
# echo "58. Stopping all Vagrant hosts..."
vagrant ssh host1 -c "sudo poweroff"
vagrant ssh host2 -c "sudo poweroff"
vagrant ssh host3 -c "sudo poweroff"

# 56. Verify hosts are stopped
# echo "59. Verifying hosts are stopped..."
vagrant status

