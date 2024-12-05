import axios, { AxiosResponse } from '@ohos/axios';

// 定义响应数据类型
interface AIResponse {
  answer: string;
}

// 基础 API URL
const BASE_URL = 'http://localhost:3000';

// 封装的 axios 请求，支持 method 和其他参数
export async function httpAnswerIssue<T>(
  method: string,     // 请求方法，如 'POST'、'GET' 等
  url: string,        // 请求的 URL
  data?: object       // 请求的 data 数据
): Promise<T> {
  try {
    const response: AxiosResponse<T> = await axios({
      method,                        // 动态设置请求方法
      url: `${BASE_URL}${url}`,       // 将基础 URL 和相对路径结合
      data,                          // 请求的数据
      headers: {
        'Content-Type': 'application/json', // 设置 Content-Type 为 JSON
      }
    });
    return response.data;  // 返回响应数据
  } catch (error) {
    console.error('请求失败:', error);
    throw new Error('请求失败，请稍后再试');
  }
}
