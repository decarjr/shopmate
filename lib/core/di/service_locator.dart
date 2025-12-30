import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Registre repositórios, datasources e usecases aqui.
  // Exemplo:
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
}
