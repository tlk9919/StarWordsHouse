import { httpRequest } from '../components/utils/httpRequest.ts';  // 引入 HTTP 请求工具

@Entry
@Component
struct Register {
  @State mobileNumber: string = '';  // 手机号
  @State password: string = '';      // 密码

  // 注册按钮点击事件
  async handleRegister() {
    try {
      const response = await httpRequest('POST', '/register', {
        username: this.mobileNumber,
        password: this.password
      });

      if (response.message === '注册成功') {
        AlertDialog.show({
          title: '注册成功',
          message: '可以使用注册的账号进行登录',
          autoCancel: true
        });
      } else {
        AlertDialog.show({
          title: '注册失败',
          message: response.message,
          autoCancel: true
        });
      }
    } catch (e) {
      AlertDialog.show({
        title: '请求失败',
        message: '服务器错误，请稍后再试',
        autoCancel: true
      });
    }
  }

  // 登录按钮点击事件
  async handleLogin() {
    try {
      const response = await httpRequest('POST', '/login', {
        username: this.mobileNumber,
        password: this.password
      });

      if (response.message === '登录成功') {
        AlertDialog.show({
          title: '登录成功',
          message: '欢迎 ' + this.mobileNumber,
          autoCancel: true
        });
        // 可以将返回的 token 存储在本地并进行页面跳转等操作
      } else {
        AlertDialog.show({
          title: '登录失败',
          message: response.message,
          autoCancel: true
        });
      }
    } catch (e) {
      AlertDialog.show({
        title: '请求失败',
        message: '服务器错误，请稍后再试',
        autoCancel: true
      });
    }
  }

  build() {
    Column({ space: 10 }) {
      // 用户名输入框
      Row() {
        Text('账号：').fontSize(16).fontWeight(FontWeight.Bold)
      }.width('100%').margin({ top: 30 })

      TextInput({ placeholder: '请输入用户名/邮箱/账号' })
        .padding(20)
        .onChange(value => {
          this.mobileNumber = value;
        })

      // 密码输入框
      Row() {
        Text('密码：').fontSize(16).fontWeight(FontWeight.Bold)
      }.width('100%')

      TextInput({ placeholder: '请输入密码(6-20个数字和字母)' })
        .padding(20)
        .type(InputType.Password)
        .onChange(value => {
          this.password = value;
        })

      // 注册按钮
      Button('注册')
        .borderRadius(10)
        .backgroundColor("#ecc4f4")
        .type(ButtonType.Normal)
        .fontSize(20)
        .width(320)
        .height(60)
        .onClick(() => this.handleRegister())  // 调用注册处理函数

      // 登录按钮
      Button('登录')
        .borderRadius(10)
        .backgroundColor("#ecc4f4")
        .type(ButtonType.Normal)
        .fontSize(20)
        .width(320)
        .height(60)
        .onClick(() => this.handleLogin())  // 调用登录处理函数
    }
    .padding({ top: 50, left: 20, right: 20 })
  }
}
