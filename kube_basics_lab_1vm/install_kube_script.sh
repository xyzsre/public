whoami
sudo apt update -y
sudo apt update
sudo apt install -y curl apt-transport-https ca-certificates gnupg lsb-release conntrack
sudo apt install -y containerd
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
cat /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
cat /etc/containerd/config.toml | grep SystemdCgroup
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl status containerd --no-pager
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
cat /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo swapoff -a
cat /etc/fstab
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo modprobe overlay
sudo modprobe br_netfilter
echo -e "overlay\nbr_netfilter" | sudo tee /etc/modules-load.d/k8s.conf
cat /etc/modules-load.d/k8s.conf
echo -e "net.bridge.bridge-nf-call-iptables = 1\nnet.bridge.bridge-nf-call-ip6tables = 1\nnet.ipv4.ip_forward = 1" | sudo tee /etc/sysctl.d/k8s.conf
cat /etc/sysctl.d/k8s.conf
sudo sysctl --system
sudo systemctl enable kubelet
sudo systemctl start kubelet
sudo systemctl status kubelet --no-pager
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
ls -anp $HOME/.kube
cat $HOME/.kube/config
sudo systemctl status kubelet --no-pager
kubectl cluster-info
kubectl get nodes
hostname
kubectl taint nodes host1 node-role.kubernetes.io/control-plane:NoSchedule-
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/custom-resources.yaml
kubectl get nodes
kubectl cluster-info
kubectl get nodes
sudo systemctl status kubelet --no-pager
kubectl get pods -A
kubectl version
kubectl get pods -n kube-system | grep etcd
kubectl get pods -n kube-system | grep scheduler
kubectl get pods -n kube-system | grep controller-manager
sudo systemctl status kubelet --no-pager
kubectl get nodes -o wide
kubectl get pods -n kube-system | grep kube-proxy
sudo systemctl status containerd --no-pager
sudo containerd --version
kubectl get pods -n kube-system | grep coredns
kubectl get service kube-dns -n kube-system
kubectl get pods -n calico-system
kubectl get pods -n tigera-operator
kubectl get pods -A
sudo apt install -y net-tools iftop iotop
