import axios, { AxiosResponse } from '@ohos/axios';

// --------------------------------------
// 定义不同请求类型的数据
// --------------------------------------

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

// 新增：修改密码请求数据类型
interface ChangePasswordRequestData {
  email: string;
  password: string;      // 当前密码
  newPassword: string;   // 新密码
  code: string;          // 验证码
}

// --------------------------------------
// 定义响应数据的类型
// --------------------------------------

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

// 新增：修改密码响应数据类型
interface ChangePasswordResponseData {
  message: string;  // 成功或失败的信息
}

// --------------------------------------
// 封装 HTTP 请求工具
// --------------------------------------

export async function httpRequest(
  method: string,
  url: string,
  data?:
    | RegisterRequestData
    | LoginRequestData
    | SendVerificationCodeRequestData
    | VerifyCodeRequestData
    | ChangePasswordRequestData  // 新增：支持修改密码请求的数据类型
): Promise<
LoginResponseData
  | SendVerificationCodeResponseData
  | VerifyCodeResponseData
  | ChangePasswordResponseData  // 新增：支持修改密码响应的数据类型
> {
  try {
    // 执行请求并明确指定响应类型
    const response: AxiosResponse = await axios({
      method,
      url: `http://localhost:3000${url}`,  // 后端接口地址
      data,
    });

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
