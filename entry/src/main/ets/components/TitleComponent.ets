@Component
export default struct TitleComponent {
  @Prop title: string
  isBack = false

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
      Image(this.isBack ? $r('app.media.right_arrow') : '')
        .width(22).height(22).objectFit(ImageFit.ScaleDown)
      Text(this.title).fontSize(20)
        .fontColor('rgb(1,23,73)')
        .fontWeight(FontWeight.Bold)

      Text('').width(22).height(22)
    }
    .padding({ right: 20, left: 20, top: 12, bottom: 12 })
  }
}