export ANDROID_HOME=/usr/local/opt/android-sdk
# export ANDROID_NDK_HOME=/usr/local/opt/android-ndk
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
ANDROID_VERSION=`ls $ANDROID_HOME/build-tools | sort | tail -1`
export PATH=$ANDROID_HOME/build-tools/$ANDROID_VERSION:$PATH
