// 定义不同请求类型的数据
export interface RegisterRequestData {
  username: string;
  password: string;
  code?: string;
}

export interface LoginRequestData {
  username: string;
  password: string;
}

export interface SendVerificationCodeRequestData {
  email: string;
}

export interface VerifyCodeRequestData {
  email: string;
  code: string;
}

export interface ChangePasswordRequestData {
  email: string;
  newPassword: string;     // 新密码
  confirmPassword: string; // 确认密码
  code: string;            // 验证码
}

// 定义响应数据的类型
export interface LoginResponseData {
  message: string;
  token?: string;
}

export  interface SendVerificationCodeResponseData {
  message: string;
}

export  interface VerifyCodeResponseData {
  message: string;
}


export interface ChangePasswordResponseData {
  message: string;  // 成功或失败的信息
}