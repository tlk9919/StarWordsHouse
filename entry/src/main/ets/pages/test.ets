import { httpRequest } from '../components/utils/httpRequest.ts';  // 引入 HTTP 请求工具

@Entry
@Component
struct Register {
  @State mobileNumber: string = '';  // 手机号（或邮箱）
  @State newPassword: string = '';   // 新密码
  @State confirmPassword: string = ''; // 确认新密码
  @State code: string = '';          // 用户输入的验证码
  @State isCodeSent: boolean = false;  // 是否已发送验证码
  @State countdown: number = 60;       // 验证码倒计时
  @State isCodeVerified: boolean = false;  // 验证码是否验证成功

  // 发送验证码按钮点击事件
  async handleSendVerificationCode() {
    try {
      const response = await httpRequest('POST', '/send-verification-code', {
        email: this.mobileNumber  // 假设是邮箱
      });

      console.log('验证码发送响应:', response);
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
      console.error('请求错误:', e);
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
      console.log('发送的数据:', { email: this.mobileNumber, code: this.code });

      const response = await httpRequest('POST', '/verify-code', {
        email: this.mobileNumber,
        code: this.code  // 修改为 code
      });

      console.log('验证码验证响应:', response);

      if (response.message === '验证码验证成功') {
        this.isCodeVerified = true;  // 更新状态，验证码验证成功
        return true;
      } else {
        this.isCodeVerified = false;
        AlertDialog.show({
          title: '验证失败',
          message: response.message || '验证码错误，请重新输入。',
          autoCancel: true
        });
        return false;
      }
    } catch (e) {
      console.error('验证请求失败:', e);
      this.isCodeVerified = false;
      AlertDialog.show({
        title: '请求失败',
        message: '验证失败，请稍后再试。',
        autoCancel: true
      });
      return false;
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
      this.isCodeSent = false;
    }
  }

  // 修改密码按钮点击事件
  async handleChangePassword() {
    // 校验新密码和确认密码是否一致
    if (this.newPassword !== this.confirmPassword) {
      AlertDialog.show({
        title: '密码错误',
        message: '新密码和确认密码不一致，请重新输入。',
        autoCancel: true
      });
      return;
    }

    // 校验密码格式
    if (this.newPassword.length < 6 || this.newPassword.length > 20) {
      AlertDialog.show({
        title: '密码长度错误',
        message: '新密码必须为6到20个字符。',
        autoCancel: true
      });
      return;
    }

    // 先验证验证码
    const isCodeVerified = await this.validateVerificationCode();
    if (!isCodeVerified) {
      return;  // 如果验证码验证失败，则不继续执行修改密码
    }

    // 发送修改密码请求
    try {
      console.log('修改密码请求的数据:', { email: this.mobileNumber, newPassword: this.newPassword, code: this.code });

      const response = await httpRequest('POST', '/change-password-with-code', {
        email: this.mobileNumber,
        newPassword: this.newPassword,  // 新密码
        code: this.code  // 验证码
      });

      console.log('修改密码响应:', response);

      if (response.message === '密码修改成功') {
        AlertDialog.show({
          title: '修改成功',
          message: '您的密码已成功修改，请使用新密码登录。',
          autoCancel: true
        });
      } else {
        AlertDialog.show({
          title: '修改失败',
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

  // 注册按钮点击事件
  async handleRegister() {
    const isCodeVerified = await this.validateVerificationCode();
    if (!isCodeVerified) {
      return;
    }

    try {
      console.log('注册请求的数据:', { username: this.mobileNumber, newPassword: this.newPassword, code: this.code });

      const response = await httpRequest('POST', '/register', {
        username: this.mobileNumber,
        password: this.newPassword,
        code: this.code
      });

      console.log('注册响应:', response);

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

  build() {
    Column({ space: 10 }) {
      Row() {
        Text('账号（邮箱）：').fontSize(16).fontWeight(FontWeight.Bold)
      }.width('100%').margin({ top: 30 })

      TextInput({ placeholder: '请输入邮箱' })
        .padding(20)
        .onChange(value => {
          this.mobileNumber = value;
        })

      Row() {
        Text('新密码：').fontSize(16).fontWeight(FontWeight.Bold)
      }.width('100%')

      TextInput({ placeholder: '请输入新密码(6-20个数字和字母)' })
        .padding(20)
        .type(InputType.Password)
        .onChange(value => {
          this.newPassword = value;
        })

      Row() {
        Text('确认密码：').fontSize(16).fontWeight(FontWeight.Bold)
      }.width('100%')

      TextInput({ placeholder: '请再次输入新密码' })
        .padding(20)
        .type(InputType.Password)
        .onChange(value => {
          this.confirmPassword = value;
        })

      Row() {
        Text('验证码：').fontSize(16).fontWeight(FontWeight.Bold)
      }.width('100%')

      Row({ space: 10 }) {
        TextInput({ placeholder: '请输入验证码' })
          .width('70%')
          .padding(20)
          .onChange(value => {
            this.code = value;
          })

        Button('发送验证码')
          .borderRadius(10)
          .backgroundColor("#ecc4f4")
          .type(ButtonType.Normal)
          .fontSize(14)
          .width(80)
          .height(50)
          .onClick(() => this.handleSendVerificationCode())
      }

      Button('修改密码')
        .borderRadius(10)
        .backgroundColor("#ecc4f4")
        .type(ButtonType.Normal)
        .fontSize(20)
        .width(320)
        .height(60)
        .onClick(() => this.handleChangePassword())
    }
    .padding({ top: 50, left: 20, right: 20 })
  }
}
