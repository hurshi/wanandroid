import 'package:wanandroid/model/project/ProjectClassifyItemModel.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';

class ProjectClassifyItemBean {
  int currentPage;
  ProjectClassifyItemModel projectClassifyItemModel;
  ItemListPage itemListPage;

  ProjectClassifyItemBean(
      {this.currentPage, this.projectClassifyItemModel, this.itemListPage});
}
