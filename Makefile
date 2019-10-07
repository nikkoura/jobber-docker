IMAGE=nikkoura/jobber
ARCH=arm64
ALPINE_VERSION=3.7
JOBBER_VERSION_X=1
JOBBER_VERSION_Y=4
JOBBER_VERSION_Z=0

default: image push manifest

image:
		docker build \
			-t ${IMAGE}:latest \
			-t ${IMAGE}:${ARCH} \
			-t ${IMAGE}:${JOBBER_VERSION_X}-alpine${ALPINE_VERSION}-${ARCH} \
			-t ${IMAGE}:${JOBBER_VERSION_X}.${JOBBER_VERSION_Y}-alpine${ALPINE_VERSION}-${ARCH} \
			-t ${IMAGE}:${JOBBER_VERSION_X}.${JOBBER_VERSION_Y}.${JOBBER_VERSION_Z}-alpine${ALPINE_VERSION}-${ARCH} \
			alpine3.7

push: image
		docker push ${IMAGE}:${ARCH}
		docker push ${IMAGE}:${JOBBER_VERSION_X}-alpine${ALPINE_VERSION}-${ARCH} 
		docker push ${IMAGE}:${JOBBER_VERSION_X}.${JOBBER_VERSION_Y}-alpine${ALPINE_VERSION}-${ARCH} 
		docker push ${IMAGE}:${JOBBER_VERSION_X}.${JOBBER_VERSION_Y}.${JOBBER_VERSION_Z}-alpine${ALPINE_VERSION}-${ARCH} 

manifest: push
		manifest-tool push from-args --platforms linux/arm64 --template ${IMAGE}:ARCH --target ${IMAGE}:${ARCH}
