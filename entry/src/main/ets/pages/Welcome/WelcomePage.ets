import {PrivacyPolicyDialog} from '../../view/welcome/PrivacyPolicyDialog'
import { common } from '@kit.AbilityKit'
import PreferencesUtils from '../../utils/PreferencesUtils/PreferencesUtils';
import { router } from '@kit.ArkUI'

const PREF_NAME01 = "myPreferences";
const PRE_KEY01='PrivacyKey'
const PREF_NAME02 = "myPreference_register";
const PRE_KEY02='registerKey'
@Entry
@Component
struct WelcomePage {

  //获取实例信息
  context=getContext(this) as common.UIAbilityContext
  //声明弹窗
  controller: CustomDialogController = new CustomDialogController({
    builder: PrivacyPolicyDialog({
      confirm:():void=>this.onConfirm(),
      cancel:():void=>this.exitApp(),
    })
  })

  onConfirm(){
    //保存首选项
    PreferencesUtils.putPreferenceValue(PREF_NAME01,PRE_KEY01,true)
    //跳转
    this.jumpToRegister()
  }
  exitApp(){
    //退出
    this.context.terminateSelf()
  }

  async aboutToAppear() {
    // 加载首选项
    let isAgree = await PreferencesUtils.getPreferenceValue(PREF_NAME01, PRE_KEY01, false)
    // 检查注册状态
    let isRegistered = await PreferencesUtils.getPreferenceValue(PREF_NAME02, PRE_KEY02, false);
    // 判断
    if (isAgree) {
      if (isRegistered) {
        // 跳转到主页面（或应用内部）
        router.replaceUrl({ url: 'pages/Home/Index' }, router.RouterMode.Single);
      } else {
        // 跳转到注册页面
        this.jumpToRegister();
      }
    } else {
      // 打开隐私政策弹窗
      this.controller.open();
    }
  }
  jumpToRegister(){
    setTimeout(()=>{
      router.replaceUrl(
        {
          url:'pages/Register/Register'
        },
        //跳转模式
        router.RouterMode.Single,
        //失败的回调
        err=>{
          if (err) {
            console.log(`路由失败 errCode:${err.code} ,errMsg:${err.message}`)
          }
        }
      )
    },1000)

  }
  build() {
    Column() {

      Column(){
        //图片
        Image($r("app.media.welcome01")).width(260).interpolation(ImageInterpolation.High)
        Image($r('app.media.welcome02')).width(260).interpolation(ImageInterpolation.High)
      }
      .layoutWeight(1)

      //文字描述
      Row(){
        Text('星语小屋支持').opacity(0.5)
        Text('iPv6').opacity(0.5)
          .border({style:BorderStyle.Solid,width:1,color:Color.Gray,radius:10})
          .padding({left:5,right:5})
        Text('网络').opacity(0.5)
      }

    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor('')
  }
}