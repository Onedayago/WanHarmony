/**
 * @file HomePage.ets
 * @description
 * @author liushun
 * @created 2025/9/14 14:13
 * @lastModified 2025/9/14 14:13
 */


import { IHomeBanner, IHomeList, IBaseListItem } from "../Interface";
import {HomeListStore} from "../store/index"
import {CustomListItem} from "../components/index";


@ComponentV2
export default struct HomePage{

  @Local homeStore: HomeListStore = new HomeListStore();

  aboutToAppear(): void {
    this.homeStore.getBanner();
    this.homeStore.initList();

  }

  loadMore = () => {
    this.homeStore.loadMore();
  }

  refresh = () => {
    this.homeStore.refresh();
  }

  @Builder
  renderHeader () {
    ListItem(){
      Swiper(){
        ForEach(this.homeStore.banner, (item: IHomeBanner) => {
          Image(item.imagePath)
            .height(250)
            .width('100%')
        }, (item: IHomeBanner) => item.id.toString())
      }
    }
  }

  @Builder
  renderItem (obj: RepeatItem<IBaseListItem>) {
    CustomListItem({
      item: {
        topLeft: obj.item.shareUser,
        topRight: obj.item.niceDate,
        content: obj.item.title,
        bottomLeft: obj.item.superChapterName+'/'+obj.item.chapterName,
        collect: obj.item.collect,
      },
      collectFuc: () => {
        this.homeStore.list[obj.index].changeCollect();
      }
    })

  }

  @Builder
  renderList () {
    Repeat<IBaseListItem>(this.homeStore.list)
      .each((obj: RepeatItem<IBaseListItem>)=>{
        this.renderItem(obj)
      })
      .key((obj: IBaseListItem) => obj.id.toString())
  }

  @Builder
  renderFooter () {
    if(this.homeStore.isLoading){
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
      if(this.homeStore.initLoad){
        Progress({ value: 0, type: ProgressType.Ring,})
          .width(50)
          .height(50)
          .style({
            status: ProgressStatus.LOADING
          })
          .alignSelf(ItemAlign.Center)
      }else{
        Refresh({
          refreshing: this.homeStore.isRefresh
        }){
          List(){
            this.renderHeader()
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