part of 'statistics_bloc.dart';

sealed class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<Object> get props => [];
}

final class StatisticsInitial extends StatisticsState {}

final class StatisticsSuccess extends StatisticsState {}
