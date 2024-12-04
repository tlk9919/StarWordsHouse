import { httpRequest } from '../../utils/HttpUtils/httpRequest'; // 引入 HTTP 请求工具
import CodeService from '../../Service/CodeService';
import ResetPassService from '../../Service/ResetPassService'
import { welcome } from '../../components/components';
@Entry
@Component
struct ForgetPassword {
    @State mobileNumber: string = '991988677@qq.com';  // 手机号（或邮箱）
  @State newPassword: string = '991988677ab';   // 新密码
  @State confirmPassword: string = '991988677ab'; // 确认新密码
  @State code: string = '';          // 用户输入的验证码
  @State isCodeSent: boolean = false;  // 是否已发送验证码
  @State countdown: number = 60;       // 验证码倒计时
  @State isCodeVerified: boolean = false;  // 验证码是否验证成功
  @State seconds: number = 0;  // 初始化
  build() {
    Column({ space: 20 }) {
      welcome("找回密码", "通过手机号验证找回密码");
      Divider().color('#6c7474')
      Column({space:15}){
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
          //堆叠布局验证码和输入框
          Stack() {
            TextInput({ placeholder: "请输入接收到的验证码" })
              .padding(20)
              .type(InputType.Number)
              .onChange(value => {
                this.code = value;
              })
            Button() {
              Text(this.seconds > 0 ? `${this.seconds}秒|后重新获取` : '获取验证码')
                .fontColor(this.seconds > 0 ? "#4c74fc" : "#121212")
                .fontSize(16)
                .onClick(() => {
                  this.startCountdown()
                  //调用服务层的发送验证码
                  CodeService.handleSendVerificationCode(this.mobileNumber)
                })
            }.type(ButtonType.Normal).backgroundColor('rgba(0, 0, 0, 0)') //透明颜色
            .margin({ left: 200 })
            .onClick(() => this.startCountdown());
          }
        }
        Button('修改密码')
          .borderRadius(10)
          .backgroundColor("#ecc4f4")
          .type(ButtonType.Normal)
          .fontSize(20)
          .width(320)
          .height(60)
          .onClick(
            //调用服务层的修改密码
            () => ResetPassService.handleChangePassword(this.mobileNumber,this.newPassword,this.code,this.confirmPassword))
      }
    }
    .width('100%')
    .padding({ left: 20, right: 20 })
  }
  // 倒计时功能
  startCountdown() {
    if (this.seconds === 0) {
      this.seconds = 60; // 设置倒计时为60秒
      // 开始倒计时
      const timerInterval = setInterval(() => {
        this.seconds -= 1;
        // 清除定时器并恢复按钮
        if (this.seconds <= 0) {
          clearInterval(timerInterval);
          this.seconds = 0; // 重置倒计时
        }
      }, 1000);
    }
  }
}
