import 'package:equatable/equatable.dart';

class DatabaseException extends Equatable implements Exception {
  final String message;

  const DatabaseException({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
