import preferences from '@ohos.data.preferences';
import { Context } from '@kit.AbilityKit';

// 假设 preferences 实例的内容：只包含语言设置
class Preferences {
  language: string;

  constructor(language: string) {
    this.language = language;
  }

  // 模拟获取首选项的功能
  static getPreferences(context: Context, name: string): Promise<Preferences> {
    // 假设根据 name 返回不同的配置
    return new Promise((resolve, reject) => {
      if (name === "userSettings") {
        // 返回一个模拟的 userSettings 配置，包含语言设置
        resolve(new Preferences("English"));
      } else if (name === "appSettings") {
        // 返回一个模拟的 appSettings 配置，包含语言设置
        resolve(new Preferences("Chinese"));
      } else {
        // 如果找不到配置，返回错误
        reject(new Error("Configuration not found"));
      }
    });
  }
}

class PreferencesUtils {
  // 存储多个首选项实例，Map 的键是首选项的名称，值是 Preferences 实例
  preMap: Map<string, Preferences> = new Map();

  // 获取首选实例的方法
  loadPreference(context: Context, name: string) {
    // 假设 preferences.getPreferences 是异步的，返回一个 Promise
    Preferences.getPreferences(context, name)
      .then(pref => {
        // 将 name 和 pref 作为键值对存储到 preMap 中
        this.preMap.set(name, pref);
        console.log(`成功加载首选项: ${name}`);
      })
      .catch((reason: Error) => {
        console.log('加载首选项失败', `错误信息: ${reason.message}`);
      });
  }

  // 根据 name 获取对应的首选项实例
  getPreference(name: string): Preferences | undefined {
    return this.preMap.get(name);  // 根据 name 获取对应的 pref 实例
  }
}

// 模拟 Preferences 实例和获取过程
const preferencesUtils = new PreferencesUtils();

// 假设 Context 是某种上下文对象，我们这里用 null 或其他值模拟
const context: Context = {} as Context;  // 模拟一个空的上下文对象

// 加载不同的首选项
preferencesUtils.loadPreference(context, "userSettings");  // 加载 "userSettings"
preferencesUtils.loadPreference(context, "appSettings");   // 加载 "appSettings"

// 延时模拟一些操作，然后查询某个首选项
setTimeout(() => {
  // 获取并打印 "userSettings" 对应的首选项实例
  const userSettings = preferencesUtils.getPreference("userSettings");
  console.log('User Settings:', userSettings);

  // 获取并打印 "appSettings" 对应的首选项实例
  const appSettings = preferencesUtils.getPreference("appSettings");
  console.log('App Settings:', appSettings);
}, 2000);  // 等待 2 秒钟后执行查询
