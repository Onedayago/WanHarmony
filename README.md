<img width="400" height="800" alt="Screenshot_2025-09-25T144609" src="https://github.com/user-attachments/assets/b6496227-7da0-4d50-b366-8e6e614bd0f4" />
<img width="400" height="800" alt="Screenshot_2025-09-25T144624" src="https://github.com/user-attachments/assets/b766789f-6e72-450a-aac8-d7dd06aa2d6f" />


# WanAndroid HarmonyOS 客户端

## 项目简介

本项目是基于 HarmonyOS 的 WanAndroid 客户端，采用 ArkTS 语言开发。实现了首页、广场、公众号、登录等主要功能模块，适配手机设备，体验流畅。

## 主要功能

- 首页 Banner 轮播与文章列表
- 广场文章浏览
- 公众号 Tab 切换与文章展示
- 用户登录与状态管理
- 下拉刷新与分页加载
- 本地数据持久化（如 Cookie、登录信息）

## 技术栈

- ArkTS（.ets）
- HarmonyOS Stage Model
- @ohos/axios 网络请求
- 响应式数据绑定
- 组件化开发

## 项目结构

```
WanAndroid/
├── entry/
│   ├── src/
│   │   ├── main/
│   │   │   ├── ets/           # ArkTS 业务代码
│   │   │   │   ├── pages/     # 页面组件
│   │   │   │   ├── store/     # 数据管理
│   │   │   │   ├── service/   # 网络服务
│   │   │   │   ├── util/      # 工具类
│   │   │   │   ├── components/# 通用组件
│   │   │   ├── resources/     # 图片、字符串、颜色等资源
│   │   │   ├── module.json5   # 权限与模块配置
│   │   │   ├── profile/       # 路由与页面配置
```

## 快速开始

1. **环境准备**  
   安装 HarmonyOS DevEco Studio，配置开发环境。

2. **项目导入**  
   打开 DevEco Studio，选择本项目目录导入。

3. **运行项目**  
   连接 HarmonyOS 设备或模拟器，点击运行即可体验。

## 说明

- 网络接口基于 [WanAndroid API](https://www.wanandroid.com/blog/show/2)。
