/**
 * @file index.ets
 * @description
 * @author liushun
 * @created 2025/9/22 18:33
 * @lastModified 2025/9/22 18:33
 */
import dataPreferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';

export default class PreferencesUtil {
  private static instances: Map<string, dataPreferences.Preferences|null> = new Map();

  public  static async initPreference(context: common.UIAbilityContext, name: string = 'default') {

    try {
      const preference = await dataPreferences.getPreferences(context, name);
      if(preference){
        PreferencesUtil.instances.set(name, preference);
      }
    }catch (e){
      console.log(e);
    }

    if(PreferencesUtil.instances.has(name)){
      return
    }
    const preferences = await PreferencesUtil.initialize(context, name);
    PreferencesUtil.instances.set(name, preferences);

  }

  private static getPreference(name: string): dataPreferences.Preferences|null {
    if(PreferencesUtil.instances.has(name)){
      return PreferencesUtil.instances.get(name)||null;
    }
    return null
  }

  // 初始化 Preferences 实例
  private static async initialize(context: common.UIAbilityContext, name: string): Promise<dataPreferences.Preferences|null> {
    try {
      const preferences = await dataPreferences.getPreferences(context, name);
      return preferences;
    } catch (error) {
      console.error(`Failed to initialize preferences ${name}. Error: ${error}`);
    }
    return null
  }

  public static  async put(key: string, value: dataPreferences.ValueType, name: string = 'default'): Promise<boolean> {

    const preferences = PreferencesUtil.getPreference(name);
    if (!preferences) {
      console.error('Preferences not initialized');
      return false;
    }

    try {
      await preferences.put(key, value);
      await preferences.flush();
      return true;
    } catch (error) {
      console.error(`Failed to put value for key ${key}. Error: ${error}`);
      return false;
    }
  }

  /**
   * 获取数据
   * @param key 键
   * @param defaultValue 默认值
   * @returns 存储的值或默认值
   */
  public static  async get<T extends dataPreferences.ValueType>(key: string, defValue: T, name: string = 'default' ): Promise<T> {
    const preferences = PreferencesUtil.getPreference(name);
    if (!preferences) {
      console.error('Preferences not initialized');
      return defValue;
    }

    try {
      const value = await preferences.get(key, defValue);
      return value as T;
    } catch (error) {
      console.error(`Failed to get value for key ${key}. Error: ${error}`);
      return defValue;
    }
  }

  /**
   * 删除数据
   * @param key 键
   * @returns 是否成功
   */
  public static  async delete(key: string, name: string = 'default'): Promise<boolean> {
    const preferences = PreferencesUtil.getPreference(name);
    if (!preferences) {
      console.error('Preferences not initialized');
      return false;
    }

    try {
      await preferences.delete(key);
      await preferences.flush();
      return true;
    } catch (error) {
      console.error(`Failed to delete value for key ${key}. Error: ${error}`);
      return false;
    }
  }

  /**
   * 清空所有数据
   * @returns 是否成功
   */
  public static  async clear(name: string = 'default'): Promise<boolean> {
    const preferences = PreferencesUtil.getPreference(name);
    if (!preferences) {
      console.error('Preferences not initialized');
      return false;
    }

    try {
      await preferences.clear();
      await preferences.flush();
      return true;
    } catch (error) {
      console.error('Failed to clear preferences. Error: ${error}');
      return false;
    }
  }

}