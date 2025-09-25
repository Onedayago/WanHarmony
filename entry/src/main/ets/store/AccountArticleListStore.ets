/**
 * @file TabStore.ets
 * @description
 * @author liushun
 * @created 2025/9/16 19:57
 * @lastModified 2025/9/16 19:57
 */

import { IBaseListItem, IHomeList, ITabItem } from "../Interface";
import BaseListStore from "./BaseListStore";
import BaseItemStore from "./BaseItemStore";
import { getTabArticleList } from "../service";

@ObservedV2
export default class AccountArticleListStore extends BaseListStore<IBaseListItem>{

  tabId: number = 0;
  tabName: string = '';

  constructor(tab: ITabItem) {
    super(1)
    this.tabId = tab.id;
    this.tabName = tab.name;
  }

  createItemStoreInstance(item: IBaseListItem): IBaseListItem {
    return new BaseItemStore(item);
  }

  async getList(page: number = 0): Promise<Array<IBaseListItem>> {
    try {
      const res = await getTabArticleList(this.tabId, page);
      return res.datas;
    }catch (e){

    }
    return [];
  }

}