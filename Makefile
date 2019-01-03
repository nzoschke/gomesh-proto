clean:
	rm -rf gen

# generate on .proto file changes
PROTOS = $(wildcard proto/*/*/*.proto)
PBGOS  = $(PROTOS:proto/%.proto=gen/go/%.pb.go)
$(PBGOS): gen/go/%.pb.go: proto/prototool.yaml proto/%.proto proto_ext/prototool.yaml
	cd ./.github/action/gen && docker build -t gen .
	docker run -v $(PWD):/github/workspace gen

gen: $(PBGOS)

lint:
	prototool format -w proto
	prototool lint proto