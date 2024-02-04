@Component
export default struct EmptyComponent {
  build() {
    Flex({
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center,
      direction: FlexDirection.Column,
    }) {
      Image($r('app.media.img'))
        .width(132)
        .height(132)
      Text('暂无数据')
        .fontSize(10)
        .margin({ top: 10 })
    }
    .width('100%')
    .height('50%')
  }
}