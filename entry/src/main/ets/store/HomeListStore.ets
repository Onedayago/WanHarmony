/**
 * @file HomeListStore.ets
 * @description
 * @author liushun
 * @created 2025/9/15 20:22
 * @lastModified 2025/9/15 20:22
 */

import { IHomeBanner, IBaseListItem } from "../Interface";
import BaseListStore from "./BaseListStore";
import { getBanner, getHomeList } from "../service";
import BaseItemStore from "./BaseItemStore";

@ObservedV2
export default class HomeListStore extends BaseListStore<IBaseListItem>{

  @Trace banner: IHomeBanner[] = [];

  constructor() {
    super();
  }

  setBanner ( banner: IHomeBanner[]){
    this.banner = banner;
  }

  async getBanner() {
    try {
      const res = await getBanner();
      this.setBanner(res);
    }catch (e){

    }
  }

  createItemStoreInstance(item: IBaseListItem): IBaseListItem {
    return new BaseItemStore(item);
  }

  async getList(page: number = 0): Promise<Array<IBaseListItem>> {
    try {
      const res = await getHomeList(page);
      return res.datas;
    }catch (e){

    }
    return [];
  }



}