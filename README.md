# WanAndroid
* 一款使用[`Flutter`](https://github.com/flutter/flutter)编写的，[`Material Design`](https://flutter.io/widgets/material/)风格的[`WanAndroid`](http://wanandroid.com/)客户端，
* `WanAndroid`官网：[wanandroid.com](http://wanandroid.com/)
* `Api`:[`WanAndroid`开放`API`](http://wanandroid.com/blog/show/2)

### Download
* `Android`: [APK 下载](https://github.com/hurshi/wanandroid/releases)
* `iOS`: 不上AppStore要安装到设备比较麻烦，有需要的就自己编译使用吧。(我自己就是在iOS设备上使用的)
* 严重推荐使用`Release`版，要比`Debug`版流畅甚多

### Build
* `Android`:[@ Flutter Android Release Page](https://flutter.io/android-release/)
	
	```
	cd wanandroid/
	flutter build apk
	adb install build/app/outputs/apk/release/app-release.apk
	```
* `iOS`:[@ Flutter iOS Release Page](https://flutter.io/ios-release/)
		
	```
	cd wanandroid/
	flutter build ios
	In Xcode, open Runner.xcworkspace in wanandroid/ios folder.
	run...
	```
* `Font`:`App`中自定义了字体[NotoSansCJKsc](https://www.google.com/get/noto/)，导致软件增大了15M,若在意的话可以直接移除。


### ScreenShots
![](sources/imgs/Screenshot_blog.png) |![](sources/imgs/Screenshot_blog_top.png) | ![](sources/imgs/Screenshot_search.png) 
:-------------------------:|:-------------------------:|:-------------------------:
![](sources/imgs/Screenshot_project.png)  |  ![](sources/imgs/Screenshot_wechat.png) |  ![](sources/imgs/Screenshot_wechat_search.png)
![](sources/imgs/Screenshot_system.png)  |  ![](sources/imgs/Screenshot_mine.png) |  ![](sources/imgs/Screenshot_login.png)


### Thanks
* All the dependent libraries [pubspec.ymal](pubspec.yaml)
* Thanks to [WanAndroid](http://wanandroid.com/)
* Thanks for sara's [icon](sources/icon.ai) and [iconfont.cn](http://www.iconfont.cn/)
* Thanks to [NotoSansCJKsc by Google](https://www.google.com/get/noto/)


### License

   ```
   Copyright 2018 Hurshi

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   ```
