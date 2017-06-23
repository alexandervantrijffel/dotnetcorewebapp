# dotnetcorewebapp - Getting started with ASP.NET Core on Docker linux and Kubernetes
This is a full example of running a ASP.NET Core web app based on the Kestrel web server on a Linux based Docker and Kubernetes. Use it to get up to speed quickly with these exciting technologies.

To run the app locally, install [the .NET Core SDK](https://www.microsoft.com/net/download/core) and execute
```
dotnet restore
dotnet run
```

To run the app in a Docker container, install [Docker](https://docs.docker.com/engine/installation/#supported-platforms) and execute
```
docker build -t dotnetcorewebapp .
docker run --rm -ti --name dotnetcorewebapp -p 5555:5555 dotnetcorewebapp
```
The app is now available at url http://localhost:5555.  

To run the app in Kubernetes, install [Minikube or a Kubernetes cluster](#installation-of-kubernetes) and execute
```
kubectl apply -f .\dotnetcorewebapp.yaml --record
```
The docker image for the Kubernetes pod is retrieved from the [Docker Hub](https://hub.docker.com/r/structura/dotnetcorewebapp). 
A Kubernetes [pod](https://kubernetes.io/docs/concepts/workloads/pods/pod/) and a [service])(https://kubernetes.io/docs/concepts/services-networking/service/) are deployed to the cluster. View the status of both with commands
```
kubectl get po -o wide
kubectl get svc -o wide
```
The pod is accessible from the host through a hostport on port 5555 and the service is accessible through a nodeport on port 30555. To find out the external address of the cluster list the node name with the commands
```
kubectl get no
```
And determine the node external ip adress with 
```
kubectl describe no <name of node>
```
This contains a line that starts with Addresses and contains the external ip.  

If you are using Minikube, the external ip is listed with the command
```
minikube ip
```
So with Minikube the dotnetcorewebapp is available at http://$(minikube ip):5555 and http://$(minikube ip):30555.

## Installation of kubernetes

### Installing Minikube on Ubuntu
Follow the [installation instructions](https://kubernetes.io/docs/tasks/tools/install-minikube). 

### Installing a Kubernetes cluster on Linux
Execute the commands listed in [kubernetes-tools](https://github.com/alexandervantrijffel/kubernetes-tools). 

### Installing Minikube on Windows
Install Minikube on Windows 10 as described [here](https://blogs.msdn.microsoft.com/wasimbloch/2017/01/23/setting-up-kubernetes-on-windows10-laptop-with-minikube).  

Run minikube using virtual box with the hyperv driver. Replace "New Virtual Switch" with the name of the Hyper-V switch you created in the previous step.
```
minikube.exe start --vm-driver=hyperv --memory=1536 --hyperv-virtual-switch="New Virtual Switch" --v=7
```

Test if networking is setup correctly with 
```
minikube ssh
```

A bash terminal inside the minikube VM should be opened. If not, check your [Hyper-V network settings](https://docs.docker.com/machine/drivers/hyper-v/#2-set-up-a-new-external-network-switch-optional).

The Hyper-V VM can also be controlled by taking the following steps:
- Start 'Hyper-V Manager'
- Double click the minikube VM
- Login with user **docker** and password **tcuser**

Test if Kubernetes is running with
```
kubectl cluster-info
```

## Next steps
[Deploy a private Docker registry](https://github.com/alexandervantrijffel/kubernetes-tools#install-a-private-docker-registry) to your Kubernetes cluster. This allows for deploying new versions of the ASP.NET Core web app by pushing new Docker images to the registry and having the Kubernetes cluster pull the new versions.
