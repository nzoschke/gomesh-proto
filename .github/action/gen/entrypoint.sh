#!/bin/bash
set -ex

prototool lint      proto
prototool format -l proto
prototool generate  proto
prototool generate  proto_ext

find gen -name 'mock_*.go' -delete
mockery -all -dir gen -inpkg
