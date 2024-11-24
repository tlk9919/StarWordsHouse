//内容非空
export function isEmpty(content:string):boolean{
  return ! (content &&content.trim().length>0)
}

//手机号非空
export function isPhone(phone:string):boolean{
  //中国手机号
  let reg =/^1[3-9]\d{9}$/
  return reg.test(phone)

}

//密码验证
export function isPassword(password: string): boolean {
  // 密码验证：至少包含 6 位，且字母与数字的组合
  let reg = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}$/
  return reg.test(password);
}
