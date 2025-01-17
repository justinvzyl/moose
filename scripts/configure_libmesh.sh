#!/usr/bin/env bash
#* This file is part of the MOOSE framework
#* https://www.mooseframework.org
#*
#* All rights reserved, see COPYRIGHT for full restrictions
#* https://github.com/idaholab/moose/blob/master/COPYRIGHT
#*
#* Licensed under LGPL 2.1, please see LICENSE for details
#* https://www.gnu.org/licenses/lgpl-2.1.html

# Configure libMesh with the default MOOSE configuration options
#
# Separated so that it can be used across all libMesh build scripts:
# - scripts/update_and_rebuild_libmesh.sh
# - conda/libmesh/build.sh
function configure_libmesh()
{
  if [ -z "$SRC_DIR" ]; then
    echo "SRC_DIR is not set for configure_libmesh"
    exit 1
  fi

  if [ ! -d "$SRC_DIR" ]; then
    echo "$SRC_DIR=SRC_DIR does not exist"
    exit 1
  fi

  if [ -z "$LIBMESH_DIR" ]; then
    echo "$LIBMESH_DIR is not set for configure_libmesh"
    exit 1
  fi

  if [ -z "$METHODS" ]; then
    echo "METHODS must be set in configure_libmesh"
    exit 1
  fi

  # Preserves capability in update_and_rebuild_libmesh.sh, but this is set in
  # conda/libmesh/build.sh. If not, conda considers it an "unbound variable"
  if [[ -n "$INSTALL_BINARY" ]]; then
    echo "INFO: INSTALL_BINARY set"
  else
    export INSTALL_BINARY="${SRC_DIR}/build-aux/install-sh -C"
  fi

  cd ${SRC_DIR}/build
  ../configure --enable-silent-rules \
               --enable-unique-id \
               --disable-warnings \
               --enable-glibcxx-debugging \
               --with-thread-model=openmp \
               --disable-maintainer-mode \
               --enable-petsc-hypre-required \
               --enable-metaphysicl-required \
               --with-cxx-std-min=2014 \
               --without-gdb-command \
               --with-methods="${METHODS}" \
               --prefix="${LIBMESH_DIR}" \
               --with-future-timpi-dir="${LIBMESH_DIR}" \
               INSTALL="${INSTALL_BINARY}" \
               $*

  return $?
}
