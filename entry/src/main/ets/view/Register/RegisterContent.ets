import { buttonStyle, Header, uiTermsStyle, welcome } from '../../components/components';
import { router } from '@kit.ArkUI';
import PreferencesUtils from '../../utils/PreferencesUtils/PreferencesUtils';
import CodeService from '../../Service/CodeService';
import registerService from  '../../Service/RegisterService'
const PREF_NAME02 = "myPreference_register";
const PRE_KEY02='registerKey'
@Styles
function ButtonStyle(){
  .borderRadius(10)
  .backgroundColor("#ecc4f4")
  .width(320)
  .height(60)
}
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
@Component
export  struct RegisterContent {
  @State tellnumber:string='188****8888'
  @State seconds: number = 0;  // 初始化
  @State mobileNumberOrEmail: string = '991988677@qq.com'; // 手机号（或邮箱）
  @State password: string = '123456789a';      // 密码
  @State code: string = ''; // 用户输入的验证码
  @State isCodeSent: boolean = false;  // 是否已发送验证码
  async onRegisterComplete() {
    // 保存注册状态
    await PreferencesUtils.putPreferenceValue(PREF_NAME02, PRE_KEY02, true);
    // 跳转到主页面
    router.replaceUrl({ url: 'pages/Home/Index' }, router.RouterMode.Single);
  }
  build() {
    Column(){
      Tabs(){
        TabContent(){
          //具体内容
          Column({space:20}){
            Row(){
              Text('账号：')
                .fontSize(16).fontWeight(FontWeight.Bold)
            }
            .width('95%')
            .justifyContent(FlexAlign.Start)
            TextInput({ placeholder: "请输入手机号或邮箱" })
              .padding(20)
              .caretColor('#ecc4f4') //光标颜色
              .onChange(value => {
                this.mobileNumberOrEmail = value;
              })
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
                .type(InputType.Number)
                .onChange(value => {
                  this.code = value;
                })
              Button() {
                Text(this.seconds > 0 ? `${this.seconds}秒|后重新获取` : '获取验证码')
                  .fontColor(this.seconds > 0 ? "#4c74fc" : "#121212")
                  .fontSize(16)
                  .onClick(() => {
                    // 调用发送验证码处理函数
                    CodeService.handleSendVerificationCode(this.mobileNumberOrEmail)
                      .then(()=>{
                        this.isCodeSent=true//发送成功
                        // 启动倒计时
                        this.startCountdown()
                      })
                      .catch((error:Error)=>{
                        console.error('请求失败:', error);
                      })
                  })
              }
              .type(ButtonType.Normal)
              .backgroundColor('rgba(0, 0, 0, 0)')//透明颜色
              .margin({left:200})
              .onClick(() => this.startCountdown());
            }
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
              .onChange(value => {
                this.password = value;
              })
            Text('已有账号?去登录吧')
              .fontSize(15)
              .fontColor('#636e72')
              .onClick(()=>{
                router.replaceUrl(
                  {
                    url:'pages/Login/Login'
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
              })
            Button('注册')
              .ButtonStyle()
              .type(ButtonType.Normal)
              .fontSize(20)
              .onClick(() =>{
                //注册处理函数
                registerService.handleRegister(this.mobileNumberOrEmail,this.password,this.code);
                this.onRegisterComplete()
              }
              )
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
    }.card()
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