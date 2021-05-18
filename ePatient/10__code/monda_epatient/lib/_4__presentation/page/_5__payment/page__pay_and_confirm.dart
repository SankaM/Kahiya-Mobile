import 'package:monda_epatient/_0__infra/asset.dart';
import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common_widget/abstract_page_with_background_and_content.dart';

class PayAndConfirmPage extends AbstractPageWithBackgroundAndContent {
  PayAndConfirmPage() : super(
    title: TextString.page_title__pay_and_confirm,
    backgroundAsset: Asset.png__background01,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: false,
    showBottomNavigationBar: false,
    selectedIndexOfBottomNavigationBar: -1,
  );
}
