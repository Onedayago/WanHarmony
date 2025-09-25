/**
 * @file AccountPage.ets
 * @description
 * @author liushun
 * @created 2025/9/16 20:15
 * @lastModified 2025/9/16 20:15
 */
import { CustomListItem } from "../components";
import { IBaseListItem } from "../Interface";
import {AccountStore, AccountArticleListStore} from "../store/index"

class RefreshParams {
  isRefresh: boolean = false;
}

@ComponentV2
export default struct AccountPage{

  @Local accountStore: AccountStore = new AccountStore();

  aboutToAppear(): void {
    this.accountStore.getTabList();
  }

  loadMore = (index: number) => {
    console.log(index.toString())
    this.accountStore.tabList[index].loadMore();
  }

  refresh = (index: number) => {
    this.accountStore.tabList[index].refresh();
  }



  @Builder
  renderItem (obj: RepeatItem<IBaseListItem>) {
    CustomListItem({
      item: {
        topLeft: obj.item.shareUser,
        topRight: obj.item.niceDate,
        content: obj.item.title,
        bottomLeft: obj.item.superChapterName+'/'+obj.item.chapterName,
      }
    })
  }

  @Builder
  renderList (list: IBaseListItem []) {
    Repeat<IBaseListItem>(list)
      .each((obj: RepeatItem<IBaseListItem>)=>{
        this.renderItem(obj)
      })
      .key((obj: IBaseListItem) => obj.id.toString())
  }

  @Builder
  renderFooter (params: RefreshParams) {
    if(params.isRefresh){
      ListItem(){
        LoadingProgress()
          .width(25)
          .height(25)
          .color(Color.Blue)
          .alignSelf(ItemAlign.Center)
      }
      .width('100%')
    }
  }

  build() {
    Stack(){
      if(this.accountStore.isLoading){
        Progress({ value: 0, type: ProgressType.Ring,})
          .width(50)
          .height(50)
          .style({
            status: ProgressStatus.LOADING
          })
          .alignSelf(ItemAlign.Center)
      }else{
        Tabs({ barPosition: BarPosition.Start }) {
          Repeat<AccountArticleListStore>(this.accountStore.tabList)
            .each((obj: RepeatItem<AccountArticleListStore>) => {
              TabContent() {
                if(obj.item.initLoad){
                  Progress({ value: 0, type: ProgressType.Ring,})
                    .width(50)
                    .height(50)
                    .style({
                      status: ProgressStatus.LOADING
                    })
                    .alignSelf(ItemAlign.Center)
                }else{
                  Refresh({
                    refreshing: obj.item.isRefresh
                  }){
                    List(){
                      this.renderList(obj.item.list)
                      this.renderFooter({isRefresh: obj.item.isLoading})
                    }
                    .onReachEnd(()=>this.loadMore(obj.index))
                  }
                  .onRefreshing(()=>this.refresh(obj.index))
                  .height('100%')
                  .width('100%')
                }
              }
              .tabBar(obj.item.tabName)
              .align(Alignment.TopStart)
              .height('100%')
              .width('100%')
            })
            .key((obj: AccountArticleListStore) => obj.tabId+'')
        }
        .barMode(BarMode.Scrollable, {
          nonScrollableLayoutStyle: LayoutStyle.ALWAYS_AVERAGE_SPLIT
        })
        .height('100%')
        .width('100%')
      }

    }
    .height('100%')
    .width('100%')
  }
}