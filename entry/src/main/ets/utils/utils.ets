//获取当前星期
export function getDay() {
  let days = new Date().getDay()
  return '星期' + ['一', '二', '三', '四', '五', '六', '日'][days - 1]
}

//获取当前时间
export function getDate() {
  return new Date(+new Date() + 8 * 3600 * 1000)
    .toISOString()
    .replace(/T/g, ' ')
    .replace(/\.[\d]{3}Z/, '')
    .substring(0, 10)
    .replace(/(\d{4})\-(\d{2})\-(\d{2})/, '$1年$2月$3日')
}
// 时间戳转日期
export function TimestampToDate(value) {
  return new Date(value * 1000)
    .toISOString()
    .replace(/T/g, ' ')
    .replace(/\.[\d]{3}Z/, '')
  // .substring(0, 10)
  // .replace(/(\d{4})\-(\d{2})\-(\d{2}) (\d{2}):(\d{2}):(\d{2})/, '$1年$2月$3日 $4:$5:$6')
}


import picker from '@ohos.file.picker';
import Logger from './Logger';

export async function fileSelect(): Promise<string> {
  let photoSelectOptions = new picker.PhotoSelectOptions();
  photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
  photoSelectOptions.maxSelectNumber = 1;
  let photoPicker = new picker.PhotoViewPicker();
  try {
    let photoSelectResult = await photoPicker.select(photoSelectOptions);
    if (photoSelectResult && photoSelectResult.photoUris && photoSelectResult.photoUris.length > 0) {
      let imgUri = photoSelectResult.photoUris[0];
      if (imgUri.indexOf('media/image') < 0) {
        // showToast($r('app.string.prompt_select_img'));
        return '';
      }
      return imgUri;
    } else {
      return '';
    }
  } catch (err) {
    Logger.error('SelectedImage failed', JSON.stringify(err));
    return '';
  }
}