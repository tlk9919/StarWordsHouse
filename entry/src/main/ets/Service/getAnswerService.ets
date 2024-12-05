import { httpAnswerIssue } from '../utils/HttpUtils/httpAnswerIssue';

interface AIResponse {
  answer: string;
}

interface QuestionRequest {
  question: string;
}

class GetAnswerService {
  // 获取AI答案的请求
  async getAnswer(question: string): Promise<string> {
    if (!question.trim()) {
      return '问题不能为空！'; // 如果问题为空，直接返回提示信息
    }

    try {
      // 调用时传递 QuestionRequest 对象
      const response = await httpAnswerIssue<AIResponse>('POST', '/get-answer', { question } as QuestionRequest);
      return response.answer; // 返回 AI 的答案
    } catch (error) {
      console.error('获取答案失败:', error);
      return '抱歉，无法回答这个问题。'; // 错误处理返回默认消息
    }
  }
}

const getAnswerService = new GetAnswerService();
export default getAnswerService;
