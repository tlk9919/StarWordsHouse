import { httpRequest } from '../utils/HttpUtils/httpRequest';  // 引入 HTTP 请求工具
import codeService from './CodeService';  // 引入验证码相关服务
class ResetPassword{

  // 修改密码按钮点击事件
  async handleChangePassword(mobileNumber:string,newPassword:string,code:string,confirmPassword:string) {
    // 校验新密码和确认密码是否一致
    if (newPassword !== confirmPassword) {
      AlertDialog.show({
        title: '密码错误',
        message: '新密码和确认密码不一致，请重新输入。',
        autoCancel: true
      });
      return;
    }

    // 校验密码格式
    if (newPassword.length < 9 || newPassword.length > 20) {
      AlertDialog.show({
        title: '密码长度错误',
        message: '新密码必须为20到20个字符。',
        autoCancel: true
      });
      return;
    }

    // 先验证验证码
    const isCodeVerified = await codeService.validateVerificationCode(mobileNumber,code)
    if (!isCodeVerified) {
      return;  // 如果验证码验证失败，则不继续执行修改密码
    }

    // 发送修改密码请求
    try {
      console.log('修改密码请求的数据:',JSON.stringify({ mobileNumber, newPassword,code }));

      const response = await httpRequest('PUT', '/reset-password', {
        email: mobileNumber,
        newPassword,
        confirmPassword,
        code
      });

      console.log('修改密码响应:', response);

      if (response.message === '密码修改成功') {
        AlertDialog.show({
          title: '修改成功',
          message: '您的密码已成功修改，请使用新密码登录。',
          autoCancel: true
        });
      } else {
        AlertDialog.show({
          title: '修改失败',
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
}
const resetPasswordService=new ResetPassword()
export default  resetPasswordService