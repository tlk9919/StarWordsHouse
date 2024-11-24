import axios, { AxiosResponse } from '@ohos/axios'

// 定义请求数据的类型
interface LoginRequestData {
  username: string;
  password: string;
}

// 定义响应数据的类型
interface LoginResponseData {
  message: string;
  token?: string;
}

// 封装 HTTP 请求工具
export async function httpRequest(method: string, url: string, data?: LoginRequestData): Promise<LoginResponseData> {
  try {
    // 执行请求并明确指定响应类型为 AxiosResponse<LoginResponseData>
    const response: AxiosResponse<LoginResponseData> = await axios({
      method,
      url: `http://localhost:3000${url}`,  // 后端接口地址
      data,
    })

    // 返回响应数据
    return response.data
  } catch (error) {
    console.error('HTTP 请求失败:', error)

    // 抛出一个明确类型的错误对象
    throw new Error('请求失败，请稍后再试')
  }
}
