#!/usr/bin/env bash
# Track the libvirt domain XML for dev-machine in this repo.
#   ./vm-xml.sh pull   snapshot libvirt's persistent config -> repo copy
#   ./vm-xml.sh push   apply repo copy -> libvirt (takes effect on next full VM power off + start)
#   ./vm-xml.sh diff   show drift between repo copy and libvirt
set -euo pipefail

URI="qemu:///system"   # explicit: user default URI is qemu:///session, which is a different domain
DOM="dev-machine"
XML="$(dirname "$0")/dev-machine.xml"

case "${1:-}" in
  pull) virsh -c "$URI" dumpxml --inactive "$DOM" > "$XML" ;;
  push) virsh -c "$URI" define "$XML" ;;
  diff) virsh -c "$URI" dumpxml --inactive "$DOM" | diff -u "$XML" - ;;
  *)    echo "usage: $0 {pull|push|diff}" >&2; exit 1 ;;
esac
