import { buttonStyle, Header, uiTermsStyle, welcome } from '../../components/components';
import { httpRequest } from '../../utils/HttpUtils/httpRequest'; // 引入 HTTP 请求工具
import { router } from '@kit.ArkUI';
import PreferencesUtils from '../../utils/PreferencesUtils/PreferencesUtils';

const PREF_NAME02 = "myPreference_register";
const PRE_KEY02='registerKey'
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
struct Register {

  @State tellnumber:string='188****8888'
  @State seconds: number = 0;  // 初始化
  @State mobileNumberOrEmail: string = '991988677@qq.com'; // 手机号（或邮箱）
  @State password: string = '123456789abc';      // 密码
  @State code: string = ''; // 用户输入的验证码
  @State isCodeSent: boolean = false;  // 是否已发送验证码
  @State isCodeVerified: boolean = false;  // 验证码是否验证成功

  async onRegisterComplete() {
    // 保存注册状态
    await PreferencesUtils.putPreferenceValue(PREF_NAME02, PRE_KEY02, true);
    // 跳转到主页面
    router.replaceUrl({ url: 'pages/Home/Index' }, router.RouterMode.Single);
  }


  // 发送验证码按钮点击事件
  async handleSendVerificationCode() {
    try {
      const response = await httpRequest('POST', '/send-verification-code', {
        email: this.mobileNumberOrEmail  // 假设是邮箱
      });

      // 打印真实响应数据
      console.log( 'testTag', '验证码发送响应:',  JSON.stringify(response));  // 打印服务器响应数据
      if (response.message === '验证码发送成功') {
        AlertDialog.show({
          title: '验证码已发送',
          message: '请检查您的邮箱获取验证码',
          autoCancel: true
        });
        this.isCodeSent = true;
        this.startCountdown();
      } else {
        AlertDialog.show({
          title: '发送失败',
          message: response.message,
          autoCancel: true
        });
      }897

    } catch (e) {
      console.error('请求错误:', e);  // 打印错误信息
      AlertDialog.show({
        title: '请求失败',
        message: '服务器错误，请稍后再试',
        autoCancel: true
      });
    }
  }

  // 验证验证码的接口
  async validateVerificationCode() {
    try {
      // 打印发送的数据（邮箱或手机号，验证码）
      console.log('发送的数据:', JSON.stringify({ email: this.mobileNumberOrEmail, code: this.code }));

      // 请求验证码验证接口
      const response = await httpRequest('POST', '/verify-code', {
        email: this.mobileNumberOrEmail,
        code: this.code
      });

      // 打印服务器返回的响应数据
      console.log('验证码验证响应:', JSON.stringify(response));

      if (response.message === '验证码验证成功') {
        this.isCodeVerified = true;  // 更新状态，表示验证码验证通过
        return true;
      } else {
        this.isCodeVerified = false;
        AlertDialog.show({
          title: '验证失败',
          message: response.message || '验证码错误，请重新输入。',
          autoCancel: true
        });
        return false;
      }
    } catch (e) {
      // 捕获错误并显示提示
      console.error('验证请求失败:', e);
      this.isCodeVerified = false;

      AlertDialog.show({
        title: '验证失败',
        message: e.message || '验证码错误，请重新输入。',
        autoCancel: true
      });

      return false;  // 返回失败
    }
  }


  // 注册按钮点击事件
  async handleRegister() {
    // 校验是否已获取验证码
    if (!this.isCodeSent) {
      AlertDialog.show({
        title: '温馨提示',
        message: '请先获取验证码',
        autoCancel: true
      });
      return;
    }
    // 先验证验证码
    const isCodeVerified = await this.validateVerificationCode();
    if (!isCodeVerified) {
      return;  // 如果验证码验证失败，则不继续执行注册
    }

    try {
      // 打印注册时的数据（真实的用户名、密码和验证码）
      console.log( 'testTag', '注册请求的数据:',  JSON.stringify({ username: this.mobileNumberOrEmail, password: this.password, code: this.code }));

      const response = await httpRequest('POST', '/register', {
        username: this.mobileNumberOrEmail,
        password: this.password,
        code: this.code  // 提交验证码，改为 code
      });

      // 打印注册响应
      console.log('注册响应:',JSON.stringify(response));  // 打印服务器返回的响应

      if (response.message === '注册成功') {
        AlertDialog.show({
          title: '注册成功',
          message: '可以使用注册的账号进行登录',
          autoCancel: true
        });
      } else {
        AlertDialog.show({
          title: '注册失败',
          message: response.message,
          autoCancel: true
        });
      }
    } catch (e) {
      AlertDialog.show({
        title: '请求失败',
        message: '服务器错误，请稍后再试',
        autoCancel: true
      });
    }
  }

  build() {
    Column({ space: 10 }){
      Header();
      welcome("欢迎注册", "未注册的账号将自动创建账号");
      //登录详细框
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
                      this.handleSendVerificationCode()
                      // 启动倒计时
                      this.startCountdown()
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
                .borderRadius(10)
                .backgroundColor("#ecc4f4")
                .type(ButtonType.Normal)
                .fontSize(20)
                .width(320)
                .height(60)
                .onClick(() =>{
                  //注册处理函数
                  this.handleRegister();
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
