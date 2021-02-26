# Caso Práctico II: Automatización de Despliegues en Entorno Cloud

## Check k8s install in master
```console
[ansible@master-nfs ~]# kubectl get nodes
NAME             STATUS     ROLES                  AGE     VERSION
master-nfs.azure NotReady   control-plane,master   9m49s   v1.20.2
[ansible@master-nfs ~]# 
```

## Check Calico install in master
```console
[ansible@master-nfs ~]# kubectl get nodes
NAME             STATUS     ROLES                  AGE     VERSION
master-nfs.azure Ready      control-plane,master   9m49s   v1.20.2
```
Comprobar pods
```console
[ansible@master-nfs ~]# kubectl get pods -A
NAMESPACE         NAME                                       READY   STATUS    RESTARTS   AGE
calico-system     calico-kube-controllers-546d44f5b7-szm8j   1/1     Running   0          8m3s
calico-system     calico-node-dltbq                          1/1     Running   0          8m3s
calico-system     calico-typha-5698b66ddc-5dbxs              1/1     Running   0          8m5s
kube-system       coredns-74ff55c5b-5cp24                    1/1     Running   0          21m
kube-system       coredns-74ff55c5b-w68pg                    1/1     Running   0          21m
kube-system       etcd-master.acme.es                        1/1     Running   1          21m
kube-system       kube-apiserver-master.acme.es              1/1     Running   1          21m
kube-system       kube-controller-manager-master.acme.es     1/1     Running   1          21m
kube-system       kube-proxy-fftw7                           1/1     Running   1          21m
kube-system       kube-scheduler-master.acme.es              1/1     Running   1          21m
tigera-operator   tigera-operator-657cc89589-wqgd6           1/1     Running   0          11m
```


## Check kubernetes in workers
Comprobar en master
```console
[ansible@master-nfs ~]# kubectl get nodes
NAME             STATUS     ROLES                  AGE     VERSION
master-nfs.azure Ready      control-plane,master   9m49s   v1.20.2
worker01.azure   Ready      <none>                 12m     v1.20.2
[ansible@master-nfs ~]# kubectl get pods -A -o wide
NAMESPACE         NAME                                       READY   STATUS    RESTARTS   AGE     IP              NODE               NOMINATED NODE   READINESS GATES
calico-system     calico-kube-controllers-6797d7cc89-2dpqq   1/1     Running   0          9m43s   192.168.4.129   master-nfs.azure   <none>           <none>
calico-system     calico-node-dk9ch                          1/1     Running   0          9m44s   10.0.1.10       master-nfs.azure   <none>           <none>
calico-system     calico-node-h9zdx                          1/1     Running   0          2m8s    10.0.1.20       worker01.azure     <none>           <none>
calico-system     calico-typha-679bf9448b-hb4rz              1/1     Running   0          105s    10.0.1.20       worker01.azure     <none>           <none>
calico-system     calico-typha-679bf9448b-ntp4b              1/1     Running   0          9m44s   10.0.1.10       master-nfs.azure   <none>           <none>
kube-system       coredns-74ff55c5b-7xktt                    1/1     Running   0          9m54s   192.168.4.130   master-nfs.azure   <none>           <none>
kube-system       coredns-74ff55c5b-wvw8k                    1/1     Running   0          9m54s   192.168.4.131   master-nfs.azure   <none>           <none>
kube-system       etcd-master-nfs.azure                      1/1     Running   0          10m     10.0.1.10       master-nfs.azure   <none>           <none>
kube-system       kube-apiserver-master-nfs.azure            1/1     Running   0          10m     10.0.1.10       master-nfs.azure   <none>           <none>
kube-system       kube-controller-manager-master-nfs.azure   1/1     Running   0          10m     10.0.1.10       master-nfs.azure   <none>           <none>
kube-system       kube-proxy-jg5sz                           1/1     Running   0          9m55s   10.0.1.10       master-nfs.azure   <none>           <none>
kube-system       kube-proxy-xm7vv                           1/1     Running   0          2m8s    10.0.1.20       worker01.azure     <none>           <none>
kube-system       kube-scheduler-master-nfs.azure            1/1     Running   0          10m     10.0.1.10       master-nfs.azure   <none>           <none>
tigera-operator   tigera-operator-549bf46b5c-8pqbs           1/1     Running   0          9m54s   10.0.1.10       master-nfs.azure   <none>           <none>
```

Comprobamos en los workers
```console
[ansible@worker01 ~]# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:4d:c6:3d brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.111/24 brd 192.168.1.255 scope global noprefixroute enp1s0
       valid_lft forever preferred_lft forever
    inet6 fe80::5054:ff:fe4d:c63d/64 scope link 
       valid_lft forever preferred_lft forever
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:e8:69:bb:59 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
6: vxlan.calico: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UNKNOWN group default 
    link/ether 66:77:c0:0a:f4:39 brd ff:ff:ff:ff:ff:ff
    inet 192.169.112.0/32 scope global vxlan.calico
       valid_lft forever preferred_lft forever
    inet6 fe80::6477:c0ff:fe0a:f439/64 scope link 
       valid_lft forever preferred_lft forever
```

## Ingress Controller Master
Una vez instalado un ingress controller:
- Comprobamos el namespace
```console
[ansible@master-nfs ~]# kubectl get namespaces
NAME                 STATUS   AGE
calico-system        Active   39m
default              Active   53m
haproxy-controller   Active   2m44s
kube-node-lease      Active   53m
kube-public          Active   53m
kube-system          Active   53m
tigera-operator      Active   43m
[ansible@master-nfs ~]# kubectl get pods --namespace=haproxy-controller
NAME                                       READY   STATUS    RESTARTS   AGE
haproxy-ingress-67f7c8b555-j7qdp           1/1     Running   0          2m55s
ingress-default-backend-78f5cc7d4c-jzfk8   1/1     Running   0          2m57s
```

- Comprobamos los servicios del ingress
```console
[ansible@master-nfs run]$ kubectl get svc -A
NAMESPACE            NAME                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                                     AGE
calico-system        calico-typha              ClusterIP   10.109.195.93    <none>        5473/TCP                                    21m
default              kubernetes                ClusterIP   10.96.0.1        <none>        443/TCP                                     22m
haproxy-controller   haproxy-ingress           NodePort    10.110.87.175    <none>        80:30683/TCP,443:31493/TCP,1024:32367/TCP   2m56s
haproxy-controller   ingress-default-backend   ClusterIP   10.101.249.123   <none>        8080/TCP                                    2m56s
kube-system          kube-dns                  ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP                      22m

```