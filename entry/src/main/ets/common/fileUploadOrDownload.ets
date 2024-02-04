import axios, { AxiosProgressEvent } from '@ohos/axios';
import fs from '@ohos.file.fs';

export function DownloadFile(filePathName) {
  let filePath = getContext(this).cacheDir + '/c72dbd50f8ec856f1eab60e64ec5494a.jpg';
  // 下载。如果文件已存在，则先删除文件。
  try {
    fs.accessSync(filePath);
    fs.unlinkSync(filePath);
  } catch (err) {
  }

  return axios({
    url: 'https://gzh.411426414.top/uploads/20230904/c72dbd50f8ec856f1eab60e64ec5494a.jpg',
    method: 'get',
    context: getContext(this),
    filePath: filePath,
    onDownloadProgress: (progressEvent: AxiosProgressEvent): void => {
      let progress = progressEvent && progressEvent.loaded && progressEvent.total ? Math.ceil(progressEvent.loaded / progressEvent.total * 100) : 0
      // 打印下载进度
      console.info("progress: " + progress)
    }
  })
}