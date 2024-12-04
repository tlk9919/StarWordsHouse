import { httpRequest } from '../utils/HttpUtils/httpRequest';  // 引入 HTTP 请求工具
import codeService from './CodeService';  // 引入验证码相关服务
class Register{
  // 注册按钮点击事件
  async handleRegister(mobileNumberOrEmail:string ,password: string,code: string) {
    // 校验是否已获取验证码
    if (!code) {
      AlertDialog.show({
        title: '温馨提示',
        message: '请先获取验证码',
        autoCancel: true
      });
      return;
    }
    // 先验证验证码
    const isCodeVerified = await codeService.validateVerificationCode(mobileNumberOrEmail,code);
    if (!isCodeVerified) {
      return;  // 如果验证码验证失败，则不继续执行注册
    }

    try {

      const response = await httpRequest('POST', '/register', {
        username: mobileNumberOrEmail,
        password:password,
        code: code
      });
      // 打印响应的结构
      console.log('注册响应结构:', JSON.stringify(response))
      console.log('响应的 message:', JSON.stringify(response.message));
      // 打印注册时的数据（真实的用户名、密码和验证码）
      console.log( 'testTag', '注册请求的数据:',  JSON.stringify({ mobileNumberOrEmail:String ,password: String,code: String}));

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
          title: '注册失败',
          // message: '服务器错误，请稍后再试',
          message: e.message || '服务器错误，请稍后再试。',//手动处理，因为不执行else{}
          autoCancel: true
        });
    }
  }
}
const registerService=new Register()
export default registerService