import { httpRequest } from '../utils/HttpUtils/httpRequest';  // 引入 HTTP 请求工具
 class CodeService {

  // 发送验证码按钮点击事件
  async handleSendVerificationCode(mobileNumberOrEmail:string) :Promise<void> {
    try {
      const response = await httpRequest('POST', '/send-verification-code', {
        email: mobileNumberOrEmail  // 假设是邮箱
      });

      // 打印真实响应数据
      console.log( 'testTag', '验证码发送响应:',  JSON.stringify(response));  // 打印服务器响应数据
      if (response.message === '验证码发送成功') {
        AlertDialog.show({
          title: '验证码已发送',
          message: '请检查您的邮箱获取验证码',
          autoCancel: true
        });
      } else {
        AlertDialog.show({
          title: '发送失败',
          message: response.message,
          autoCancel: true
        });
      }
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
  async validateVerificationCode(mobileNumberOrEmail:string,code:string) {
    try {
      //发送的数据
      console.log('发送的数据:', JSON.stringify({ email: mobileNumberOrEmail, code }));
      // 请求验证码验证接口
      const response = await httpRequest('POST', '/verify-code', {
        email: mobileNumberOrEmail,
        code: code
      });

      // 打印服务器返回的响应数据
      console.log('验证码验证响应:', JSON.stringify(response));

      if (response.message === '验证码验证成功') {
        return true;
      } else {
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

      AlertDialog.show({
        title: '验证失败',
        message: e.message || '验证码错误，请重新输入。',
        autoCancel: true
      });

      return false;  // 返回失败
    }
  }

}
const codeService=new CodeService()
export default codeService
