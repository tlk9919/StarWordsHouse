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
//导航栏及其内容
@Component
struct  tab {
  build() {
    Column({ space: 10 }) {
      //导航
      Tabs() {
        // 账号密码 Tab 内容
        TabContent() {
          Column({ space: 15 }) {
            Row() {
              Text('账号：').fontSize(16).fontWeight(FontWeight.Bold)
            }.width('100%')

            TextInput({ placeholder: '请输入用户名/邮箱/账号' })
              .margin({ top: 10 })
              .padding(10)


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
              buttonStyle("登录")
            }.margin({ top: 20 })

            // 服务条款与隐私政策
            uiTermsStyle()
          }
          .padding({bottom:200})
        }
        .tabBar('账号密码')

        // 免密登录 Tab 内容
        freePassLogin()
      }
    }
    .card()
  }
}

@Entry
@Component
struct Register {
  @State tellnumber:string='188****8888'
  build() {
    Column({ space: 10 }) {
      // 返回键位
      Header()
      // 注册标题
      welcome("欢迎注册","未注册的手机号将自动创建账号")

      tab()

    }
    .width('100%')
    .height('100%')
    .backgroundColor("#ecc4f4")

  }


}
