/**
 * 华为设备有限公司版权所有
 * 根据Apache许可证2.0版(“许可证”)进行许可;
 * 除非遵守许可，否则您不得使用此文件。
 * 您可以在以下网址获得许可证的副本
 * http://www.apache.org/licenses/LICENSE-2.0
 * 除非适用法律要求或书面同意，软件根据许可证分发的*是按“现状”分发的，
 * 不提供任何明示或暗示的保证或条件。
 * 请参阅许可证，了解具体的语言管理权限和许可证下的限制。
 */

/**
 * Common constants for all features.
 * 所有特性的公共常量
 */
export  class CommonConstants {
  static readonly READ_TIMEOUT: number = 5000;
  static readonly CONNECT_TIMEOUT: number = 5000;
  /**
   * The main ability tag.
   * 主Ability标签
   *
   */
  static readonly TAG_ABILITY: string = 'EntryAbility';

  /**
   * The login page tag.
   * 登录页面标签
   */
  static readonly TAG_LOGIN_PAGE: string = 'LoginPage';

  /**
   * The main page tag.
   *  主页面标签
   */
  static readonly TAG_MAIN_PAGE: string = 'MainPage';

  /**
   * The common utils tag.
   * 公用utils标签
   */
  static readonly TAG_COMMON_UTILS: string = 'CommonUtils';

  /**
   * The mine page list item cell tag.
   * 我的页面列表项单元格标记
   */
  static readonly TAG_LIST_ITEM: string = 'ListItem';

  /**
   * The mine page tag.
   * 我的页面标签
   */
  static readonly TAG_MINE_PAGE: string = 'MinePage';

  /**
   * Login text.
   * 登录文本
   */
  static readonly LOGIN_TEXT: string = 'login';

  /**
   * Toast duration.
   * 提示框持续时间
   */
  static readonly TOAST_DURATION: number = 3000;

  /**
   * Title text of the home page.
   * 主页的标题文本
   */
  static readonly HOME_TITLE: string = '首页';
  /**
   * Title text of the home page.
   * 定位页的标题文本
   */
  static readonly ADDRESS_TITLE: string = '定位';
  /**
   * Title text of the home page.
   * 咨询页的标题文本
   */
  static readonly ZIXUN_TITLE: string = '咨询';

  /**
   * Title text of the setting page.
   * 我的页的标题文本
   */
  static readonly MINE_TITLE: string = '我的';

  /**
   * Title text of the setting page.
   * 有轨电车页的标题文本
   */
  static readonly TRAM_TITLE: string = '有轨电车';

  /**
   * Home tab index.
   * 主页标签索引
   */
  static readonly HOME_TAB_INDEX: number = 0;

  /**
   * Mine tab index.
   * 有轨电车页标签索引
   */
  static readonly TRAM_TAB_INDEX: number = 1;
  /**
   * Home tab index.
   * 咨询页标签索引
   */
  static readonly ZIXUN_TAB_INDEX: number = 2;

  /**
   * Mine tab index.
   * 我的页标签索引
   */
  static readonly MINE_TAB_INDEX: number = 3;

  /**
   * Swiper cache count of the number 3.
   * Swiper刷缓存计数的数字3
   */
  static readonly SWIPER_CACHE_COUNT: number = 5;

  /**
   * Main page url.
   * 主页文件地址
   */
  static readonly MAIN_PAGE_URL: string = 'pages/MainPage';

  /**
   * Login page url.
   * 登录页文件地址
   */
  static readonly LOGIN_PAGE_URL: string = 'pages/LoginPage';

  /**
   * Break point sm of the tag.
   *
   */
  static readonly SM: string = 'sm';

  /**
   * Break point md of the tag.
   */
  static readonly MD: string = 'md';

  /**
   * Break point lg of the tag.
   */
  static readonly LG: string = 'lg';

  /**
   * Width condition sm filter.
   * sm宽度条件滤波器
   */
  static readonly WIDTH_CONDITION_SM: string = '(320vp<=width<520vp)';

  /**
   * Width condition md filter.
   * md宽度条件滤波器
   */
  static readonly WIDTH_CONDITION_MD: string = '(520vp<=width<840vp)';

  /**
   * Width condition lg filter.
   * lg宽度条件滤波器
   */
  static readonly WIDTH_CONDITION_LG: string = '(840vp<=width)';

  /**
   * Login page button id.
   * 登录页面按钮id
   */
  static readonly LOGIN_BUTTON_ID: string = 'loginButtonId';

  /**
   * Tablet device type.
   * 平板设备类型
   */
  static readonly TABLET_DEVICE_TYPE: string = 'tablet';


  /**
   * animation duration of tab content switching.
   */
  static readonly DURATION_PAGE = 50;

  /**
   * animation duration of tab content switching.
   */
  static readonly DURATION_ADS = 200;

  /**
   * height of head portrait.
   */
  static readonly HEIGHT_HEAD = 40;

  /**
   * height of carousel title.
   */
  static readonly HEIGHT_CAROUSEL_TITLE = 90;

  /**
   * fontSize of description.
   */
  static readonly FONT_SIZE_DESCRIPTION = 12;

  /**
   * font size of photo name.
   */
  static readonly FONT_SIZE_PHOTO_NAME = 14;

  /**
   * font size of sort title.
   */
  static readonly FONT_SIZE_SORT_TITLE = 16;

  /**
   * font size of unchecked title.
   */
  static readonly FONT_SIZE_UNCHECKED = 18;

  /**
   * font size of title.
   */
  static readonly FONT_SIZE_TITLE = 20;

  /**
   * font size of checked title.
   */
  static readonly FONT_SIZE_CHECKED = 24;

  /**
   * font size of tab page which content has only tab name.
   */
  static readonly FONT_SIZE_PAGE_CONTENT = 28;

  /**
   * thinner font.
   */
  static readonly FONT_WEIGHT_LIGHT = 400;

  /**
   * normal font.
   */
  static readonly FONT_WEIGHT_NORMAL = 500;

  /**
   * bold font.
   */
  static readonly FONT_WEIGHT_BOLD = 700;

  /**
   * page layout weight.
   */
  static readonly LAYOUT_WEIGHT = 1;

  /**
   * border angle.
   */
  static readonly BORDER_RADIUS = 12;

  /**
   * line height for more.
   */
  static readonly LINE_HEIGHT_MORE = 19;

  /**
   * line height for navigation.
   */
  static readonly LINE_HEIGHT_NAVIGATION = 28;

  /**
   * space of topBar.
   */
  static readonly SPACE_TOP_BAR = 16;

  /**
   * space of navigation.
   */
  static readonly SPACE_NAVIGATION = 8;

  /**
   * border width of head portrait.
   */
  static readonly WIDTH_HEAD_BORDER = 2;

  /**
   * width of head portrait.
   */
  static readonly WIDTH_HEAD = 40;

  /**
   * radius of head portrait.
   */
  static readonly RADIUS_HEAD = 20;

  /**
   * rolling duration.
   */
  static readonly SWIPER_TIME = 1500;

  /**
   * margin of play page.
   */
  static readonly MARGIN_PLAY_PAGE = 10;

  /**
   * margin of text bottom.
   */
  static readonly BOTTOM_TEXT = 4;

  /**
   * margin of banner top.
   */
  static readonly TOP_ADS = 12;

  /**
   * margin of navigation left.
   */
  static readonly LEFT_POSITION = '3%';

  /**
   * margin of banner left.
   */
  static readonly ADS_LEFT = 12;

  /**
   * top margin of picture name.
   */
  static readonly TOP_NAME = 8;

  /**
   * top margin of picture description.
   */
  static readonly TOP_DESCRIPTION = 4;

  /**
   * top margin of vote icon.
   */
  static readonly TOP_IMAGE_VOTE = 20;

  /**
   * top margin of head portrait.
   */
  static readonly TOP_HEAD = 40;

  /**
   * maximum width.
   */
  static readonly FULL_WIDTH = '100%';

  /**
   * maximum height.
   */
  static readonly FULL_HEIGHT = '100%';

  /**
   * width of play model.
   */
  static readonly WIDTH_PLAY = '95%';

  /**
   * width of tab page.
   */
  static readonly PAGE_WIDTH = '94.4%';

  /**
   * width of sort name.
   */
  static readonly WIDTH_SORT_NAME = '62.2%';

  /**
   * sort content width of all.
   */
  static readonly WIDTH_SORT = '92%';

  /**
   * sort content width of movie.
   */
  static readonly WIDTH_MOVIE_SORT = '90%';

  /**
   * width of picture.
   */
  static readonly WIDTH_PICTURE = '72%';

  /**
   * height of banner.
   */
  static readonly HEIGHT_BANNER = '27%';

  /**
   * width of vote icon.
   */
  static readonly WIDTH_VOTE = '8.9%';

  /**
   * width of back icon.
   */
  static readonly WIDTH_BACK_ICON = '6.7%';

  /**
   * top margin of sort.
   */
  static readonly MARGIN_TOP_SORT = '3.2%';

  /**
   * bottom margin of sort.
   */
  static readonly MARGIN_BOTTOM_SORT = '1.7%';

  /**
   * bottom margin of grid.
   */
  static readonly MARGIN_BOTTOM_GRID = '4.2%';

  /**
   * height of video.
   */
  static readonly WIDTH_VIDEO = '26.2%';

  /**
   * number of columns.
   */
  static readonly TWO_COLUMNS = '1fr 1fr';

  /**
   * number of rows.
   */
  static readonly TWO_ROWS = '1fr 1fr';

  /**
   * number of columns.
   */
  static readonly THREE_COLUMNS = '1fr 1fr 1fr';

  /**
   * number of rows.
   */
  static readonly THREE_ROWS = '1fr 1fr 1fr';

  /**
   * gap of columns.
   */
  static readonly GAP_COLUMNS = '2.2%';

  /**
   * height of grid.
   */
  static readonly HEIGHT_GRID = '45%';

  /**
   * height of movie description.
   */
  static readonly HEIGHT_DESCRIPTION = '12.3%';

  /**
   * height of top bar.
   */
  static readonly TOP_BAR_HEIGHT = '7.2%';

  /**
   * height of comment icon.
   */
  static readonly HEIGHT_COMMENT = '4.1%';

  /**
   * height of back icon.
   */
  static readonly HEIGHT_BACK_ICON = '3.1%';

  /**
   * horizontal position of comment.
   */
  static readonly OFFSET_COMMENT_X = '-5%';

  /**
   * vertical position of comment.
   */
  static readonly OFFSET_COMMENT_Y = '10%';

  /**
   * vertical position of description.
   */
  static readonly OFFSET_DESCRIPTION_Y = '45%';

  /**
   * start position.
   */
  static readonly START_POSITION = '0%';

  /**
   * video play page.
   */
  static readonly PLAY_PAGE = 'pages/PageVideo';

  /**
   * home page.
   */
  static readonly HOME_PAGE = 'pages/SwiperIndex';

  /**
   * The number of columns for SM device.
   */
  static readonly GRID_ROW_SM: number = 4;

  /**
   * The number of columns for MD device.
   */
  static readonly GRID_ROW_MD: number = 8;

  /**
   * The number of columns for LG device.
   */
  static readonly GRID_ROW_LG: number = 12;

  /**
   * The gutter of x direction device.
   */
  static readonly GUTTER_X: number = vp2px(12);

  /**
   * The span of page for SM device.
   */
  static readonly SPAN_SM: number = 4;

  /**
   * The span of page for MD device.
   */
  static readonly SPAN_MD: number = 6;

  /**
   * The span of page for LG device.
   */
  static readonly SPAN_LG: number = 8;

  /**
   * The offset of page for SM device.
   */
  static readonly OFFSET_SM: number = 1;

  /**
   * The offset of page for MD device.
   */
  static readonly OFFSET_MD: number = 1;

  /**
   * The offset of page for LG device.
   */
  static readonly OFFSET_LG: number = 2;

  /**
   * The weight of row for device.
   */
  static readonly ROW_WEIGHT: number = 4;

  /**
  * The weight of row for LG device.
  */
  static readonly ROW_LG_WEIGHT: number = 5;

  /**
   * The weight of flex for device.
   */
  static readonly FLEX_WEIGHT: number = 6;

  /**
   * The weight of flex for LG device.
   */
  static readonly FLEX_LG_WEIGHT: number = 5;

  /**
   * The break point for page.
   */
  static readonly BREAK_POINT: Array<string> = ['320vp', '600vp', '840vp'];

  /**
   * The break point of lg.
   */
  static readonly BREAK_POINT_LG: string = 'lg';

  /**
   * The break point of sm.
   */
  static readonly BREAK_POINT_SM: string = 'sm';

  /**
   * Font weight.
   */
  static readonly FONT_WEIGHT: number = 500;

  /**
   * Scroll weight.
   */
  static readonly SCROLL_WEIGHT: number = 1;

  /**
   * Application version example.
   */
  static readonly APP_VERSION: string = '1.0.0';

  /**
   * Detail page url.
   */
  static readonly DETAIL_PAGE: string = 'pages/DetailPage';

  /**
   * Agreement page url.
   */
  static readonly AGREEMENT_PAGE: string = 'pages/AgreementPage';

  /**
   * Privacy page url.
   */
  static readonly PRIVACY_PAGE: string = 'pages/PrivacyPage';

  /**
   * About us item id.
   */
  static readonly ABOUT_US_ID: number = 1;

  /**
   * Contact item id.
   */
  static readonly CONTACT_ID: number = 2;

  /**
   * Detail page default content row.
   */
  static readonly DETAIL_DEFAULT_ROW: number = 2;

  /**
   * This is key param of data.
   */
  static readonly KEY_PARAM_DATA: string = 'data';

  /**
   * This is key param of title.
   */
  static readonly KEY_PARAM_TITLE: string = 'title';

  /**
   * Detail column title text width percentage setting.
   */
  static readonly DETAIL_COLUMN_WIDTH_PERCENT: string = '100%';

  /**
   * Detail column height percentage setting.
   */
  static readonly DETAIL_COLUMN_HEIGHT_PERCENT: string = '100%';

  /**
   * Full width percent.
   */
  static readonly FULL_WIDTH_PERCENT: string = '100%';

  /**
   * Row width percentage setting.
   */
  static readonly ROW_WIDTH_PERCENT: string = '100%';

  /**
   * Scroll height percentage setting.
   */
  static readonly SCROLL_HEIGHT_PERCENT: string = '100%';

  /**
   * Tech Support column width percentage setting.
   */
  static readonly TECH_COLUMN_WIDTH_PERCENT: string = '100%';

  /**
   * Detail column list width percentage setting.
   */
  static readonly DETAIL_LIST_WIDTH_PERCENT: string = '93.3%';

  /**
   * Divider stroke width.
   */
  static readonly DIVIDER_STROKE_WIDTH: string = '0.5vp';
}