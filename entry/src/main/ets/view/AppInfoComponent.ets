import router from '@ohos.router';
import { ListItemData } from '../common/bean/ListItemData';
import { CommonConstants } from '../common/constants/CommonConstants';
import AboutViewModel from '../viewmodel/AboutViewModel';

/**
 * AppInfo component shows the relevant information of the application.
 */
@Entry
@Component
export struct AppInfoComponent {
  @State currentBreakPoint: string = CommonConstants.BREAK_POINT_SM;

  build() {
    Column() {
      this.Title()

      Scroll() {
        GridRow({
          columns: {
            sm: CommonConstants.GRID_ROW_SM,
            md: CommonConstants.GRID_ROW_MD,
            lg: CommonConstants.GRID_ROW_LG
          },
          gutter: { x: CommonConstants.GUTTER_X },
          breakpoints: { value: CommonConstants.BREAK_POINT }
        }) {
          GridCol({
            span: {
              sm: CommonConstants.SPAN_SM,
              md: CommonConstants.SPAN_MD,
              lg: CommonConstants.SPAN_LG
            },
            offset: {
              sm: CommonConstants.OFFSET_SM,
              md: CommonConstants.OFFSET_MD,
              lg: CommonConstants.OFFSET_LG
            }
          }) {
            Column() {
              Row() {
                Column() {
                  Image($r('app.media.ic_logo'))
                    .height($r('app.float.image_height'))
                    .width($r('app.float.image_width'))
                    .borderRadius($r('app.float.icon_radius'))
                  Text($r('app.string.icon_name'))
                    .fontSize($r('app.float.name_text_size'))
                    .fontColor($r('app.color.text'))
                    .fontWeight(CommonConstants.FONT_WEIGHT)
                    .padding({ top: $r('app.float.name_text_padding_top') })
                  Text($r('app.string.version_label', CommonConstants.APP_VERSION))
                    .fontSize($r('app.float.version_text_size'))
                    .fontColor($r('app.color.text_opacity'))
                }
                .alignItems(HorizontalAlign.Center)
                .align(Alignment.Center)
              }
              .layoutWeight(this.currentBreakPoint === CommonConstants.BREAK_POINT_LG ?
              CommonConstants.ROW_LG_WEIGHT : CommonConstants.ROW_WEIGHT)

              Flex({
                direction: FlexDirection.Column,
                justifyContent: FlexAlign.SpaceBetween
              }) {
                ListBox({ appInfoData: AboutViewModel.getAppInfo() })

                Column() {
                  Row() {
                    Text($r('app.string.user_protocol'))
                      .fontSize($r('app.float.bottom_font_size'))
                      .fontColor($r('app.color.text_link'))
                      .onClick(() => this.openAgreementPage())
                    Text($r('app.string.and'))
                      .fontSize($r('app.float.bottom_font_size'))
                      .fontColor($r('app.color.text_opacity'))
                    Text($r('app.string.privacy_statement'))
                      .fontSize($r('app.float.bottom_font_size'))
                      .fontColor($r('app.color.text_link'))
                      .onClick(() => this.openPrivacyPage())
                  }

                  Text($r('app.string.copyright'))
                    .fontSize($r('app.float.bottom_font_size'))
                    .fontColor($r('app.color.text_opacity'))
                  Text($r('app.string.tech_support'))
                    .fontSize($r('app.float.bottom_font_size'))
                    .fontColor($r('app.color.text_opacity'))
                }
                .width(CommonConstants.TECH_COLUMN_WIDTH_PERCENT)
                .alignItems(HorizontalAlign.Center)
                .align(Alignment.Bottom)
                .margin({
                  bottom: $r('app.float.bottom_padding_bottom'),
                  top: $r('app.float.tech_support_margin_top')
                })
              }
              .layoutWeight(this.currentBreakPoint === CommonConstants.BREAK_POINT_LG ?
              CommonConstants.FLEX_LG_WEIGHT : CommonConstants.FLEX_WEIGHT)
            }
          }
        }
        .onBreakpointChange(point => {
          this.currentBreakPoint = point;
        })
        .margin({
          left: $r('app.float.grid_row_margin_left'),
          right: $r('app.float.grid_row_margin_right')
        })
        .height(CommonConstants.SCROLL_HEIGHT_PERCENT)
        .constraintSize({ minHeight: $r('app.float.scroll_min_height') })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(CommonConstants.SCROLL_WEIGHT)
    }
    .backgroundColor($r('app.color.page_background'))
  }

  openAgreementPage(): void {
    router.pushUrl({
      url: CommonConstants.AGREEMENT_PAGE
    });
  }

  openPrivacyPage(): void {
    router.pushUrl({
      url: CommonConstants.PRIVACY_PAGE
    });
  }

  @Builder Title() {
    Row() {
      Image($r('app.media.ic_back'))
        .width($r('app.float.image_size'))
        .height($r('app.float.image_size'))
        .margin({
          left: $r('app.float.image_margin_left'),
          right: $r('app.float.image_margin_right')
        })
        .onClick(() => {
          router.back();
        })

      Text($r('app.string.title_name'))
        .fontSize($r('app.float.title_text_font_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(CommonConstants.FONT_WEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }
}

@Component
struct ListBox {
  private appInfoData: Array<ListItemData> = AboutViewModel.getAppInfo()

  build() {
    Column() {
      List() {
        ForEach(this.appInfoData, (item: ListItemData) => {
          ListItem() {
            Column() {
              AppInfoItem({
                appInfoItem: item
              })
              Divider()
                .color($r('app.color.divider'))
                .strokeWidth(CommonConstants.DIVIDER_STROKE_WIDTH)
                .margin({
                  left: $r('app.float.list_padding_left'),
                  right: $r('app.float.list_padding_left')
                })
            }
          }
        }, (item, index) => index + JSON.stringify(item))
      }
    }
    .backgroundColor(Color.White)
    .borderRadius($r('app.float.app_info_radius'))
  }
}

@Component
struct AppInfoItem {
  private appInfoItem: ListItemData;

  build() {
    Flex({
      direction: FlexDirection.Row,
      alignItems: ItemAlign.Center,
      justifyContent: FlexAlign.SpaceBetween
    }) {
      Text(this.appInfoItem.title)
        .fontSize($r('app.float.app_info_title_size'))
        .fontColor($r('app.color.text'))
        .fontWeight(CommonConstants.FONT_WEIGHT)
      Image(this.appInfoItem.icon)
        .objectFit(ImageFit.Contain)
        .height($r('app.float.app_info_image_height'))
        .width($r('app.float.app_info_image_width'))
        .align(Alignment.End)
    }
    .margin({
      left: $r('app.float.list_padding_left'),
      right: $r('app.float.list_padding_right')
    })
    .height($r('app.float.list_height'))
    .onClick(() => {
      // this.openDetailPage(this.appInfoItem)

      console.info("this.appInfoItem", JSON.stringify(this.appInfoItem))
    })
  }

  openDetailPage(itemData: ListItemData): void {
    let listData: Array<ListItemData> = [];
    switch (itemData.id) {
      case CommonConstants.ABOUT_US_ID:
        listData = AboutViewModel.getAboutUsInfo();
        break;
      case CommonConstants.CONTACT_ID:
        listData = AboutViewModel.getContactInfo();
        break;
      default:
        break;
    }

    // router.pushUrl({
    //   url: CommonConstants.DETAIL_PAGE,
    //   params: {
    //     title: itemData.title,
    //     data: listData
    //   }
    // });
  }
}
