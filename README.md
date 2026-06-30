# UE5 第一人称多人射击 Demo

基于 Unreal Engine 5 官方 First Person 模板开发的课程作业。

## 作业要求完成情况

- AI 敌人：敌人可移动、搜索并攻击玩家，玩家可使用武器击败敌人。
- 得分与胜利：包含游戏状态、得分及胜利流程相关蓝图。
- 多人对战：包含多人大厅、服务器列表和游戏地图。
- Android 安装包：提供 arm64 APK、OBB 数据包及安装脚本。
- 游戏演示视频：提供完整运行演示。

## 快速查看

- [游戏演示视频](./Video/GameplayDemo.mp4)
- [Android 安装包目录](./AndroidPackage)
- [UE5 工程文件](./UnrealProject/Project3.uproject)
- [C++ 源码](./UnrealProject/Source)
- [游戏资源](./UnrealProject/Content)

## 目录结构

```text
.
├─ UnrealProject/                 # UE5 工程代码与资源
│  ├─ Config/
│  ├─ Content/
│  ├─ Source/
│  ├─ Build/Android/src/
│  └─ Project3.uproject
├─ AndroidPackage/                # Android 安装文件
│  ├─ Project3-arm64.apk
│  ├─ main.1.com.YourCompany.Project3.obb
│  ├─ Install_Project3-arm64.bat
│  └─ Uninstall_Project3-arm64.bat
└─ Video/
   └─ GameplayDemo.mp4
```

## 打开 UE5 工程

1. 安装 Unreal Engine 5.7。
2. 安装项目所需的 C++/Visual Studio 工具链。
3. 打开 `UnrealProject/Project3.uproject`。
4. 首次打开时按提示重新编译项目模块。

## Android 安装说明

该 Android 构建使用外置 OBB 数据包，APK 与 OBB 必须配套使用。

1. 在 Android 设备中开启开发者模式和 USB 调试。
2. 在 Windows 上安装 Android Platform Tools，并确保 `adb` 可用。
3. 下载 `AndroidPackage` 目录中的全部文件。
4. 连接设备后运行 `Install_Project3-arm64.bat`。

## 仓库说明

大型 UE 资源、APK、OBB 和视频通过 Git LFS 管理。仓库已排除
`Binaries`、`Intermediate`、`Saved`、`DerivedDataCache` 等生成目录，
避免上传缓存、崩溃日志和重复构建产物。
