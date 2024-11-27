import {uiTermsStyle} from "../../components/components"
import { Header } from "../../components/components"
import {buttonStyle} from "../../components/components"
import {forgetPassword} from "../../components/components"
import {welcome} from "../../components/components"
import { httpRequest } from '../../utils/HttpUtils/httpRequest';  // 引入 HTTP 请求工具
import { router } from '@kit.ArkUI'
import { LoginTab } from '../../utils/Login/LoginUtils'

@Entry
@Component
struct Register {

  build() {
    Column({ space: 10 }) {
      // 返回键位
      Header()
      // 注册标题
      welcome("欢迎登录","体验不一样的贴心服务")
      //导航栏
      LoginTab()
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#ecc4f4")

  }


}
