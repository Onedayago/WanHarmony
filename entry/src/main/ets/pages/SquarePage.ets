/**
 * @file SquarePage.ets
 * @description
 * @author liushun
 * @created 2025/9/16 19:20
 * @lastModified 2025/9/16 19:20
 */

import { IHomeBanner, IHomeList, IBaseListItem } from "../Interface";
import {SquareListStore} from "../store/index"
import {CustomListItem} from "../components/index";


@ComponentV2
export default struct SquarePage{

  @Local squareStore: SquareListStore = new SquareListStore();

  aboutToAppear(): void {
    this.squareStore.getBanner();
    this.squareStore.initList();

  }

  loadMore = () => {
    this.squareStore.loadMore();
  }

  refresh = () => {
    this.squareStore.refresh();
  }


  @Builder
  renderItem (obj: RepeatItem<IBaseListItem>) {
    CustomListItem({
      item: {
        topLeft: obj.item.shareUser,
        topRight: obj.item.niceDate,
        content: obj.item.title,
        bottomLeft: obj.item.superChapterName+'/'+obj.item.chapterName,
        collect: false,
      }
    })
  }

  @Builder
  renderList () {
    Repeat<IBaseListItem>(this.squareStore.list)
      .each((obj: RepeatItem<IBaseListItem>)=>{
        this.renderItem(obj)
      })
      .key((obj: IBaseListItem) => obj.id.toString())
  }

  @Builder
  renderFooter () {
    if(this.squareStore.isLoading){
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
    Column(){
      if(this.squareStore.initLoad){
        Progress({ value: 0, type: ProgressType.Ring,})
          .width(50)
          .height(50)
          .style({
            status: ProgressStatus.LOADING
          })
          .alignSelf(ItemAlign.Center)
      }else{
        Refresh({
          refreshing: this.squareStore.isRefresh
        }){
          List(){
            this.renderList()
            this.renderFooter()
          }
          .onReachEnd(this.loadMore)
        }
        .onRefreshing(this.refresh)
        .height('100%')
        .width('100%')
      }
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}
