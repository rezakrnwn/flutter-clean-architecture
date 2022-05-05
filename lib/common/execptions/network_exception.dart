import 'package:equatable/equatable.dart';

class NetworkException extends Equatable implements Exception {
  final int statusCode;
  final String message;

  NetworkException({
    required this.statusCode,
    required this.message,
  });

  @override
  List<Object?> get props => [statusCode, message];
}
