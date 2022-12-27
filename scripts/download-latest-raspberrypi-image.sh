#!/bin/bash
DOWNLOAD_DIR="$(curl --silent 'https://downloads.raspberrypi.org/raspios_lite_arm64/images/?C=M;O=D' | grep --extended-regexp --only-matching 'raspios_lite_arm64-[0-9]{4}-[0-9]{2}-[0-9]{2}' | head -n 1)"
DOWNLOAD_ARCHIVE_FILE="$(curl --silent "https://downloads.raspberrypi.org/raspios_lite_arm64/images/${DOWNLOAD_DIR}/" | grep --extended-regexp --only-matching '[0-9]{4}-[0-9]{2}-[0-9]{2}-raspios-[a-z]+-arm64-lite.img.xz' | head -n 1)"
DOWNLOAD_FILENAME="${DOWNLOAD_ARCHIVE_FILE%%.*}"
IMAGE_FILE_NAME=`echo ${DOWNLOAD_ARCHIVE_FILE} | sed 's|\(.*\)\..*|\1|'`
echo "Identified the following variables:"
echo "DOWNLOAD_DIR = ${DOWNLOAD_DIR}"
echo "DOWNLOAD_ARCHIVE_FILE = ${DOWNLOAD_ARCHIVE_FILE}"
echo "DOWNLOAD_FILENAME = ${DOWNLOAD_FILENAME}"
echo "IMAGE_FILE_NAME = ${IMAGE_FILE_NAME}"
echo ""
echo "Download latest disk image archive to folder ${DOWNLOAD_DIR}/"
mkdir ${DOWNLOAD_DIR}
cd ${DOWNLOAD_DIR}
wget --continue --no-clobber -O ${DOWNLOAD_ARCHIVE_FILE} "https://downloads.raspberrypi.org/raspios_lite_arm64/images/${DOWNLOAD_DIR}/${DOWNLOAD_ARCHIVE_FILE}"
wget --continue --no-clobber -O ${DOWNLOAD_ARCHIVE_FILE}.sha256 "https://downloads.raspberrypi.org/raspios_lite_arm64/images/${DOWNLOAD_DIR}/${DOWNLOAD_ARCHIVE_FILE}.sha256"
echo ""
echo "Verify downloaded disk image archive"
sha256sum --check "${DOWNLOAD_ARCHIVE_FILE}.sha256"

echo ""
echo "Extracting archive"
if [ -f "$IMAGE_FILE_NAME" ]
then
    echo "Image $IMAGE_FILE_NAME is already existing. Nothing to extract."
else
   xz -ltd ${DOWNLOAD_ARCHIVE_FILE}
fi


cp $IMAGE_FILE_NAME /output/

# WC=`echo ${IMAGE_FILE_NAME} | wc -l` 
# if [ $WC -eq 0 ]
# then
#   echo Burning image $IMAGE_FILE_NAME
# fi

#cd $BASE_DIR
#WC=`ls | grep $VERSION | wc -l`
#if [ $WC -eq 0 ]
#then
 #echo Downloading $FILENAME
 #wget -O /tmp/piserver.tar.xz https://downloads.raspberrypi.org/raspios_lite_arm64/piserver.tar.xz
 #tar -xz /tmp/piserver.tar.xz
 #rm /tmp/raspbian-*.zip
#fi
