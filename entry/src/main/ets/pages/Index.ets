import { CommonConstants } from '../common/constants/CommonConstants';
import { StyleConstants } from '../common/constants/StyleConstants';
import HomePage from './HomePage';
import TramPage from './Tram/TramPage';
import ZixunPage from './Zixun/ZixunPage';
import MinePage from './Mine/MinePage';

/**
 * 首页显示“首页”和“我的页面”。
 * 用法:开发者定义页面并在TabContent中引用它们
 */
@Entry
@Component
struct Index {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;
  @State currentIndex: number = CommonConstants.HOME_TAB_INDEX

  build() {
    Tabs({
      barPosition: this.currentDeviceSize === CommonConstants.LG ? BarPosition.Start : BarPosition.End,
      index: this.currentIndex
    }) {
      TabContent() {
        if (this.currentIndex === CommonConstants.HOME_TAB_INDEX)
          HomePage()
      }
      .tabBar(this.TabBuilder(CommonConstants.HOME_TITLE, CommonConstants.HOME_TAB_INDEX, $r('app.media.ic_home_selected'), $r('app.media.ic_home_normal')))

      TabContent() {
        if (this.currentIndex === CommonConstants.TRAM_TAB_INDEX)
          TramPage()
      }
      .tabBar(this.TabBuilder(CommonConstants.TRAM_TITLE, CommonConstants.TRAM_TAB_INDEX, $r('app.media.ic_tram_selected'), $r('app.media.ic_tram_normal')))

      TabContent() {
        if (this.currentIndex === CommonConstants.ZIXUN_TAB_INDEX)
          ZixunPage()
      }
      .tabBar(this.TabBuilder(CommonConstants.ZIXUN_TITLE, CommonConstants.ZIXUN_TAB_INDEX, $r('app.media.ic_tram_selected'), $r('app.media.ic_tram_normal')))

      TabContent() {
        if (this.currentIndex === CommonConstants.MINE_TAB_INDEX)
          MinePage()
      }
      .tabBar(this.TabBuilder(CommonConstants.MINE_TITLE, CommonConstants.MINE_TAB_INDEX, $r('app.media.ic_mine_selected'), $r('app.media.ic_mine_normal')))
    }
    .barWidth(this.currentDeviceSize === CommonConstants.LG ? StyleConstants.BAR_WIDTH_LG : StyleConstants.FULL_PARENT)
    .barHeight(this.currentDeviceSize === CommonConstants.LG ? StyleConstants.BAR_HEIGHT_LG : StyleConstants.BAR_DEFAULT_HEIGHT)
    .vertical(this.currentDeviceSize === CommonConstants.LG)
    .backgroundColor('#cedbd9d9')
    .barMode(BarMode.Fixed)
    .scrollable(false)
    .onChange((index: number) => {
      this.currentIndex = index
      console.log('当前选中的tab索引：' + index)
    })
  }

  @Builder
  TabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width('25vp')
        .height('25vp')
      Text(title)
        .margin({ top: '4vp' })
        .fontSize('10vp')
        .fontColor(this.currentIndex === index ? "#1698CE" : '#6B6B6B')
    }
    .justifyContent(FlexAlign.Center)
    .height(StyleConstants.FULL_PARENT)
    .width(StyleConstants.FULL_PARENT)
  }
}