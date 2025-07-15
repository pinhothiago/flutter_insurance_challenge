class Failure {
  final String message;

  Failure({this.message = 'Ocorreu um erro'});
}

class ServerFailure extends Failure {
  ServerFailure({super.message = 'Erro no servidor'});
}

class CacheFailure extends Failure {
  CacheFailure({super.message = 'Erro no cache local'});
}

class NetworkFailure extends Failure {
  NetworkFailure({super.message = 'Sem conexão com a internet'});
}
