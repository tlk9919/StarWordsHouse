import axios, { AxiosResponse } from '@ohos/axios';

// 定义不同请求类型的数据
interface RegisterRequestData {
  username: string;
  password: string;
  code?: string;  // 修改为 code
}

interface LoginRequestData {
  username: string;
  password: string;
}

interface SendVerificationCodeRequestData {
  email: string;
}

interface VerifyCodeRequestData {
  email: string;
  code: string;  // 修改为 code
}

// 定义响应数据的类型
interface LoginResponseData {
  message: string;
  token?: string;
}

interface SendVerificationCodeResponseData {
  message: string;
}

interface VerifyCodeResponseData {
  message: string;
}

// 封装 HTTP 请求工具
export async function httpRequest(
  method: string,
  url: string,
  data?: RegisterRequestData | LoginRequestData | SendVerificationCodeRequestData | VerifyCodeRequestData // 使用联合类型
): Promise<LoginResponseData | SendVerificationCodeResponseData | VerifyCodeResponseData> {  // 扩展响应类型
  try {
    // 执行请求并明确指定响应类型
    const response: AxiosResponse<LoginResponseData | SendVerificationCodeResponseData | VerifyCodeResponseData> = await axios({
      method,
      url: `http://43.140.214.215:3000${url}`,  // 后端接口地址
      data,
    });

    // 返回响应数据
    return response.data;
  } catch (error) {
    console.error('HTTP 请求失败:', error);

    // 判断错误类型并进行相应处理
    if (error.response) {
      // 如果有响应对象（后端返回了错误信息）
      console.error('后端错误响应:', error.response);  // 打印后端的错误响应

      // 抛出带有响应信息的错误
      throw new Error(error.response.data?.message || '请求失败，请稍后再试');
    } else if (error.request) {
      // 如果没有收到响应（可能是网络错误或超时）
      console.error('没有收到响应:', error.request);
      throw new Error('请求超时，请检查网络连接');
    } else {
      // 其他错误
      console.error('错误信息:', error.message);
      throw new Error('请求失败，请稍后再试');
    }
  }
}
