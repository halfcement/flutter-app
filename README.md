# normal_template
flutter通用项目基础模板代码
### flutter sdk version: 3.35.4(stable)
### dart version: 3.9.2
### devtools version: 2.48.0
### gradle version: 8.12-all
## 目录结构
- lib/：主要 Dart 代码
    - apis/：接口相关代码
        - api_path.dart: 接口地址管理
        - api_response.dart：封装的接口返回对象
        - xxx_apis.dart: 对应模块的请求
    - common_components/：公共组件
    - common_controller/：不依赖页面的状态管理
    - config/：配置项
        - dio_config/：dio配置
            - cache_interceptor.dart：缓存拦截器
            - http_method.dart：http请求方法
            - get_body_interceptor.dart：请求体拦截器
            - dio_pool_manager.dart：请求池管理
        - translations.dart：国际化配置
    - models/：数据模型
    - screens/：页面
        - landing_screens/：落地页
        - auth_screens/：用户认证相关页面
    - utils/：工具函数
    - main.dart：入口文件
- assets/`：资源文件
    - images/：图片资源
    - icons/：图标资源  
## 功能
### 基础页面
### 状态管理 get
### dio请求池 请求拦截器 401重新认证机制
### 国际化 多语言
### toast和dialog
### 工具类
### 用户登录
### 图形验证码 gocaptcha适配滑动验证
### 红点系统(未读消息气泡)
### api接口管理 地址管理
## 注意事项:
android和ios需要更新自己的applicationId和bundleId
### 一键切换:
```dart run change_app_package_name:main com.new.package.name```
### 只切换android平台的
```dart run change_app_package_name:main com.new.package.name --android```
### 只切换ios平台的
```dart run change_app_package_name:main com.new.package.name --ios```
### 切分平台
```flutter build apk --target-platform android-arm64,android-arm --split-per-abi```
