import preferences from '@ohos.data.preferences';
import { UIAbility, Context } from '@kit.AbilityKit';

class PreferencesUtils {
  // pref: preferences.Preferences | null = null
  //存放更多，存储多个首选项实例，Map 的键是首选项的名称，值是 Preferences 实例
  preMap:Map<string, preferences.Preferences>=new Map()
  // 获取首选实例方法一
  // loadPreference(context: Context, name: string) {
  //异步操作
  //   preferences.getPreferences(context, name)
  //     .then(pref=>{
  //       // this.pref=pref
  //       this.preMap.set(name,pref)
  //       console.log(`成功加载首选项: ${name}`);
  //     })
  //     .catch((reason:Error )=>{
  //       console.log('加载首选项失败',`加载Preferences失败[${name}]失败`,JSON.stringify(reason))
  //     })
  // }

  // 获取首选实例方法二
  async  loadPreference(context: Context, name: string) {
    //加载preferences同步
    try {
      let pref = await preferences.getPreferences(context, name)
      this.preMap.set(name, pref)
      console.log(`成功加载首选项: ${name}`);
    } catch (e) {
      console.log('加载首选项失败',`加载Preferences失败[${name}]失败`,JSON.stringify(e))
    }

    }
    //写
    async putPreferenceValue(name:string,key:string,value:preferences.ValueType){
    if(!this.preMap.has(name)){
      console.log('加载首选项失败',`Preferences[${name}]未初始化`)
      return
    }
      try {
        let pref = this.preMap.get(name)
        //写入数据
        await pref?.put(key, value)
        //刷盘
        await pref?.flush()
        console.log('testTag', `保存Preferences [${name}.${key}=${value}]成功`)
      } catch (e) {
        console.log('testTag', `保存Preferences [${name}.${key}=${value}]失败`,JSON.stringify(e))
      }
    }

    //读
  async getPreferenceValue(name: string, key: string, defaultValue: preferences.ValueType) {
    if (!this.preMap.has(name)) {
      console.log('加载首选项失败', `Preferences[${name}]未初始化`)
      return
    }
    try {
      let pref = this.preMap.get(name);
      // 读取数据
      let value = await pref?.get(key,defaultValue); // 获取值
      console.log('testTag', `读取Preferences [${name}.${key}=${value}]成功`)
      return value
    } catch (e) {
      console.log('testTag', `读取Preferences [${name}.${key}]失败`, JSON.stringify(e));
      return defaultValue
    }
  }

}

const preferencesUtils = new PreferencesUtils();
export default preferencesUtils;
