import { buttonStyle, Header, uiTermsStyle, welcome } from '../../components/components';
import { router } from '@kit.ArkUI';
import PreferencesUtils from '../../utils/PreferencesUtils/PreferencesUtils';
import CodeService from '../../Service/CodeService';
import registerService from  '../../Service/RegisterService'
import { RegisterContent } from '../../view/Register/RegisterContent';

const PREF_NAME02 = "myPreference_register";
const PRE_KEY02='registerKey'
@Entry
@Component
struct Register {
  async onRegisterComplete() {
    // 保存注册状态
    await PreferencesUtils.putPreferenceValue(PREF_NAME02, PRE_KEY02, true);
    // 跳转到主页面
    router.replaceUrl({ url: 'pages/Home/Index' }, router.RouterMode.Single);
  }

  build() {
    Column({ space: 10 }){
      Header();
      welcome("欢迎注册", "未注册的账号将自动创建账号");
      //登录详细框
      RegisterContent()
    }
    .backgroundColor("#ecc4f4")
    .width('100%')
    .height('100%')
  }

}
