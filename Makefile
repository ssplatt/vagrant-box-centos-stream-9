.PHONY: build build-vmware clean upload cilocal

build:
	./scripts/build_box_virtualbox.sh

build-vmware:
	./scripts/build_box_vmware.sh

clean:
	find . -type d -name "output" -exec rm -rf {} \;

upload:
	./scripts/upload_artifact.sh

cilocal: clean build upload
