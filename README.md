## Install/Upgrade Ruby on rails app on docker desktop & local kubernetes

## Description

* This project is for building a hello rails app using terraform inside a docker desktop (local Kubernetes enabled).
* This also install nginx ingress controller along with redis service.
* A rails app has been dockerized, please find the project under "app/docker" folder along with the Dockerfile

## Required tools

* kubectl
* terraform >= v1.4.6
* helm tools
* docker desktop for mac/windows

## Steps:

* Install docker desktop and enable kubernetes support from the settings page.

<img width="1022" alt="Screenshot 2023-06-06 at 7 21 00 AM" src="https://github.com/obenziane21/rails-local-kubernetes/assets/29074361/91395922-4ff2-4ddd-b4ab-01d40ba3449c">


* Head on the terraform folder and run the setup, please make sure that you are using a version >= v1.4.6

```
terraform init
terraform apply
```

Note: This might take up 5 mins to finish the setup

* One the provisioning is Complete, please add an entry to your /etc/hosts (nip.io is preferable).

```
127.0.0.1     rails.devops.local
```

* Note: port 443 and 80 of the nginx loadBalancer should be exposed to the localhost by now

* you should be the access the web rails hello app from your browser: http://http://rails.devops.local


## Monitoring ingress logs

* While hitting the endpoint: http://rails.devops.local ,we get http logs from the ingress nginx controller pod


```
kubectl -n kube-system logs ingress-nginx-controller-xxxxxx-xxx -f
............................................................................
192.168.65.4 - - [05/Jun/2023:15:38:32 +0000] "GET / HTTP/1.1" 200 123319 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.1 Safari/605.1.15" 367 0.041 [default-railsapp-service-3000] [] 10.1.0.34:3000 123082 0.041 200 aea59347a7c0dccc1a4cce56f1480ec9
192.168.65.4 - - [05/Jun/2023:15:38:33 +0000] "GET / HTTP/1.1" 200 123319 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.1 Safari/605.1.15" 367 0.011 [default-railsapp-service-3000] [] 10.1.0.34:3000 123082 0.011 200 7a2548f4b6c8b2656fec2218bd71d3c0
```

## Comments

* You can always use minikube insated docker desktop, but there are some limitations on exposing the minikube ip for dns resolution. Docker desktop is easier and simpler

## Conclusion
* Any questions or comments, please share!
