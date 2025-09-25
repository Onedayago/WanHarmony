/**
 * @file LoginPage.ets
 * @description 
 * @author liushun
 * @created 2025/9/21 10:40
 * @lastModified 2025/9/21 10:40
 */
import { inputMethod } from '@kit.IMEKit'
import {LoginStore} from "../store/index";
import { router } from '@kit.ArkUI';
import { pushService } from '@kit.PushKit';
import { BaseLog } from '../util';

const TAG = 'LoginPage'

@Entry
@ComponentV2
export default struct LoginPage {

  @Local loginStore: LoginStore = new LoginStore();


  async login() {
    const res = await this.loginStore.login();
    if(res){
      this.getUIContext().getRouter().replaceUrl({
        url: 'pages/Index' // 目标url
      }, router.RouterMode.Single, (err) => {

      });
    }
  }

  @Builder
  renderName() {
    Text('用户名')
      .margin({
        bottom: 4
      })
    TextInput({
      placeholder: '用户名'
    })
      .type(InputType.Normal)
      .margin({
        bottom: 20
      })
  }

  @Builder
  renderPass() {
    Text('密码')
      .margin({
        bottom: 4
      })
    TextInput({
      placeholder: '密码'
    })
      .type(InputType.Normal)
      .margin({
        bottom: 20
      })
  }

  @Builder
  renderLoginBtn() {
    Button('登录')
      .alignSelf(ItemAlign.Center)
      .width('100%')
      .onClick(()=>{
        this.login();
      })
  }

  build() {
    Column() {
      Text('用户登录')
        .margin({
          bottom: 10
        })
      Text('请使用WanAndroid账号登录')
        .margin({
          bottom: 20
        })
      this.renderName()
      this.renderPass()
      this.renderLoginBtn()
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({
      top: 40,
      left: 20,
      right: 20,
    })
    .onClick(()=>{
      // 调用stopInputSession()方法关闭键盘
      inputMethod.getController().stopInputSession();
    })
  }
}