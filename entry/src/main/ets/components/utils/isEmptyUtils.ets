// 内容非空
export function isEmpty(content: string): boolean {
  return !(content && content.trim().length > 0);
}

// 手机号和邮箱验证
export function isPhone(input: string): boolean {
  // 中国手机号正则
  const phoneReg = /^1[3-9]\d{9}$/;
  // 邮箱正则
  const emailReg = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

  // 验证手机号或邮箱
  return phoneReg.test(input) || emailReg.test(input);
}

// 密码验证
export function isPassword(password: string): boolean {
  // 密码验证：至少包含 6 位，且字母与数字的组合
  let reg = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}$/;
  return reg.test(password);
}

// 验证码非空验证
export function isVerificationCode(code: string): boolean {
  return !(code && code.trim().length === 0);  // 判断验证码是否为空
}
