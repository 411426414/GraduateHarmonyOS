import image from '@ohos.multimedia.image';

// 实现IDataSource接口的对象，用于瀑布流组件加载数据
export class WaterFlowDataSource<T> implements IDataSource {
  // 要加载的数据
  private dataArray: T[] = []
  // 数据更新的监听器对象
  private listeners: DataChangeListener[] = []

  constructor(element: T[]) {
    this.dataArray = element;
  }

  // 获取索引对应的数据
  getData(index: number): any {
    return this.dataArray[index]
  }

  // 获取数据总数
  totalCount(): number {
    return this.dataArray.length
  }

  // 给数据源中新增一个数组数据,并触发页面更新
  addData(index: number, data: T) {
    this.dataArray = this.dataArray.concat(data);
    this.notifyDataAdd(index)
  }

  // 更新数据源中的一个数组数据,并触发页面更新
  pushData(index: number, data: T) {
    this.dataArray.push(data)
    this.notifyDataAdd(this.dataArray.length - 1)
  }

  // 删除数据源中的一个数组数据,并触发页面更新
  deleteData(index: number) {
    this.dataArray.splice(index, 1);
    this.notifyDataDelete(index);
  }

  // 注册改变数据的控制器
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener)
    }
  }

  // 注销改变数据的控制器
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener)
    if (pos >= 0) {
      this.listeners.splice(pos, 1)
    }
  }

  // 通知控制器数据重新加载
  notifyDataReload(): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataReloaded()
    })
  }

  // 通知控制器数据增加
  notifyDataAdd(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      // listener.onDataAdded(index)
      listener.onDataReloaded()
    })
  }

  // 通知控制器数据变化
  notifyDataChange(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      // listener.onDataChanged(index)
      listener.onDataReloaded()
    })
  }

  // 通知控制器数据删除
  notifyDataDelete(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      // listener.onDataDeleted(index)
      listener.onDataReloaded()
    })
  }

  // 通知控制器数据位置变化
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataMoved(from, to)
    })
  }
}