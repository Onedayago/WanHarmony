/**
 * @file AccountStore.ets
 * @description
 * @author liushun
 * @created 2025/9/16 19:34
 * @lastModified 2025/9/16 19:34
 */

import {ITabList, ITabItem} from "../Interface/index";
import {getTabList} from "../service/index";
import AccountArticleListStore from "./AccountArticleListStore";

@ObservedV2
export default class AccountStore {

  @Trace tabList: AccountArticleListStore [] = []
  @Trace isLoading: boolean = false;

  setIsLoading(flag: boolean){
    this.isLoading = flag;
  }

  async getTabList () {
    try {
      this.setIsLoading(true)
      const res = await getTabList();
      res.forEach((item, index)=>{
        this.tabList[index] = new AccountArticleListStore(item)
        if(index === 0){
          this.tabList[index].initList();
        }
      })
      this.setIsLoading(false)

    }catch (e){
      this.setIsLoading(false)
    }
  }


}