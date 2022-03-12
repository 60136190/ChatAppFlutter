import 'package:flutter/material.dart';
import 'package:task1/src/controllers/metada_controller.dart';
import 'package:task1/src/models/metadata_model.dart';
import 'package:task1/src/respository/meta_data_respository.dart';
import 'package:task1/src/ui/register_screen.dart';

class MetaDataScreen extends StatefulWidget {
  @override
  _MetaDataScreen createState() => _MetaDataScreen();
}

class _MetaDataScreen extends State<MetaDataScreen> {
  @override
  Widget build(BuildContext context) {
    var metaDataController = MetaDataController(MetaDataRespository());
    metaDataController.fetchIncomeList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Thainam Shop'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: () => {
            Navigator.push((context), MaterialPageRoute(builder: (context) => Registers()))
          }, icon: Icon(Icons.settings))
        ],
      ),
      body:

      SingleChildScrollView(
        child: Column(
          children: [
            // list income
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.black12,
              height: 30,
              child: Text(
                'List Income', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 400,
              child: FutureBuilder<List<Age>>(
                  future: metaDataController.fetchAgeList(),
                  builder: (context, snapshot) {
                    //
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('error'));
                    }
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          var profile = snapshot.data?[index];
                          return Container(
                            height: 100,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1, child: Text('${profile?.fieldId}')),
                                Expanded(flex: 3, child: Text('${profile?.name}')),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 0.5,
                            height: .5,
                          );
                        },
                        itemCount: snapshot.data?.length ?? 0);
                  }),
            ),
            // list age
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.black12,
              height: 30,
              child: Text(
                'List Age', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 400,
              child: FutureBuilder<List<Age>>(
                  future: metaDataController.fetchIncomeList(),
                  builder: (context, snapshot) {
                    //
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('error'));
                    }
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          var profile = snapshot.data?[index];
                          return Container(
                            height: 100,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Text('${profile?.name}')),
                                Expanded(flex: 3, child: Text('${profile?.value}')),
                                Expanded(
                                    flex: 3, child: Text('${profile?.fieldId}')),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 0.5,
                            height: .5,
                          );
                        },
                        itemCount: snapshot.data?.length ?? 0);
                  }),
            ),
            // list relation ship status
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.black12,
              height: 30,
              child: Text(
                'List Relation ship status', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 400,
              child: FutureBuilder<List<Age>>(
                  future: metaDataController.fetchRelationShipList(),
                  builder: (context, snapshot) {
                    //
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('error'));
                    }
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          var profile = snapshot.data?[index];
                          return Container(
                            height: 100,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Text('${profile?.name}')),
                                Expanded(flex: 3, child: Text('${profile?.value}')),
                                Expanded(
                                    flex: 3, child: Text('${profile?.fieldId}')),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 0.5,
                            height: .5,
                          );
                        },
                        itemCount: snapshot.data?.length ?? 0);
                  }),
            ),

            // list job
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.black12,
              height: 30,
              child: Text(
                'List Job', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 400,
              child: FutureBuilder<List<Age>>(
                  future: metaDataController.fetchJobList(),
                  builder: (context, snapshot) {
                    //
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('error'));
                    }
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          var profile = snapshot.data?[index];
                          return Container(
                            height: 100,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Text('${profile?.name}')),
                                Expanded(flex: 3, child: Text('${profile?.value}')),
                                Expanded(
                                    flex: 3, child: Text('${profile?.fieldId}')),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 0.5,
                            height: .5,
                          );
                        },
                        itemCount: snapshot.data?.length ?? 0);
                  }),
            ),

            // list sex
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.black12,
              height: 30,
              child: Text(
                'List Sex', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 400,
              child: FutureBuilder<List<Age>>(
                  future: metaDataController.fetchSexList(),
                  builder: (context, snapshot) {
                    //
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('error'));
                    }
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          var profile = snapshot.data?[index];
                          return Container(
                            height: 100,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Text('${profile?.name}')),
                                Expanded(flex: 3, child: Text('${profile?.value}')),
                                Expanded(
                                    flex: 3, child: Text('${profile?.fieldId}')),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 0.5,
                            height: .5,
                          );
                        },
                        itemCount: snapshot.data?.length ?? 0);
                  }),
            ),

            // list height
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.black12,
              height: 30,
              child: Text(
                'List height', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 400,
              child: FutureBuilder<List<Age>>(
                  future: metaDataController.fetchHeightList(),
                  builder: (context, snapshot) {
                    //
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('error'));
                    }
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          var profile = snapshot.data?[index];
                          return Container(
                            height: 100,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Text('${profile?.name}')),
                                Expanded(flex: 3, child: Text('${profile?.value}')),
                                Expanded(
                                    flex: 3, child: Text('${profile?.fieldId}')),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 0.5,
                            height: .5,
                          );
                        },
                        itemCount: snapshot.data?.length ?? 0);
                  }),
            ),

            // list style
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.black12,
              height: 30,
              child: Text(
                'List style', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 400,
              child: FutureBuilder<List<Age>>(
                  future: metaDataController.fetchStyleList(),
                  builder: (context, snapshot) {
                    //
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('error'));
                    }
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          var profile = snapshot.data?[index];
                          return Container(
                            height: 100,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Text('${profile?.name}')),
                                Expanded(flex: 3, child: Text('${profile?.value}')),
                                Expanded(
                                    flex: 3, child: Text('${profile?.fieldId}')),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 0.5,
                            height: .5,
                          );
                        },
                        itemCount: snapshot.data?.length ?? 0);
                  }),
            ),

            // // list area
            // Container(
            //   alignment: Alignment.center,
            //   width: double.infinity,
            //   color: Colors.black12,
            //   height: 30,
            //   child: Text(
            //     'List area', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Container(
            //   height: 400,
            //   child: FutureBuilder<List<Age>>(
            //       future: metaDataController.fetchAreaList(),
            //       builder: (context, snapshot) {
            //         //
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return Center(child: CircularProgressIndicator());
            //         }
            //         if (snapshot.hasError) {
            //           return Center(child: Text('error'));
            //         }
            //         return ListView.separated(
            //             itemBuilder: (context, index) {
            //               var profile = snapshot.data?[index];
            //               return Container(
            //                 height: 100,
            //                 padding: const EdgeInsets.symmetric(
            //                   horizontal: 16.0,
            //                 ),
            //                 child: Row(
            //                   children: [
            //                     // Expanded(flex: 1, child: Text('${profile?.name}')),
            //                     Expanded(flex: 3, child: Text('${profile?.value}')),
            //                     // Expanded(
            //                     //     flex: 3, child: Text('${profile?.fieldId}')),
            //                   ],
            //                 ),
            //               );
            //             },
            //             separatorBuilder: (context, index) {
            //               return Divider(
            //                 thickness: 0.5,
            //                 height: .5,
            //               );
            //             },
            //             itemCount: snapshot.data?.length ?? 0);
            //       }),
            // ),
          ],
        ),
      ),
    );
  }

//   var metaDataController = TodoController(TodoRespository());
//   metaDataController.fetchTodoList();
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Thainam Shop'),
//       backgroundColor: Colors.green,
//       actions: <Widget>[
//         IconButton(icon: Icon(Icons.share), onPressed: () => {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen())),
//         })
//       ],
//     ),
//     body: FutureBuilder<List<Todo>>(
//         future: metaDataController.fetchTodoList(),
//         builder: (context, snapshot){
//
//           //
//           if(snapshot.connectionState == ConnectionState.waiting){
//             return Center(child:CircularProgressIndicator());
//           }
//           if(snapshot.hasError){
//             return Center(child: Text('error'));
//           }
//           return ListView.separated(itemBuilder: (context,index){
//             var profile = snapshot.data?[index];
//             return Container(
//               height: 100,
//               padding: const EdgeInsets.symmetric(horizontal: 16.0,),
//               child: Row(
//                 children: [
//                   Expanded(flex:1,child: Text('${profile?.id}')),
//                   Expanded(flex:3,child: Text('${profile?.title}')),
//                   Expanded(flex:3,child: Text('${profile?.completed}')),
//                 ],
//               ),
//             );
//           }, separatorBuilder: (context, index){
//             return Divider(thickness: 0.5, height: .5,);
//           }, itemCount: snapshot.data?.length ?? 0);
//         }
//
//     ),
//   );
// }
}
