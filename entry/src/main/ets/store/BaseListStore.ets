/**
 * @file BaseListStore.ets
 * @description
 * @author liushun
 * @created 2025/9/15 20:08
 * @lastModified 2025/9/15 20:08
 */

import {IBaseListItem} from "../Interface/index";

@ObservedV2
export default class BaseListStore<T extends IBaseListItem> {

  @Trace list: Array<T> = [];
  pageIndex: number = 0;
  initPageIndex: number = 0;
  @Trace hasMore: boolean = true;

  @Trace isRefresh: boolean = false;
  @Trace isLoading: boolean = false;
  @Trace initLoad: boolean = false;


  constructor(initPageIndex: number = 0) {
    this.initPageIndex = initPageIndex;
  }


  setList (list: Array<T>){
    this.list = list;
  }

  setPageIndex (index: number){
    this.pageIndex = index;
  }

  setHasMore (flag: boolean) {
    this.hasMore = flag;
  }

  setIsRefresh (flag: boolean) {
    this.isRefresh = flag;
  }

  setIsLoading (flag: boolean) {
    this.isLoading = flag;
  }

  setIsInitLoad (flag: boolean) {
    this.initLoad = flag;
  }

  createItemStoreInstance (item: T): T {
		return item;
	}

  async initList() {
    if(this.initLoad){
      return;
    }
    this.setIsInitLoad(true);
    const res  = await this.getList(this.initPageIndex);

    res.forEach((item: T)=>{
      this.list.push(this.createItemStoreInstance(item))
    })

    if(res.length > 0){
      this.setPageIndex(this.initPageIndex+1);
      this.setHasMore(true);
    }else{
      this.setHasMore(false);
    }
    this.setIsInitLoad(false)
  }

  async refresh() {

    if(this.isRefresh){
      return;
    }

    this.setIsRefresh(true);

    try {
      const res  = await this.getList(this.initPageIndex);
      res.forEach((item, index)=>{
        if(this.list?.[index]){
          this.list[index].update(item);
        }else{
          this.list[index] = this.createItemStoreInstance(item);
        }
      })
      this.list = this.list.slice(0, res.length);
      if(res.length > 0){
        this.setPageIndex(this.initPageIndex+1);
        this.setHasMore(true);
      }else{
        this.setHasMore(false);
      }
      this.setIsRefresh(false)
    }catch (e){
      console.log(e)
      this.setIsRefresh(false)
    }
  }

  async loadMore() {
    if(this.isLoading){
      return
    }

    this.setIsLoading(true);
    const res = await this.getList(this.pageIndex);

    res.forEach((item)=>{
      this.list.push(this.createItemStoreInstance(item))
    })

    if(res.length > 0){
      this.setPageIndex(this.pageIndex+1)
      this.setHasMore(true);
    }else{
      this.setHasMore(false);
    }
    this.setIsLoading(false)
  }

  async getList(page: number = 0): Promise<Array<T>> {
    return [];
  }



}