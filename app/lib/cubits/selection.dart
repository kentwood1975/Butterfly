import 'package:butterfly/models/elements/element.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionCubit extends Cubit<ElementLayer?> {
  SelectionCubit([ElementLayer? selected]) : super(selected);

  void change(ElementLayer? layer) => emit(layer);

  void reset() => emit(null);
}
