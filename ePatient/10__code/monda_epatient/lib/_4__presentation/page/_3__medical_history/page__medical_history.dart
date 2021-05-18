import 'package:monda_epatient/_0__infra/text_string.dart';
import 'package:monda_epatient/_4__presentation/common/abstract_page.dart';

class MedicalHistoryPage extends AbstractPage {
  MedicalHistoryPage() : super(
    title: TextString.page_title__medical_history,
    usingSafeArea: true,
    showAppBar: false,
    showFloatingActionButton: true,
    showBottomNavigationBar: true,
    selectedIndexOfBottomNavigationBar: 1,
  );
}
