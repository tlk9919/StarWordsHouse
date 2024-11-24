import axios from '@ohos/axios'

// 创建 axios 实例
const instance = axios.create({
  baseURL: "",  // 基路径
  timeout: 5000,  // 超时时间
  headers: {
    "Content-Type": "application/json",  // 假设请求为 JSON 格式
  }
})

// 定义接口，允许对象包含固定的字段
interface GeneratedObjectLiteralInterface_1 {

}

interface GeneratedObjectLiteralInterface_2 {
  password: string;
  username: string;

}

interface GeneratedObjectLiteralInterface_3 {

}

// 创建合并后的数据类型接口
interface CombinedData {
  _gp: string;
  _mt: string;
  username: string;   // 显式列出所有可能的字段
  password: string;
}

// GET 请求函数
export function httpGet(_gp: string, _mt: string, params: GeneratedObjectLiteralInterface_1 = {}) {
  return instance.get(null, { params })
}

// POST 请求函数
export function httpPost(_gp: string, _mt: string, data: GeneratedObjectLiteralInterface_2 = {
  password: '',
  username: ''
}, params: GeneratedObjectLiteralInterface_3 = {}) {
  // 手动合并 _gp 和 _mt 到 data 中
  const combinedData: CombinedData = {
    _gp: _gp,
    _mt: _mt,
    // 显式列出所有要合并的字段
    // 例如假设 data 包含 "username" 和 "password"
    username: data.username,
    password: data.password,
    // 可以继续列出其他字段
  };

  return instance.post(null, combinedData, { params });
}
