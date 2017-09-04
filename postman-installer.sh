#!/bin/bash
#
# Copyright 2017 Matias Pino
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

TMP_DIR=/tmp/postman-installer
INSTALL_DIR=~/opt
BIN_DIR=~/bin

# @TODO make these values arguments

if [ -d $TMP_DIR ]; then
  echo 'Removing old temporary directory'
  rm -r $TMP_DIR
fi

echo 'Creating temporary directory'
mkdir $TMP_DIR

echo 'Starting download'
wget \
  --content-disposition https://dl.pstmn.io/download/latest/linux64 \
  -O $TMP_DIR/latest.tar.gz

cd $TMP_DIR
echo 'Extracting files'
tar -zxf $TMP_DIR/latest.tar.gz


if [ ! -d $INSTALL_DIR ]; then
  echo 'Creating installation directory'
  mkdir $INSTALL_DIR
else
  # @TODO backup previous installation or at least prompt the user.
  echo 'Cleaning up old version of Postman'
  rm -rf $INSTALL_DIR/Postman
fi

echo 'Copying files'
cp -R $TMP_DIR/Postman $INSTALL_DIR/Postman

echo 'Creating symlink'
ln -sf $INSTALL_DIR/Postman/Postman $BIN_DIR/postman
