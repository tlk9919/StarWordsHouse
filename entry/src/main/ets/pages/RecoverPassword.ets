import {uiTermsStyle} from "../components/components"
import {Header} from "../components/components"
import {buttonStyle} from "../components/components"
import {forgetPassword} from "../components/components"
import {welcome} from "../components/components"
import {freePassLogin} from "../components/components"
@Styles
//背部统一卡片样式
function card() {
  .margin({ left: 10, right: 10 })
  .backgroundColor(Color.White)
  .borderRadius(15)
}
@Entry
@Component
struct  findPassword {
  build() {
    Column({space:10}){
      Header()
      welcome("找回密码","请输入新密码并验证手机号")
      Column({space:10}){
        Tabs(){
          TabContent(){
            //内容
            Column({space:15}) {
              Row() {
                Text('手机号：').fontSize(16).fontWeight(FontWeight.Bold)
              }.width('100%')

              TextInput({ placeholder: "请输入手机号" })
                .margin({ top: 10 })
                .padding(10)
              Row() {
                Text('验证码：').fontSize(16).fontWeight(FontWeight.Bold)
              }.width('100%')

              Row(){
                Stack({alignContent:Alignment.End}){
                  TextInput({ placeholder: "请输入接收到的验证码" })
                    .margin({ top: 10 })
                    .padding(10)
                  Button('获取验证码')
                    .type(ButtonType.Normal)
                    .fontColor('#72767a')
                    .backgroundColor(Color.White)
                }

              }
              Row() {
                Text('密码：').fontSize(16).fontWeight(FontWeight.Bold)
              }.width('100%')

              TextInput({ placeholder: '请输入密码(6-20个数字和字母)' })
                .margin({ top: 10 })
                .padding(10)
                .type(InputType.Password)
              // 手机号登录与忘记密码
              forgetPassword()
              // 登录按钮
              Column() {
                buttonStyle("确定")
              }.margin({ top: 20 })

              // 服务条款与隐私政策
              uiTermsStyle()
            }
            .padding({bottom:200})
          }.tabBar('账号登录')

          //免密登录
          freePassLogin()


        }
        .card()

      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#ecc4f4")

  }
}