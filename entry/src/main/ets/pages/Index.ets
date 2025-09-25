

import HomePage from "./HomePage";
import SquarePage from "./SquarePage";
import AccountPage from "./AccountPage";
import { router } from "@kit.ArkUI";
import { LoginStore } from "../store";
import { BaseLog, PreferencesUtil} from "../util/index";
import {setCookie} from "../service//Http";

const Tag = 'IndexPage';

const Tab = ['tab_home', 'tab_square', 'tab_account'];

@Entry
@ComponentV2
struct Index {

  @Local loginStore: LoginStore = new LoginStore();

  @Local tabActiveName: string = Tab[0];

  pathStack: NavPathStack = new NavPathStack();

  async aboutToAppear(): Promise<void> {

  }

  setTabActiveName(name: string) {
    this.tabActiveName = name;
  }

  @Builder
  renderTabBar(name: string = Tab[0]) {
    Flex({direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center}){
      Image($r(`app.media.${name}`))
        .width(20)
        .height(20)
        .margin({
          bottom: 5
        })
      Text($r(`app.string.${name}`))
        .fontColor(this.tabActiveName === name?'red':'')
    }
    .alignSelf(ItemAlign.Center)
  }

  build() {
    Navigation(this.pathStack){
      Tabs(){
        TabContent(){
          HomePage()
        }
        .tabBar(this.renderTabBar(Tab[0]))
        TabContent(){
          SquarePage()
        }.tabBar(this.renderTabBar(Tab[1]))
        TabContent(){
          AccountPage()
        }.tabBar(this.renderTabBar(Tab[2]))
      }
      .barPosition(BarPosition.End)
      .onChange((index)=>{
        this.setTabActiveName(Tab[index]);
      })
    }
    .mode(NavigationMode.Auto)
    .hideToolBar(true)
  }
}