#!/usr/bin/env bash
set -euo pipefail

sdk_build_dir=/home/ubuntu/project/src/livox_ros_driver2/Livox-SDK2/build

# The workspace is bind-mounted only when the container starts, so install the
# SDK here rather than during the image build. This registers the shared
# library with the runtime linker before ROS 2 nodes are launched.
if [[ -f "${sdk_build_dir}/Makefile" ]]; then
  sudo make -C "${sdk_build_dir}" install
  sudo ldconfig
else
  echo "Livox SDK build directory not found; skipping SDK installation." >&2
fi

exec /ros_entrypoint.sh "$@"
