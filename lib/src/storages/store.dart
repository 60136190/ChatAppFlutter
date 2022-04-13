import 'package:get_it/get_it.dart';
import 'package:task1/src/services/navigation_service.dart';
import 'package:task1/src/services/socket_io_client.dart';
import 'package:task1/src/storages/auth_store.dart';
import 'package:task1/src/storages/point_store.dart';
import 'package:task1/src/storages/system_store.dart';

GetIt store = GetIt.instance;

Future setupStore() async {
  store.registerLazySingleton(() => NavigationService());
  store.registerSingleton<SystemStore>(SystemStore());
  store.registerLazySingleton<SocketIo>(() => SocketIo());
  store.registerLazySingleton<AuthStore>(() => AuthStore());
  // store.registerLazySingleton<MessageStore>(() => MessageStore());
  // store.registerLazySingleton<UserStore>(() => UserStore());
  // store.registerLazySingleton<KeijibanStore>(() => KeijibanStore());
  // store.registerLazySingleton<MyPageStore>(() => MyPageStore());
  store.registerLazySingleton<PointStore>(() => PointStore());

}
