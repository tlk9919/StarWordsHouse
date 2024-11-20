import {uiTermsStyle} from "../components/components"
import {Header} from "../components/components"
import {buttonStyle} from "../components/components"
import {forgetPassword} from "../components/components"
import {welcome} from "../components/components"
import {freePassLogin} from "../components/components"
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
//导航栏及其内容
@Component
struct  tab {
  @State tellnumber:string='188****8888'
  build() {
    Column() {
      //导航
      Tabs() {
        // 账号密码 Tab 内容
        TabContent() {
          Column({ space: 25 }) {
            Row() {
              Text('账号：').fontSize(16).fontWeight(FontWeight.Bold)
            }.width('100%').margin({top:30})
            TextInput({ placeholder: '请输入用户名/邮箱/账号' })
              .padding(20)
            Row() {
              Text('密码：').fontSize(16).fontWeight(FontWeight.Bold)
            }.width('100%')

            TextInput({ placeholder: '请输入密码(6-20个数字和字母)' })
              .padding(20)
              .type(InputType.Password)
            Column(){
              // 手机号登录与忘记密码
              forgetPassword()
              // 登录按钮
              Column() {
                buttonStyle("登录")
              }
              .margin(20)
            }

            // 服务条款与隐私政策
            uiTermsStyle()
          }
          .padding({bottom:200})
        }
        .tabBar('账号密码')

        // 免密登录
        // freePassLogin()//真机上无法调用
        TabContent() {
          // 内容
          Column(){
            Text(this.tellnumber)
              .fontSize(40)
            Column() {
              buttonStyle("手机号一键登录")
            }
            .margin({ top: 40 })
            uiTermsStyle()
          }

        }.tabBar('免密登录')
      }
    }
    .card()
  }
}

@Entry
@Component
struct Register {

  build() {
    Column({ space: 10 }) {
      // 返回键位
      Header()
      // 注册标题
      welcome("欢迎注册","未注册的手机号将自动创建账号")
      //导航栏
      tab()

    }
    .width('100%')
    .height('100%')
    .backgroundColor("#ecc4f4")

  }


}
