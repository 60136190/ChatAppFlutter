// import 'package:flutter/material.dart';
// import 'package:ms_neighbor/widgets/image_button.dart' as ImageButton;
//
// class BlockListScreen extends StatefulWidget {
//   BlockListScreen({Key key}) : super(key: key);
//   @override
//   _BlockListScreenState createState() => _BlockListScreenState();
// }
//
// class _BlockListScreenState extends State<BlockListScreen> {
//   final bloc = BlockedUsersBloc();
//   final refreshController = RefreshController();
//
//   @override
//   void initState() {
//     super.initState();
//     bloc.getUserData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Stack(
//           children: <Widget>[
//             Scaffold(
//                 appBar: AppBar(
//                   leading: MyBackButton(),
//                   centerTitle: true,
//                   shape: Border(bottom: MyTheme.borderAppBar),
//                   title: const Text(
//                     'ブロック済みユーザー一覧',
//                   ),
//                 ),
//                 body: Align(
//                     alignment: AlignmentDirectional.center,
//                     child: StreamBuilder<List<BlockedUserModel>>(
//                         stream: bloc.stream,
//                         builder: (context, snapshot) {
//                           if (snapshot.hasError)
//                             return Text(snapshot.error,
//                                 style: TextStyle(color: Colors.red));
//                           if (!snapshot.hasData) return CircularIndicator();
//                           if (snapshot.data.isEmpty)
//                             return const Text('ブロックリストはありません。');
//
//                           return SmartRefresher(
//                               enablePullDown: true,
//                               header: CustomHeaderRefresh(),
//                               controller: refreshController,
//                               onRefresh: refresh,
//                               onLoading: load,
//                               child: ListView.separated(
//                                   physics:
//                                       const AlwaysScrollableScrollPhysics(),
//                                   separatorBuilder: (_, __) => const Divider(
//                                         height: 1,
//                                       ),
//                                   itemCount: snapshot.data.length,
//                                   itemBuilder: (_, index) => BlockedUser(
//                                       model: snapshot.data[index],
//                                       bloc: bloc,
//                                       onPressed: () => unlockUserBlocked(
//                                           snapshot.data[index].userCode,
//                                           snapshot.data[index].id))));
//                         }))),
//             StreamBuilder<bool>(
//                 initialData: false,
//                 stream: bloc.loading.stream,
//                 builder: (context, snapshot) {
//                   return snapshot.data
//                       ? Container(
//                           width: double.infinity,
//                           height: double.infinity,
//                           color: Color.fromRGBO(255, 255, 255, 0.5),
//                           child: Center(child: CircularProgressIndicator()))
//                       : Container();
//                 })
//           ],
//         ));
//   }
//
//   @override
//   void dispose() {
//     bloc.dispose();
//     refreshController.dispose();
//     super.dispose();
//   }
//
//   void refresh() {
//     bloc.getUserData(onComplete: refreshController.refreshCompleted);
//   }
//
//   void load() {
//     // TODO
//     //bloc.loadMore();
//     refreshController.loadComplete();
//   }
//
//   void unlockUserBlocked(userCode, id) async {
//     await bloc.postUserData(userCode, '$id', '0', onComplete: () {
//       bloc.usersList.removeWhere((el) => el.id == id);
//       bloc.sink.add(bloc.usersList);
//     });
//   }
// }
