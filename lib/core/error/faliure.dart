import 'package:equatable/equatable.dart';

abstract class Faliure extends Equatable {
  final String message;
  const Faliure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFaliure extends Faliure {
  const ServerFaliure(super.message);
}

class NoDataFaliure extends Faliure {
  const NoDataFaliure(super.message);
}

class ConnectionFaliure extends Faliure {
  const ConnectionFaliure(super.message);
}
