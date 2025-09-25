/**
 * @file Http.ets
 * @description
 * @author liushun
 * @created 2025/9/14 14:30
 * @lastModified 2025/9/14 14:30
 */


import axios, { AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import {BaseLog} from "../util//index"
import {PreferencesUtil} from "../util/index";


axios.defaults.baseURL = 'https://www.wanandroid.com';
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';

const Tag = 'HTTP';


interface IHeader extends AxiosRequestConfig{
  Cookie: string
}

export function setCookie(cookie: string) {
  axios.defaults.headers['Cookie'] = cookie;
}


axios.interceptors.request.use(
  (config: InternalAxiosRequestConfig): InternalAxiosRequestConfig => {
		return config;
	}
);

export function HttpGet<T>(url: string): Promise<T>{
  BaseLog(Tag, url)
  return new Promise((resolve: Function, reject: Function) => {
    axios.get(url).then((res: AxiosResponse)=>{
      resolve(res.data.data);
      BaseLog(Tag, JSON.stringify(res.data.data))
    }).catch((e:Error)=>{
      reject(e);
    })
  })

}

export function HttpPost<T>(url: string, data: object): Promise<T>{
  BaseLog(Tag, url)
  return new Promise((resolve: Function, reject: Function) => {
    axios.post(url, data).then((res: AxiosResponse)=>{
      resolve(res.data);
      if(url.includes('login')||url.includes('register')){
        Object.keys(res.headers).forEach((item)=>{
          if(item === 'set-cookie'){
            BaseLog(Tag, JSON.stringify(item));
            BaseLog(Tag, JSON.stringify(res.headers[item]))
            const cookie = res.headers[item]?.toString().replaceAll("[", "").replaceAll("]", "")||'';
            BaseLog(Tag, cookie)
            PreferencesUtil.put('Cookie', cookie)
          }
        })
      }

      BaseLog(Tag, JSON.stringify(res.headers))
      BaseLog(Tag, JSON.stringify(res))
    }).catch((e:Error)=>{
      reject(e);
    })
  })

}