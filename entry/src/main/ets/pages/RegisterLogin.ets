import {uiTermsStyle} from "../components/components"
import {Header} from "../components/components"
import {buttonStyle} from "../components/components"
import {forgetPassword} from "../components/components"
import {welcome} from "../components/components"
import {freePassLogin} from "../components/components"
import { isEmpty, isPhone } from '../components/utils/isEmptyUtils'

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
  @State mobileNumber:string=''//手机号
  @State password:string=''//密码
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
                    console.log('testTag','手机号:', this.mobileNumber,'密码',this.password);
                    if (isEmpty(this.mobileNumber)) {
                      //提示
                      AlertDialog.show({
                        //点击其他
                        autoCancel:true,
                        title:'温馨提示',
                        message:'请输入手机号'
                      })
                      return
                    }
                    //验证手机号格式
                    if(!isPhone(this.mobileNumber)){
                      AlertDialog.show({
                        //点击其他
                        autoCancel:true,
                        title:'温馨提示',
                        message:'请输入正确的手机号'
                      })
                    }
                    //密码验证
                    if(!isPhone(this.password)){
                      AlertDialog.show({
                        //点击其他
                        autoCancel:true,
                        title:'温馨提示',
                        message:'请输入密码'
                      })
                    }
                    if(!isPhone(this.password)){
                      AlertDialog.show({
                        //点击其他
                        autoCancel:true,
                        title:'温馨提示',
                        message:'请输入符合格式的密码'
                      })
                    }
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
