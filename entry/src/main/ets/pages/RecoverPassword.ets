import { uiTermsStyle } from "../components/components";
import { Header } from "../components/components";
import { buttonStyle } from "../components/components";
import { welcome } from "../components/components";
import { freePassLogin } from "../components/components";

@Styles
// 背部统一卡片样式
function card() {
  .margin({ left: 10, right: 10 })
  .backgroundColor(Color.White)
  .borderRadius(15)
}

@Entry
@Component
struct findPassword {

  @State seconds: number = 0;  // 初始化

  build() {
    Column({ space: 10 }) {
      Header();
      welcome("找回密码", "请输入新密码并验证手机号");
      Column({ space: 10 }) {
        Tabs() {
          TabContent() {
            // 内容部分
            Column({ space: 15 }) {
              Row() {
                Text('手机号：').fontSize(16).fontWeight(FontWeight.Bold)
              }.width('100%')

              TextInput({ placeholder: "请输入手机号" })
                .margin({ top: 10 })
                .padding(10);

              Row() {
                Text('验证码：').fontSize(16).fontWeight(FontWeight.Bold)
              }.width('100%')

              Row() {
                // 堆叠布局，验证码输入框和按钮
                Stack() {
                  TextInput({ placeholder: "请输入接收到的验证码" })
                    .margin({ top: 10 })
                    .padding(10);

                  Button() {
                    Text(this.seconds > 0 ? `${this.seconds}秒|后重新获取` : '获取验证码')
                      .fontColor(this.seconds > 0 ? "#4c74fc":"#121212")
                      .fontSize(16);
                  }
                  .type(ButtonType.Normal)
                  .fontColor('#72767a')
                  .backgroundColor(Color.White)
                  .position({ x: 208, y: 22 }) // 调整按钮位置
                  .onClick(() => this.startCountdown());
                }
              }

              Row() {
                Text('密码：').fontSize(16).fontWeight(FontWeight.Bold)
              }.width('100%')

              TextInput({ placeholder: '请输入密码(6-20个数字和字母)' })
                .margin({ top: 10 })
                .padding(10)
                .type(InputType.Password);


              Column() {
                buttonStyle("确定")
              }.margin({ top: 20 });

              // 服务条款与隐私政策
              uiTermsStyle();
            }
            .padding({ bottom: 200 })
          }.tabBar('账号登录')

          // 免密登录
          freePassLogin()
        }
        .card()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#ecc4f4")
  }

  // 获取验证码按钮点击事件
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
