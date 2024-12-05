import axios, { AxiosResponse } from '@ohos/axios';
import {ChangePasswordRequestData,ChangePasswordResponseData,LoginRequestData,LoginResponseData,RegisterRequestData, SendVerificationCodeRequestData,SendVerificationCodeResponseData,VerifyCodeRequestData,VerifyCodeResponseData} from '../../model/ApiData';
// 封装 HTTP 请求工具
export async function httpRequest(
  method: string,
  url: string,
  data?:
    | RegisterRequestData
    | LoginRequestData
    | SendVerificationCodeRequestData
    | VerifyCodeRequestData
    | ChangePasswordRequestData // 新增：支持修改密码请求的数据类型
): Promise<
LoginResponseData |
SendVerificationCodeResponseData |
VerifyCodeResponseData |
ChangePasswordResponseData // 新增：支持修改密码响应的数据类型
> {
  try {
    // 执行请求并明确指定响应类型
    const response: AxiosResponse = await axios({
      method,
      url: `http://localhost:3000${url}`,  // 后端接口地址
      // url: `http://43.140.214.215:3000${url}`,  // 后端接口地址
      data,
    });

    // 打印响应的详细数据
    console.log('HTTP 响应数据:', JSON.stringify(response.data)); // 打印响应的 body 部分
    console.log('响应的 message:', JSON.stringify(response.data.message));  // 直接查看 message 字段
    console.log("HTTP 状态码:", JSON.stringify(response.status));  // 打印状态码，查看是否是 200 或 400

    return response.data;
  } catch (error) {
    console.error('HTTP 请求失败:', error);

    // 判断错误类型并进行相应处理
    if (error.response) {
      // 如果有响应对象（后端返回了错误信息）
      throw new Error(error.response.data?.message || '请求失败，请稍后再试');
    } else if (error.request) {
      // 如果没有收到响应（可能是网络错误或超时）
      throw new Error('请求超时，请检查网络连接');
    } else {
      // 其他错误
      throw new Error('请求失败，请稍后再试');
    }
  }
}