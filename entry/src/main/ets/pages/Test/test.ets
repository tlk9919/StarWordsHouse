// import { httpRequest } from '../../utils/HttpUtils/httpRequest'
// import codeService from '../../Service/CodeService';  // 引入验证码相关服务
// class test{
//   //发送验证码请求
//   async  handleSendVerificationCode(mobileNumberOrEmail:string){
//     // 第一步：发送验证码请求
//     // 调用 httpRequest 方法，向后端接口发送一个 POST 请求，参数为邮箱或手机号码
//     try {
//       const response = await httpRequest('POST', '/send-verification-code', {
//         email: mobileNumberOrEmail
//       })
//       //第二步：打印响应数据
//       console.log('testTag', JSON.stringify(response))
//       // 第三步：根据服务器的响应判断并处理
//       if (response.message === '验证码发送成功') {
//         AlertDialog.show({
//           title: '验证码已发送',
//           message: '请检查您的邮箱获取验证码',
//           autoCancel: true
//         })
//       } else {
//         AlertDialog.show({
//           title: '发送失败',
//           message: response.message || '验证码发送失败',
//           autoCancel: true
//         })
//       }
//     } catch (e) {
//       AlertDialog.show({
//         title: '请求失败',
//         message: '服务器错误，请稍后再试',
//         autoCancel: true
//       });
//     }
//   }
//   // 验证验证码的接口
//   async  validateVerificationCode(mobileNumberOrEmail: string, code: string){
//     // 第一步：打印发送的数据
//     try {
//       console.log('sent data:', JSON.stringify({ mail: mobileNumberOrEmail, code }))
//       // 第二步：请求验证码验证接口
//       const response = await httpRequest('POST', '/verify-code', {
//         email: mobileNumberOrEmail,
//         code
//       })
//       // 第三步：打印服务器响应
//       console.log('response data', JSON.stringify(response));
//       // 第四步：根据响应结果判断
//       if (response.message === '验证码验证成功') {
//         return true;
//       } else {
//         AlertDialog.show({
//           title: '验证失败',
//           message: response.message || '验证码错误，请重新输入。',
//           autoCancel: true
//         });
//         return false
//       }
//     } catch (e) {
//       AlertDialog.show({
//         title: '验证失败',  // 弹框标题
//         message: e.message || '验证码错误，请重新输入。',  // 错误信息或默认提示
//         autoCancel: true  // 弹框自动取消
//       });
//       return false;
//     }
//   }
//   //重置密码
// async handleChangePassword(mobileNumber:string,newPassword:string,code:string,confirmPassword:string){
//   // 第三步：先验证验证码
//   const isCodeVerified = await codeService.validateVerificationCode(mobileNumber,code)
//   if (!isCodeVerified) {
//     return;  // 如果验证码验证失败，则不继续执行修改密码
//   }
//   if (!isCodeVerified) {
//     return;  // 如果验证码验证失败，则不继续执行修改密码
//   }
//   try { // 第四步：发送修改密码请求
//     const response = await httpRequest('/PUT', '/reset-password',
//       {
//         email: mobileNumber,
//         code,
//         newPassword,
//         confirmPassword,
//       })
//     // 第五步：根据服务器返回的结果，显示相应的提示信息
//     if (response.message === '密码修改成功') {
//       AlertDialog.show({
//         title: '修改成功',
//         message: '您的密码已成功修改，请使用新密码登录。',
//         autoCancel: true
//       });
//     } else {
//       AlertDialog.show({
//         title: '修改失败',
//         message: response.message,
//         autoCancel: true
//       });
//     }
//   } catch (e) {
//     AlertDialog.show({
//       title: '请求失败',
//       message: '服务器错误，请稍后再试',
//       autoCancel: true
//     });
//   }
//   }
//   }