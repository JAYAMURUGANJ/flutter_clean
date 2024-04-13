part of 'temple_pooja_bloc.dart';

abstract class TemplePoojaEvent {
  const TemplePoojaEvent();
}

class GetTemplePooja extends TemplePoojaEvent {
  String templeId;
  GetTemplePooja({
    required this.templeId,
  });
}
