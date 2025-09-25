/**
 * @file SquareListStore.ets
 * @description 
 * @author liushun
 * @created 2025/9/16 19:24
 * @lastModified 2025/9/16 19:24
 */


import { IHomeBanner, IBaseListItem } from "../Interface";
import BaseListStore from "./BaseListStore";
import { getBanner, getSquareList } from "../service";
import HomeItemStore from "./BaseItemStore";

@ObservedV2
export default class SquareListStore extends BaseListStore<IBaseListItem>{

  @Trace banner: IHomeBanner[]|undefined;

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
    return new HomeItemStore(item);
  }

  async getList(page: number = 0): Promise<Array<IBaseListItem>> {
    try {
      const res = await getSquareList(page);
      return res.datas;
    }catch (e){

    }
    return [];
  }


}