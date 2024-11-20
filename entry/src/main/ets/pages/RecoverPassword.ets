import { buttonStyle, Header, uiTermsStyle } from '../components/components';
import { welcome } from "../components/components";
@Styles
//背部统一卡片样式
function card() {
  .width("95%")
  .height("75%")
  .borderRadius(15)
  .backgroundColor(Color.White)
  .shadow({
    radius:10,
    color:'#ececec',
    offsetX:5,
    offsetY:5
  })
}
@Entry
@Component
struct ForgetPassword {

  @State tellnumber:string='188****8888'
  @State seconds: number = 0;  // 初始化
  build() {
    Column({ space: 10 }){
      Header();
      welcome("找回密码", "请输入新密码并验证手机号");
      //登录详细框
      Column(){
        Tabs(){
          TabContent(){
            //具体内容
            Column({space:30}){
              Row(){
                Text('手机号：')
                  .fontSize(16).fontWeight(FontWeight.Bold)
              }
              .width('95%')
              .justifyContent(FlexAlign.Start)
              TextInput({ placeholder: "请输入手机号" })
                .padding(20)
                .type(InputType.Number)
                .caretColor('#ecc4f4') //光标颜色
              Row(){
                Text('密码：').fontSize(16)
                  .fontWeight(FontWeight.Bold)
              }
              .width('95%')
              .justifyContent(FlexAlign.Start)
              TextInput({ placeholder: '请输入密码(6-20个数字和字母)' })
                .padding(20)
                .type(InputType.Password)
                .caretColor('#ecc4f4') //光标颜色
              Row(){
                Text('验证码：')
                  .fontSize(16).fontWeight(FontWeight.Bold)
              }
              .width('95%')
              .justifyContent(FlexAlign.Start)
              //堆叠布局验证码和输入框
              Stack(){
                TextInput({ placeholder: "请输入接收到的验证码" })
                  .padding(20)
                  .type(InputType.Number);
                Button() {
                  Text(this.seconds > 0 ? `${this.seconds}秒|后重新获取` : '获取验证码')
                    .fontColor(this.seconds > 0 ? "#4c74fc":"#121212")
                    .fontSize(16);
                }
                .type(ButtonType.Normal)
                .backgroundColor('rgba(0, 0, 0, 0)')//透明颜色
                .margin({left:200})
                .onClick(() => this.startCountdown());
              }

              //确定按钮
              buttonStyle("确定")
              // 服务条款与隐私政策
              uiTermsStyle();
            }
          }.tabBar('账号登录')
          // 免密登录
          // freePassLogin()//真机上无法调用
          TabContent() {
            // 内容
            Column(){
              Text(this.tellnumber)
                .fontSize(40)
              Column() {
                buttonStyle("手机号一键登录")
              }.margin({ top: 40 })
              uiTermsStyle()
            }

          }.tabBar('免密登录')
        }
      }
      .card()
    }
    .backgroundColor("#ecc4f4")
    .width('100%')
    .height('100%')
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
