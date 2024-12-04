import { router } from '@kit.ArkUI';
import { httpRequest } from '../utils/HttpUtils/httpRequest';  // 引入 HTTP 请求工具
class LoginService {
  // 登录按钮点击事件
  async handleLogin(mobileNumber: string, password: string) {
    // console.log('发送的密码:', this.password);
    try {
      const response = await httpRequest('POST', '/login', {
        username: mobileNumber,
        password: password
      });
      console.log("返回的响应：", response);  // 打印服务器返回的数据
      if (response.message === '登录成功') {

        setTimeout(() => {
          router.replaceUrl(
            {
              url: 'pages/Home/Index'
            },
            //跳转模式
            router.RouterMode.Single,
            //失败的回调
            err => {
              if (err) {
                console.log(`路由失败 errCode:${err.code} ,errMsg:${err.message}`)
              }
            }
          )
        }, 1000)

      } else {
        AlertDialog.show({
          title: '登录失败',
          message: response.message,
          autoCancel: true
        });
      }
    } catch (e) {
      AlertDialog.show({
        title: '请求失败',
        message: e.message || '服务器错误，请稍后再试',
        autoCancel: true
      });
    }
  }
}
  const loginService=new LoginService()
export default loginService
