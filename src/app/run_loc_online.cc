//
// Created by xiang on 25-3-18.
//

#include <gflags/gflags.h> // 命令行参数解析库
#include <glog/logging.h>  // Google 日志库

#include "core/system/loc_system.h"
#include "ui/pangolin_window.h"  // UI 显示窗口
#include "wrapper/ros_utils.h"   // ROS 工具封装

DEFINE_string(config, "./config/default.yaml", "配置文件");

/// 运行定位的测试
int main(int argc, char** argv) {
    google::InitGoogleLogging(argv[0]);   // 初始化日志系统
    FLAGS_colorlogtostderr = true;        // 启用彩色日志输出
    FLAGS_stderrthreshold = google::INFO; // 设置日志级别为 INFO

    google::ParseCommandLineFlags(&argc, &argv, true);  // 解析命令行参数
    using namespace lightning;

    rclcpp::init(argc, argv);  // 初始化 ROS2 节点系统

    LocSystem::Options opt;    // 创建定位系统选项
    LocSystem loc(opt);        // 创建定位系统实例

    // 1. 程序入口
    if (!loc.Init(FLAGS_config)) {
        LOG(ERROR) << "failed to init loc";
    }

    /// 默认起点开始定位
    loc.SetInitPose(SE3());
    loc.Spin();

    rclcpp::shutdown();

    return 0;
}