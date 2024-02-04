export class Banner {
  id?: number
  title?: string
  coverimage?: string
  type?: string
  briefcontent?: string
  exhibits_id?: number
  status?: string
  weigh?: number
  createtime?: number
  updatetime?: number
  status_text?: string
}

export class Notice {
  id?: number
  title?: string
  shortdesc?: string
  publiserby?: string
  briefcontent?: string
  publishdate?: string
  createtime?: number
  publishdata_text?: string
}

export class ClassInfo {
  id?: number
  name?: string
  key?: string
  status?: string
  wigth?: number
  createtime?: number
  updatetime?: number
  status_text?: string
}