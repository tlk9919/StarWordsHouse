import {uiTermsStyle,buttonStyle,forgetPassword} from "../../components/components"
import { httpRequest } from '../../utils/HttpUtils/httpRequest';  // 引入 HTTP 请求工具
import { router } from '@kit.ArkUI'
import loginService from "../../Service/LoginService";

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
 export struct  LoginTab {
  @State tellnumber:string='188****8888'
  @State mobileNumber:string='991988677@qq.com'//手机号
  @State password:string='991988677abcde'//密码
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
              .onChange(value=>{
                this.mobileNumber=value
              })
            Row() {
              Text('密码：').fontSize(16).fontWeight(FontWeight.Bold)
            }.width('100%')

            TextInput({ placeholder: '请输入密码(6-20个数字和字母)' })
              .padding(20)
              .type(InputType.Password)
              .onChange(value=>{
                this.password=value
              })
            Column(){
              // 手机号登录与忘记密码
              forgetPassword()
              // 登录按钮
              Column() {
                Button('登录')
                  .borderRadius(10)
                  .backgroundColor("#ecc4f4")
                  .type(ButtonType.Normal)
                  .fontSize(20)
                  .width(320)
                  .height(60)
                  .onClick(() => {
                    console.log('testTag','手机号:', this.mobileNumber,'密码',this.password)
                    //调用服务处登录函数
                    loginService.handleLogin(this.mobileNumber,this.password)
                  });
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
