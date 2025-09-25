/**
 * @file HomeItemStore.ets
 * @description
 * @author liushun
 * @created 2025/9/15 10:54
 * @lastModified 2025/9/15 10:54
 */

import {IBaseListItem} from "../Interface/index";

@ObservedV2
export  default class BaseItemStore implements  IBaseListItem{

  chapterName: string = '';
  author: string = '';
  id: number = 0;
  niceDate: string = '';
  superChapterName: string = '';
  title: string = '';
  shareUser: string = '';
  @Trace collect: boolean = false;

  constructor(item: IBaseListItem) {
    this.chapterName = item.chapterName;
    this.author = item.author;
    this.id = item.id;
    this.niceDate = item.niceDate;
    this.superChapterName = item.superChapterName;
    this.title = item.title;
    this.shareUser = item.shareUser;
    this.collect = item.collect;
  }


  update(item: IBaseListItem){
    this.chapterName = item.chapterName;
    this.author = item.author;
    this.id = item.id;
    this.niceDate = item.niceDate;
    this.superChapterName = item.superChapterName;
    this.title = item.title;
    this.shareUser = item.shareUser;
    this.collect = item.collect;
  }

  changeCollect() {
    this.collect = !this.collect
  }




}