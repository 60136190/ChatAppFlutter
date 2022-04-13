import 'dart:async';
import 'dart:developer';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/models/point_package_model.dart';
import 'package:task1/src/storages/point_store.dart';
import 'package:task1/src/storages/store.dart';

import 'bloc.dart';

class PointBloc {
  final _pointStore = store<PointStore>();
  final pointPackage = StreamController<List<PointPackage>>();

  get point => store<PointStore>().totalPoint;

  final totalPoint = Bloc<int>(initialValue: store<PointStore>().totalPoint);

  List<PointPackage> package;

  List<String> get _kProductIds =>
      <String>[...package?.map<String>((item) => item.identifier)];

  final loading = Bloc<bool>.broadcast(initialValue: true);

  StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;
  StreamSubscription _conectionSubscription;

  init() async {
    loading.add(true);
    var data = await store<PointStore>().pointPackage();
    if (data != null) {
      package = data;
      if (!pointPackage.isClosed) pointPackage.add(data);
      totalPoint.add(store<PointStore>().totalPoint);
      await initStoreInfo(); // open on LIVE
    }
    print('list product: $_kProductIds');
    loading.add(false);
  }

  Future<void> initStoreInfo() async {
    String result = await FlutterInappPurchase.instance.initConnection;

    _conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) async {
      print('purchase-updated: $productItem');
      await _pointStore.verifyPurchase(productItem);
      totalPoint.add(store<PointStore>().totalPoint);
      loading.add(false);
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
      loading.add(false);
    });

    print('connect to Store: $result');

    getProduct();
    getAvailablePurchases();
  }

  void getProduct() async {
    try {
      List<IAPItem> productItems =
          await FlutterInappPurchase.instance.getProducts(_kProductIds);
      print('getProduct:: $productItems');
    } catch (err) {
      print('error get product: $err');
    }
  }

  void getAvailablePurchases() async {
    try {
      List<PurchasedItem> purchaseItems =
          await FlutterInappPurchase.instance.getAvailablePurchases();
      print('number restore: ${purchaseItems.length}');

      if (purchaseItems.length > 0) {
        // DateTime dateLatest;
        // PurchasedItem subscriptionLatest;

        for (var item in purchaseItems) {

          log('item purchase: $item');
          await _pointStore.verifyPurchase(item);


        }

        totalPoint.add(store<PointStore>().totalPoint);
      }
    } catch (err) {
      print('availabePurchase error::: $err');
    }
  }

  Future<void> requestPurchase(String identifier, int amount) async {
    print('requestPurchase::: $identifier || $amount');
    loading.add(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('amountPointPackage', amount);
      await FlutterInappPurchase.instance.requestPurchase(identifier);
      loading.add(false);
    } catch (err) {
      print('requestPurchase $err');
      loading.add(false);
    }
  }

  dispose() async {
    await FlutterInappPurchase.instance.endConnection;
    if (_purchaseUpdatedSubscription != null) {
      _purchaseUpdatedSubscription.cancel();
      _purchaseUpdatedSubscription = null;
    }
    if (_purchaseErrorSubscription != null) {
      _purchaseErrorSubscription.cancel();
      _purchaseErrorSubscription = null;
    }
    if (_conectionSubscription != null) {
      _conectionSubscription.cancel();
      _conectionSubscription = null;
    }

    pointPackage.close();
    loading.dispose();
  }
}
