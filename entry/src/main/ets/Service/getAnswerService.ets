import { httpAnswerIssue } from '../utils/HttpUtils/httpAnswerIssue';  // 引入封装的 HTTP 请求工具

interface AIResponse {
  answer: string;
}

// 定义请求体的类型
interface QuestionRequest {
  question: string;
}

class GetAnswerService {
  // 获取AI答案的请求
async getAnswer(question: string): Promise<string> {
    try {
      // 使用 httpAnswerIssue 时，显式指定请求数据的类型为 QuestionRequest
      const response = await httpAnswerIssue<AIResponse>('AI_API_URL', { question } as QuestionRequest);
      return response.answer; // 返回 AI 的答案
    } catch (error) {
      console.error('获取答案失败:', error);
      return '抱歉，无法回答这个问题。'; // 错误处理返回默认消息
    }
  }
}

const getAnswerService = new GetAnswerService();
export default getAnswerService;
