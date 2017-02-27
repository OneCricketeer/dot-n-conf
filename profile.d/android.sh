
ROOTDIR=$CASKROOM_HOME
if [ -z ${ROOTDIR-x} ]; then 
    ROOTDIR=/opt 
    echo "Profile error: ROOTDIR not defined. Setting to $ROOTDIR"
fi

export ANDROID_HOME=$ROOTDIR/android-sdk
# export ANDROID_NDK_HOME=/usr/local/opt/android-ndk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
ANDROID_VERSION=`ls $ANDROID_HOME/build-tools | sort | tail -1`
