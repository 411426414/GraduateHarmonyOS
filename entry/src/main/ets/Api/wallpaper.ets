import { gzhBaseUrl } from '../common/config'
import { axios as Axios } from '../utils/request'

// 获取壁纸列表 /api/graduation/wallpaper/list
/*zone_id	string	是	分区id
page	string	否	页索引
pagesize	string	否	每页多少行
*/

// 查看壁纸详情 wallpaper_id
export function WallpaperDetail(data?) {
  return Axios.get(gzhBaseUrl + `/api/graduation/wallpaper/detail`, { params: data })
}

// 查看下载次数 /api/graduation/wallpaper/selectDownloadNum
// 增加下载次数 /api/graduation/wallpaper/addDownloadNum
// 减少下载次数 /api/graduation/wallpaper/subDownloadNum
// 收藏壁纸 /api/graduation/wallpaper/collect wallpaper_id
// 下载壁纸 /api/graduation/wallpaper/download wallpaper_id