// import { BusinessError } from '@ohos.base';
import Logger from '../utils/Logger';
import { getPhotoPath } from '../utils/PhotoPickerUtil';

const TAG = '[OCRPage]';

@Entry
@Component
struct OCRPage {
  @State msg: string = "";
  @State imagePath: string = ''

  build() {
    Column({ space: 10 }) {
      Text("OCR获取到的数据为：" + this.msg)

      Button('从相册中选择照片')
        .margin(10)
        .onClick(() => {
          // 调用PhotoPickerUtil中的getPhotoPath获取选择图片的路径
          getPhotoPath((err, filePath: string) => {
            if (err) {
              Logger.error(TAG, "getPhotoPath:" + err)
            } else {
              this.imagePath = filePath;
              Logger.info(TAG, "filePath:" + filePath)
            }
          });
        })
      // 回显从相册中选择的照片
      Image(this.imagePath)
        .alt($r('app.media.icon'))// 使用alt，在图片加载成功前使用占位图
        .width(100)
        .height(100)
      Button("识别照片")
        .type(ButtonType.Capsule)
        .width("80%")
        .height(50)
        .margin(10)
        .onClick(() => {
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}