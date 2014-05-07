# Android修改host

1.启动虚拟手机并更改分区大小为128M
./emulator -avd AVD_for_Nexus_S_by_Google -partition-size 128

2. 新打开一个终端在当前目录下执行
./adb remount 重新挂载
./adb push /Users/huhongda/code/Android/AndroidHost/hosts /system/etc 写入host文件到android

3. 不需要重启模拟器

4.调试
./adb shell


注：可能apk中有缓存，所以有些页面访问了一次，便不会有第二次请求
