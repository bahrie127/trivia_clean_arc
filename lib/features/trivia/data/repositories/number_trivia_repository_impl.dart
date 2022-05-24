import 'package:dartz/dartz.dart';
import 'package:trivia_clean_arc/core/exceptions/exception.dart';

import 'package:trivia_clean_arc/core/exceptions/failure.dart';
import 'package:trivia_clean_arc/core/platform/network_info.dart';
import 'package:trivia_clean_arc/features/trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:trivia_clean_arc/features/trivia/domain/entities/number_trivia.dart';
import 'package:trivia_clean_arc/features/trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    networkInfo.isConnected;
    try {
      final remoteTrivia =
          await remoteDataSource.getConcreteNumberTrivia(number);
      return Right(remoteTrivia);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return Right(await remoteDataSource.getRandomNumberTrivia());
  }
}
