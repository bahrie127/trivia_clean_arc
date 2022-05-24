import 'dart:convert';

import 'package:http/http.dart';
import 'package:trivia_clean_arc/core/exceptions/exception.dart';

import 'package:trivia_clean_arc/features/trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

const String baseUrl = 'http://numbersapi.com/';

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final Client client;
  NumberTriviaRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    return _getTriviaFromUrl(number.toString());
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getTriviaFromUrl('random');
  }

  Future<NumberTriviaModel> _getTriviaFromUrl(String path) async {
    final url = Uri.parse('$baseUrl$path');
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final decodeResponse = json.decode(response.body);
      return NumberTriviaModel.fromJson(decodeResponse);
    } else {
      throw ServerException();
    }
  }
}
