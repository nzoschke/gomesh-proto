# GoMesh Protos

| Repository                                  |
|---------------------------------------------|
| [Protocol Buffer Service Defintions][1]     |
| [Generated Client and Server Interfaces][2] |
| [gRPC Servers][3]                           |

[1]: https://github.com/nzoschke/gomesh
[2]: https://github.com/nzoschke/gomesh-interface
[3]: https://github.com/nzoschke/gomesh-proto

## Quick Start

This project uses:

- [Docker CE](https://www.docker.com/community-edition)
- [GitHub Actions](https://developer.github.com/actions/)
- [Go 1.11](https://golang.org/)
- [lyft/protoc-gen-validate](https://github.com/lyft/protoc-gen-validate)
- [protoc](https://github.com/protocolbuffers/protobuf)
- [Protocol Buffers](https://developers.google.com/protocol-buffers/)
- [uber/prototool](https://github.com/uber/prototool)

### Install the tools

```console
$ brew install go prototool
$ open https://store.docker.com/search?type=edition&offering=community
```

<details>
<summary>We may want to upgrade existing tools...</summary>
&nbsp;

```console
$ brew upgrade go prototool
```
</details>

<details>
<summary>We may want to double check the installed versions...</summary>
&nbsp;

```console
$ docker version
Client: Docker Engine - Community
 Version:           18.09.0
 API version:       1.39
 Go version:        go1.10.4
 Git commit:        4d60db4
 Built:             Wed Nov  7 00:47:43 2018
 OS/Arch:           darwin/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.0
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       4d60db4
  Built:            Wed Nov  7 00:55:00 2018
  OS/Arch:          linux/amd64
  Experimental:     false

$ go version
go version go1.11.4 darwin/amd64

$ prototool version
Version:                 1.3.0
Default protoc version:  3.6.1
Go version:              go1.11
Built:                   Mon Sep 17 17:46:54 UTC 2018
OS/Arch:                 darwin/amd64
```
</details>

### Get the service definitions

We start by getting and building `github.com/nzoschke/gomesh-proto`:

```console
$ git clone https://github.com/nzoschke/gomesh-proto.git ~/dev/gomesh-proto
$ cd ~/dev/gomesh-proto

$ make gen
Sending build context to Docker daemon  5.632kB
Step 1/19 : FROM golang:1.11
Step 2/19 : ARG PROTOC_VERSION=3.6.1
Step 3/19 : ARG PROTOTOOL_VERSION=1.3.0
...
Successfully built 4dc224677ca6
Successfully tagged gen:latest
docker run -v /Users/noah/dev/mesh/gomesh-proto:/github/workspace gen
...
Generating mock for: UsersClient in file: /github/workspace/gen/go/users/v2/mock_UsersClient.go
```

We can inspect the generated files:

```console
$ ls gen
go      js      pb      swagger
```

This gives us confidence in our protocol buffer compilation environment.

### Update the service definitions

Generate a .proto stub:

```console
$ mkdir -p proto/users/v1
$ prototool create proto/users/v1/users.proto
```

Fill in service names and messages:

```proto
syntax = "proto3";

package gomesh.users.v1;

option go_package = "v1pb";
option java_multiple_files = true;
option java_outer_classname = "UsersProto";
option java_package = "com.gomesh.users.v1";

import "google/protobuf/timestamp.proto";

service Users {
  rpc Get(GetRequest) returns (User);
  rpc Create(CreateRequest) returns (User);
}

message User {
  string id = 1;
  string parent = 2;
  string name = 3;
  string display_name = 4;
  google.protobuf.Timestamp create_time = 5;
}

message GetRequest { string name = 1; }

message CreateRequest {
  string parent = 1;
  User user = 2;
}
```

Format and lint .proto:

```console
$ prototool format -w proto
$ prototool lint proto
```

### Publish generated clients and server interfaces

```shell
```

## Docs

Check out [the docs folder](docs/) where each component is explained in more detail.

## Contributing

Find a bug or see a way to improve the project? [Open an issue](https://github.com/nzoschke/gomesh-proto/issues).

## License

Apache 2.0 © 2019 Noah Zoschke