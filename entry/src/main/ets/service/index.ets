/**
 * @file index.ets
 * @description 
 * @author liushun
 * @created 2025/9/14 13:54
 * @lastModified 2025/9/14 13:54
 */

import { IHomeBanner, IHomeList, ILogin, ILoginResponse, ITabItem, ITabList } from "../Interface";
import {HttpGet, HttpPost} from "./Http";


export function getBanner(): Promise<Array<IHomeBanner>>{
  return HttpGet<Array<IHomeBanner>>('/banner/json')
}

export function getHomeList(page: number = 0): Promise<IHomeList>{
  return HttpGet<IHomeList>(`/article/list/${page}/json`)
}

export function getSquareList(page: number = 0): Promise<IHomeList>{
  return HttpGet<IHomeList>(`/user_article/list/${page}/json`)
}

export function getTabList(): Promise<Array<ITabItem>>{
  return HttpGet<Array<ITabItem>>(`/wxarticle/chapters/json`)
}

export function getTabArticleList(tabId: number, page: number = 1): Promise<IHomeList>{
  return HttpGet<IHomeList>(`wxarticle/list/${tabId}/${page}/json`)
}

export function login(data: ILogin): Promise<ILoginResponse>{
  return HttpPost<ILoginResponse>(`/user/login`, data)
}

