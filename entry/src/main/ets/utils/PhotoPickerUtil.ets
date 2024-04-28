import picker from '@ohos.file.picker';
import Logger from './Logger';
// import { BusinessError } from '@ohos.base'

const TAG = '[PhotoPickerUtil]';

/**
 从相册中获取图片路径
 @param callback，通过回调返回
 */
export function getPhotoPath(callback: Function) {
  const photoSelectOptions = new picker.PhotoSelectOptions();
  photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE; // 过滤选择媒体文件类型为IMAGE
  photoSelectOptions.maxSelectNumber = 5; // 选择媒体文件的最大数目
  const photoViewPicker = new picker.PhotoViewPicker();
  photoViewPicker.select(photoSelectOptions).then((photoSelectResult) => {
    let filePath = photoSelectResult.photoUris[0];
    Logger.info(TAG, 'filePath: ${filePath}');
    // 通过回调返回 filePath
    if (callback && typeof callback === 'function') {
      callback(null, filePath); // 第一个参数为错误对象，为 null 表示没有错误
    }
  }).catch((err) => {
    // 通过回调返回错误信息
    if (callback && typeof callback === 'function') {
      // 第二个参数为返回的数据，为 null 表示没有数据
      callback(err, null);
    }
    Logger.error(TAG, 'Invoke photoViewPicker.select failed, code is ${err.code}, message is ${err.message}');
  })
}