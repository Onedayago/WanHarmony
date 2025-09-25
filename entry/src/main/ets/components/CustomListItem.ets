/**
 * @file CustomListItem.ets
 * @description
 * @author liushun
 * @created 2025/9/15 19:51
 * @lastModified 2025/9/15 19:51
 */

import {ICustomListItem} from "../Interface/index";

@ComponentV2
export default struct ListHomeItem{

  @Param @Require item: ICustomListItem
  @Event collectFuc: () => void

  build() {
    Flex({direction: FlexDirection.Column}){
      Flex({direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween}){
        Text(this.item.topLeft)
        Text(this.item.topRight)
      }
      .margin({
        bottom: 10
      })
      Text(this.item.content)
        .margin({
          bottom: 10
        })
      Flex({direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween}){
        Text(this.item.bottomLeft)
        if(this.item.collect){
          Image($r('app.media.saveIcon'))
            .width(20)
            .height(20)
            .objectFit(ImageFit.Fill)
            .onClick(this.collectFuc)
        }else{
          Image($r('app.media.unSaveIcon'))
            .width(20)
            .height(20)
            .objectFit(ImageFit.Fill)
            .onClick(this.collectFuc)
        }

      }
      .margin({
        bottom: 10
      })

    }
    .padding({
      bottom: 0,
      top: 10,
      left: 10,
      right: 10,
    })
    .borderStyle({
      top: BorderStyle.Solid,
    })
    .border({
      color: Color.Black,
    })
    .borderWidth({
      bottom: 0.1
    })
  }
}