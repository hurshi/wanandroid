import 'package:flutter/material.dart';
import 'dart:async';

import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/model/project/ProjectClassifyModel.dart';
import 'package:wanandroid/model/project/ProjectClassifyItemModel.dart';
import 'package:wanandroid/bean/ProjectClassifyItemBean.dart';
import 'package:wanandroid/widget/Loading.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/api/Api.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage> {
  List<ProjectClassifyItemBean> _list = List();

  @override
  void initState() {
    super.initState();
    _loadClassifysDelay(100);
  }

  @override
  Widget build(BuildContext context) {
    if (_list.length <= 0) {
      return Loading();
    }
    return DefaultTabController(
      length: _list.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TabBar(
            labelColor: GlobalConfig.colorPrimary,
            isScrollable: true,
            unselectedLabelColor: Colors.black45,
            indicatorColor: GlobalConfig.colorPrimary,
            tabs: _buildTabs(),
          ),
          Expanded(
            child: TabBarView(children: _buildPages()),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTabs() {
    return _list?.map(_buildSingleTab)?.toList();
  }

  Widget _buildSingleTab(ProjectClassifyItemBean bean) {
    return Tab(
      text: bean?.projectClassifyItemModel?.name,
    );
  }

  Widget _buildSinglePage(ProjectClassifyItemBean bean) {
    return ItemListPage(
      request: (page) {
        return CommonService().getProjectListData((bean
                    .projectClassifyItemModel.url ==
                null)
            ? ("${Api.PROJECT_LIST}$page/json?cid=${bean.projectClassifyItemModel.id}")
            : ("${bean.projectClassifyItemModel.url}$page/json"));
      },
    );
  }

  List<Widget> _buildPages() {
    return _list?.map(_buildSinglePage)?.toList();
  }

  void _loadClassifysDelay(int delays) async {
    Future.delayed(
      Duration(milliseconds: delays),
    ).then((_) {
      _loadClassifys();
    });
  }

  void _loadClassifys() async {
    CommonService().getProjectClassify((ProjectClassifyModel _bean) {
      if (_bean.data.length > 0) {
        setState(() {
          _loadNewestProjects();
          _bean.data.forEach((_projectClassifyItemModel) {
            _list.add(ProjectClassifyItemBean(
                currentPage: 0,
                projectClassifyItemModel: _projectClassifyItemModel));
          });
        });
      }
    });
  }

  void _loadNewestProjects() {
    _list.insert(
        0,
        ProjectClassifyItemBean(
            currentPage: 0,
            projectClassifyItemModel: ProjectClassifyItemModel(
                name: "最新项目", url: Api.PROJECT_NEWEST)));
  }
}
