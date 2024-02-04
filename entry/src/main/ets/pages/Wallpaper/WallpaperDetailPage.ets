import display from '@ohos.display'
import router from '@ohos.router'
import { WallpaperDetail } from '../../Api/wallpaper'
import { PyImg } from '../../viewmodel/PyImg'

const flagTag: string = '壁纸详情'

@Entry
@Component
struct WallpaperDetailPage {
  @State PyImg: PyImg = {}
  @State highs: number = 0
  @State wallpaper_id: number = 15 || router.getParams()["wallpaper_id"]

  aboutToAppear() {
    this.getWallpaperDetail()
  }

  getWallpaperDetail() {
    WallpaperDetail({ wallpaper_id: this.wallpaper_id })
      .then(res => {
        let PyImg = res.data.image
        res.data.image = (PyImg.indexOf('https') != -1 || PyImg.indexOf('http') != -1) ? PyImg : 'https://gzh.411426414.top' + PyImg
        this.PyImg = res.data
      })
      .catch(err => {
        console.info("err", JSON.stringify(err))
      })
  }

  build() {
    Column() {
      Image(this.PyImg.image)
        .width('95%')
        .objectFit(ImageFit.Contain)
        .borderRadius(15)
      Button('设置')
    }
    .width('100%')
  }
}


// Image(this.PyImg.image)
//   .width('100%')
//   .autoResize(true)
//   .onComplete(callback => {
//     //回调信息
//     console.log("---" + callback.width + "  " + callback.height + "  " + callback.componentWidth + "  " + callback.componentHeight);
//     let play = display.getDefaultDisplaySync();
//     this.highs = px2vp(play.width / 750 * 520);
//   })
//   .height(this.highs)