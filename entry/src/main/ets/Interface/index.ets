/**
 * @file index.ets
 * @description
 * @author liushun
 * @created 2025/9/14 14:10
 * @lastModified 2025/9/14 14:10
 */


export interface IHomeBanner{
  imagePath: string,
  title: string,
  id: number,
}



export interface ITabList {
  data: Array<ITabItem>
}

export interface ITabItem {
  name: string,
  id: number,
}

export interface IBaseListItem{
  collect: boolean
  chapterName: string,
  author: string,
  id: number,
  niceDate: string,
  superChapterName: string,
  title: string,
  shareUser: string,

  update: Function,
  changeCollect: Function,
}

export interface IHomeList {
  datas: Array<IBaseListItem>
}

export interface ICustomListItem {
  topLeft: string,
  topRight: string,
  content: string,
  bottomLeft: string,
  collect?: boolean,
}

export interface ILogin {
  password: string,
  username: string,
}

export interface ILoginData{
  nickname: string,
  id: number,
}

export interface ILoginResponse {
  data: ILoginData,
  errorMsg: string,
}
