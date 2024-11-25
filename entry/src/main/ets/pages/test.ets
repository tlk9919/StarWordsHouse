import { httpRequest } from '../components/utils/httpRequest.ts';  // 引入 HTTP 请求工具

@Entry
@Component
struct Register {
  @State mobileNumber: string = '';  // 手机号（或邮箱）
  @State password: string = '';      // 密码
  @State code: string = ''; // 用户输入的验证码
  @State isCodeSent: boolean = false;  // 是否已发送验证码
  @State countdown: number = 60;       // 验证码倒计时
  @State isCodeVerified: boolean = false;  // 验证码是否验证成功

  // 发送验证码按钮点击事件
  async handleSendVerificationCode() {
    try {
      const response = await httpRequest('POST', '/send-verification-code', {
        email: this.mobileNumber  // 假设是邮箱
      });

      // 打印真实响应数据
      console.log('验证码发送响应:', response);  // 打印服务器响应数据
      if (response.message === '验证码发送成功') {
        AlertDialog.show({
          title: '验证码已发送',
          message: '请检查您的邮箱获取验证码',
          autoCancel: true
        });
        this.isCodeSent = true;
        this.startCountdown();
      } else {
        AlertDialog.show({
          title: '发送失败',
          message: response.message,
          autoCancel: true
        });
      }

    } catch (e) {
      console.error('请求错误:', e);  // 打印错误信息
      AlertDialog.show({
        title: '请求失败',
        message: '服务器错误，请稍后再试',
        autoCancel: true
      });
    }
  }

  // 验证验证码的接口
  async validateVerificationCode() {
    try {
      // 打印发送的数据（真实的邮箱和验证码）
      console.log('发送的数据:', { email: this.mobileNumber, code: this.code });  // 打印邮箱和验证码

      const response = await httpRequest('POST', '/verify-code', {
        email: this.mobileNumber,  // 或者是手机号
        code: this.code  // 修改为 code
      });

      // 打印真实的验证码验证响应
      console.log('验证码验证响应:', response); // 打印服务器返回的响应

      if (response.message === '验证码验证成功') {
        this.isCodeVerified = true;  // 更新状态，验证码验证成功
        return true;  // 验证成功返回 true
      } else {
        this.isCodeVerified = false;  // 如果验证失败，保持为 false
        AlertDialog.show({
          title: '验证失败',
          message: response.message || '验证码错误，请重新输入。',
          autoCancel: true
        });
        return false;  // 验证失败返回 false
      }
    } catch (e) {
      console.error('验证请求失败:', e); // 打印捕获的错误信息
      this.isCodeVerified = false;
      AlertDialog.show({
        title: '请求失败',
        message: '验证失败，请稍后再试。',
        autoCancel: true
      });
      return false;  // 验证失败返回 false
    }
  }

  // 倒计时功能
  startCountdown() {
    if (this.countdown > 0) {
      setTimeout(() => {
        this.countdown -= 1;
        this.startCountdown();
      }, 1000);
    } else {
      this.isCodeSent = false;  // 倒计时结束，恢复发送验证码的状态
    }
  }

  // 注册按钮点击事件
  async handleRegister() {
    // 先验证验证码
    const isCodeVerified = await this.validateVerificationCode();
    if (!isCodeVerified) {
      return;  // 如果验证码验证失败，则不继续执行注册
    }

    try {
      // 打印注册时的数据（真实的用户名、密码和验证码）
      console.log('注册请求的数据:', { username: this.mobileNumber, password: this.password, code: this.code });

      const response = await httpRequest('POST', '/register', {
        username: this.mobileNumber,
        password: this.password,
        code: this.code  // 提交验证码，改为 code
      });

      // 打印注册响应
      console.log('注册响应:', response);  // 打印服务器返回的响应

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

      // 打印登录响应数据
      console.log('登录响应:', response);  // 打印服务器响应数据

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
      // 用户名/邮箱输入框
      Row() {
        Text('账号（邮箱）：').fontSize(16).fontWeight(FontWeight.Bold)
      }.width('100%').margin({ top: 30 })

      TextInput({ placeholder: '请输入邮箱' })
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

      // 验证码输入框
      Row() {
        Text('验证码：').fontSize(16).fontWeight(FontWeight.Bold)
      }.width('100%')

      Row({ space: 10 }) {
        TextInput({ placeholder: '请输入验证码' })
          .width('70%')
          .padding(20)
          .onChange(value => {
            this.code = value;  // 修改为 code
          })

        Button('发送验证码')
          .borderRadius(10)
          .backgroundColor("#ecc4f4")
          .type(ButtonType.Normal)
          .fontSize(14)
          .width(80)
          .height(50)
          .onClick(() => this.handleSendVerificationCode())  // 调用发送验证码处理函数
      }

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
