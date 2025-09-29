# Makefile for Flutter project

# 项目变量
APP_NAME := my_flutter_app
BUILD_DIR := build
FLUTTER := flutter

# 默认目标
.DEFAULT_GOAL := help

# 运行在 Android 模拟器 / 真机
run:
	@$(FLUTTER) run

# 清理构建
clean:
	@$(FLUTTER) clean
	@rm -rf $(BUILD_DIR)
    @$(FLUTTER) pub get
# 获取依赖
init:
	@$(FLUTTER) pub get

# 构建 Android Debug APK
debug:
	@$(FLUTTER) build apk --debug

# 分包构建 Android Release APK
release:
	@$(FLUTTER) build apk --release --target-platform android-arm64,android-arm --split-per-abi

# 构建 Android AppBundle（发布用）
appbundle:
	$(FLUTTER) build appbundle --release

# 构建 iOS Debug
ios-debug:
	$(FLUTTER) build ios --debug

# 构建 iOS Release
ios-release:
	$(FLUTTER) build ios --release

# 格式化代码
format:
	$(FLUTTER) format .

# 分析代码
analyze:
	$(FLUTTER) analyze

# 显示帮助
help:
	@echo "可用命令："
	@echo "  make run          运行应用"
	@echo "  make hot-restart  热重启"
	@echo "  make clean        清理构建"
	@echo "  make deps         获取依赖"
	@echo "  make apk-debug    构建 Android Debug APK"
	@echo "  make apk-release  构建 Android Release APK"
	@echo "  make appbundle    构建 Android AppBundle"
	@echo "  make ios-debug    构建 iOS Debug"
	@echo "  make ios-release  构建 iOS Release"
	@echo "  make format       格式化代码"
	@echo "  make analyze      分析代码"
