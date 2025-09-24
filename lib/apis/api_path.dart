
/*
*接口路径和白名单
 */
class ApiPath {
  //单例
  static final ApiPath _instance = ApiPath._internal();
  factory ApiPath() => _instance;
  ApiPath._internal();

  //base url
  static String baseUrl = "http://192.168.124.103:11151";

  //手机密码登录路径
  static String loginByPhonePwdPath = "/app/v1/login/phone/password";

  //手机密码登录路径
  static String loginByPhoneCodePath = "/app/v1/login/phone/sms";

  //邮箱密码登录路径
  static String loginByEmailPwdPath = "/app/v1/login/email/password";

  //邮箱密码登录路径
  static String loginByEmailCodePath = "/app/v1/login/email/code";

  //刷新token
  static String refreshTokenPath = "/app/v1/user/refresh/token";

  //app配置路径
  static String appConfigPath = "/app/v1/config";

  //图形验证码路径
  static String appCaptchaPath = "/app/v1/captcha/image";

  //图形验证码校验路径
  static String captchaCheckPath = "/app/v1/captcha/image/check";

  //白名单,不需要token认证的接口
  static final List<String> noAuthList = [
    loginByPhonePwdPath,
    refreshTokenPath,
    appCaptchaPath,
    captchaCheckPath,
    appConfigPath,
  ];
}