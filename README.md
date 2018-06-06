# Image to debug inside k8s

## Tools inside
- telnet

## usage 
kubectl run -it --rm --restart=Never ubuntu --image=tlitovsk/k8sdebug:latest /bin/bash
