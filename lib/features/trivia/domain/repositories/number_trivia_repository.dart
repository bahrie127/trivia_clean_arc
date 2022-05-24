import 'package:dartz/dartz.dart';
import 'package:trivia_clean_arc/core/exceptions/failure.dart';
import 'package:trivia_clean_arc/features/trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
