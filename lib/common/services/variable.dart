import 'package:mydairy/dairy_users_dashboard/home/home_screen.dart';
import 'package:mydairy/dairy_users_dashboard/master/routes/routes_screen.dart';
import 'package:mydairy/export.dart';
import '../../dairy_users_dashboard/fat_snf_chart/cow_snf_chart/cow_snf&fat_chart.dart';
import '../../dairy_users_dashboard/fat_snf_chart/cow_snf_chart/upload_chart_screen.dart';
import '../../dairy_users_dashboard/fat_snf_chart/snf_fat_chart_screen.dart';
import '../../dairy_users_dashboard/master/master_scr_all/help_complaint_screen.dart';
import '../../dairy_users_dashboard/master/master_scr_all/help_screen.dart';
import '../../dairy_users_dashboard/master/master_scr_all/membership_screen.dart';
import '../../dairy_users_dashboard/master/master_screen.dart';
import '../../dairy_users_dashboard/master/rules_permission/rules_Permission_screen.dart';
import '../../dairy_users_dashboard/master/transport_management/transport_screen.dart';
import '../../dairy_users_dashboard/milk_buy_sell/milk_buy_screen.dart';
import '../../dairy_users_dashboard/product/product_brand/product_brand.dart';
import '../../dairy_users_dashboard/product/product_group/product_group_screen.dart';
import '../../dairy_users_dashboard/product/product_list/product_list_screen.dart';
import '../../dairy_users_dashboard/product/product_screen.dart';
import '../../dairy_users_dashboard/setting/setting_screen.dart';
import '../../dairy_users_dashboard/shopping_list/shopping/shopping_screen.dart';
import '../../dairy_users_dashboard/view_by_entry/view_entry_screen.dart';
import '../../dairy_users_dashboard/khata/khata_screen.dart';
import '../widgets/function.dart';
import 'model.dart';

List images = [
  "https://imgscf.slidemembers.com/docs/1/1/332/milk_ppt_background_images_331371.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_AAAuC_PvrWaaZnLdr0yHEXSw76TX4cm3KzdJsJiXYw&s",
  "https://imgscf.slidemembers.com/docs/1/1/332/milk_ppt_background_images_331371.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_AAAuC_PvrWaaZnLdr0yHEXSw76TX4cm3KzdJsJiXYw&s",
];

List<HomeImage> homeImage = [
  HomeImage(
      image: Img.farmer_profile_btn,
      name: "Profile",
      ontap: FunctionClass.navigateToProfile),
  HomeImage(
      image: Img.farmer_tnx_btn,
      name: "Transaction",
      ontap: FunctionClass.navi),
  HomeImage(
      image: Img.farmer_entry_btn,
      name: "Entry",
      ontap: FunctionClass.navigateToRecods),
  HomeImage(
      image: Img.farmer_entry_btn,
      name: "Entry",
      ontap: FunctionClass.navigateToRecods),
  HomeImage(
      image: Img.farmer_products_btn,
      name: "Product",
      ontap: FunctionClass.navi),
];
final masterItemsProvider = StateProvider.autoDispose((ref) {
  List<MasterItem> masterItems = [
    MasterItem(
        image: Img.need_help, txt: Txt.need_help, page: const HelpScreen()),
    MasterItem(
        image: Img.complane,
        txt: "Help/Complaint",
        page: const HelpAndComplaint()),
    MasterItem(
        image: Img.membership,
        txt: 'Membership',
        page: const MemberShipScreen()),
    if (ref.watch(childDairyVAlueProvider) == false)
      MasterItem(
          image: Img.roles_permission,
          txt: "Roles & Permission",
          page: const RulesAndPermissionScreen()),
    if (ref.watch(childDairyVAlueProvider) == false)
      MasterItem(
          image: Img.transport,
          txt: "Transporters",
          page: const TransPorterManagementScreen()),
    if (ref.watch(childDairyVAlueProvider) == false)
      MasterItem(image: Img.routes, txt: "Routes", page: const RoutesScreen()),
  ];
  return masterItems;
});

List<MasterItem> productIcon = [
  MasterItem(
      image: Img.show_list,
      txt: "Product List",
      page: const ProductListScreen()),
  MasterItem(
      image: Img.product_groups,
      txt: "Product Group",
      page: const ProductGroupScreen()),
  MasterItem(
      image: Img.product_brands,
      txt: "Product Brand",
      page: const ProductBrandScreen()),
  // MasterItem(
  //     image: Img.product_sell,
  //     txt: "Product Sell",
  //     page: const ProductSellScreen())
];

List<MasterItem> homeicons = [
  MasterItem(
      txt: Txt.milk_buy, image: Img.milk_buy, page: const MilkBuyScreen()),
  MasterItem(
      txt: Txt.milk_sell,
      image: Img.milk_sell,
      page: const MilkBuyScreen(buyerValue: 1)),
  MasterItem(
      txt: Txt.userManagment,
      image: Img.customer,
      page: const CustomersScreen()),
  MasterItem(txt: "Khata", image: Img.search, page: const KhataScreen()),
  MasterItem(
      txt: "View_Entry_By_Date",
      image: Img.view_all_entry,
      page: const ViewByEntryScreen()),
  MasterItem(
      txt: Txt.shopping_list,
      image: Img.shopping_list,
      page: const ShoppingScreen()),
  MasterItem(
      txt: Txt.fat_chart,
      image: Img.fat_chart,
      page: const SnfAndFatChartScreen()),
  MasterItem(txt: "Master", image: Img.master, page: const MasterScreen()),
  MasterItem(
      txt: "Product_Sell_and_Buyer",
      image: Img.product_buy_sell,
      page: const ProductScreen()),
  MasterItem(txt: "Setting", image: Img.setting, page: const SettingScreen()),
  MasterItem(
      txt: "Notification",
      image: Img.notification,
      page: const NotificationScreen()),
];
List<MasterItem> snfChartIcon = [
  MasterItem(
      txt: "COW SNF", image: Img.cow, page: const SnfChart(milkType: "Cow")),
  MasterItem(
      txt: "BUFFALO SNF",
      image: Img.buffalo,
      page: const SnfChart(milkType: "Buffalo")),
  MasterItem(
      txt: "MIX SNF", image: Img.cow, page: const SnfChart(milkType: "Mix")),
  MasterItem(
      txt: "UPLOAD CHART",
      image: Img.upload_chart,
      page: const UploadChartScreen()),
  MasterItem(txt: "DOWNLOAD SNF CHART", image: Img.download, page: null),
];
List<TxtModel> customerListTitle = [
  TxtModel(txt: "ID"),
  TxtModel(txt: "Name"),
  TxtModel(txt: "Phone_Number"),
  TxtModel(txt: "Action"),
];
List<TxtModel> switchData = [
  TxtModel(txt: Txt.online),
  TxtModel(txt: "Print_Receipt"),
  TxtModel(txt: "Automatic"),
  // TxtModel(txt: "Automatic_New"),
  TxtModel(txt: "Voice_on_milk_entry"),
];
List<TxtModel> dairyRateTxt = [
  TxtModel(txt: "Default_Dairy_Rate"),
  TxtModel(txt: "Fat_Rate"),
  TxtModel(txt: "Fixed_Price")
];
List<TxtModel> paymentTxt = [
  TxtModel(txt: "Cash"),
  TxtModel(txt: "Bank"),
  TxtModel(txt: "Cheque"),
];
List<TxtModel> rateTypeText = [
  TxtModel(txt: "Fat"),
  TxtModel(txt: "Fat/SNF"),
  TxtModel(txt: "CLR/Fat")
];

List<TxtModel> generalInfoText = [
  TxtModel(txt: "General"),
  TxtModel(txt: "Cow/Buffalo")
];
List<TxtModel> bonusDeductionText = [TxtModel(txt: "Off"), TxtModel(txt: "On")];
List<TxtModel> milkEntrytxt = [
  TxtModel(txt: "ID"),
  TxtModel(txt: "Name"),
  TxtModel(txt: "Weight"),
  TxtModel(txt: "Fat/SNF"),
  TxtModel(txt: "Rate"),
  TxtModel(txt: "Amount"),
  TxtModel(txt: "")
];
List<TxtModel> productBrandtxt = [
  TxtModel(txt: "Sr"),
  TxtModel(txt: "Name"),
  TxtModel(txt: "Category"),
  TxtModel(txt: "Action")
];
List<TxtModel> productgroputxt = [
  TxtModel(txt: "Sr"),
  TxtModel(txt: "Name"),
  TxtModel(txt: "Action")
];
List<TxtModel> eraseDatalist = [
  TxtModel(txt: "Date"),
  TxtModel(txt: "Session"),
  TxtModel(txt: "Total Weight"),
  TxtModel(txt: "Avg.Fat"),
  TxtModel(txt: "Total Amount")
];
List<TxtModel> milkentry = [TxtModel(txt: "Cow"), TxtModel(txt: "Buffalo")];

List<TxtModel> milkBuyTxt = [
  TxtModel(txt: "General"),
  TxtModel(txt: "Advance"),
  TxtModel(txt: "Landscap")
];
List<TxtModel> addCategaryTxt = [
  TxtModel(txt: "Farmer"),
  TxtModel(txt: "Buyer")
];
List<TxtModel> fontSizeText = [
  TxtModel(txt: "Normal"),
  TxtModel(txt: "Medium"),
  TxtModel(txt: "Large")
];
List<TxtModel> selectPrintText = [
  TxtModel(txt: "2 INCH"),
  TxtModel(txt: "3 INCH")
];
List<TxtModel> weightTxt = [
  TxtModel(txt: "Weight"),
  TxtModel(txt: "Quantity"),
  TxtModel(txt: "Liter")
];

List<TxtModel> automaticDigitTxt = [
  TxtModel(txt: "2 DIGIT"),
  TxtModel(txt: "3 DIGIT")
];

List settingField = [
  "WhatsApp Message",
  "Automatic Fat",
  // "Rate per KG",
  // "Fate Rate",
  // "SNF",
  // "Bonus"
];
