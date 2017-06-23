@echo off
kubectl apply -f .\dotnetcorewebapp.yaml --record
kubectl get pods
kubectl get svc

echo Wait until the pod and service are started

#|| goto :windows_part
 echo "After that, the app can be accessed at http://$(minikube ip):5555 (via hostPort) or http://$(minikube ip):30555 (via nodePort)"
 #exiting the bash part
exit
:windows_part
 powershell -Command """After that, the app can be accessed at http://$(minikube ip):5555 (via hostPort) or http://$(minikube ip):30555 (via nodePort)"""


