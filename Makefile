.PHONY: build build-vmware clean upload cilocal

build:
	./scripts/build_box_virtualbox.sh

build-vmware:
	./scripts/build_box_vmware.sh

clean:
	rm -rf ./vmware ./virtualbox

upload:
	./scripts/upload_artifact.sh

cilocal: clean build upload
