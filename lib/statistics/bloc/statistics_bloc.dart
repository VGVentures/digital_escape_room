import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:statistics_repository/statistics_repository.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsSubmitted, StatisticsState> {
  StatisticsBloc(this._repository) : super(StatisticsInitial()) {
    on<StatisticsSubmitted>(_onStatisticsSubmitted);
  }

  final StatisticsRepository _repository;

  void _onStatisticsSubmitted(
    StatisticsSubmitted event,
    Emitter<StatisticsState> emit,
  ) {
    _repository.resetStatistics();
    emit(StatisticsSuccess());
  }
}
