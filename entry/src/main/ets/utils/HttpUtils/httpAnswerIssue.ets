import axios, { AxiosResponse } from '@ohos/axios';
// 定义响应数据类型
interface AIResponse {
  answer: string;
}

// 封装的 axios 请求
export  async function httpAnswerIssue<T>(url: string, data: object): Promise<T> {
  try {
    const response: AxiosResponse<T> = await axios.post(url, data);
    return response.data;  // 返回响应数据
  } catch (error) {
    console.error('请求失败:', error);
    throw new Error('请求失败，请稍后再试');
  }
}
