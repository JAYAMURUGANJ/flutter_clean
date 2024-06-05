part of 'speciality_bloc.dart';

class SpecialityEvent {
  const SpecialityEvent();
}

class GetSpeciality extends SpecialityEvent {
  final String templeId;
  GetSpeciality({
    required this.templeId,
  });
}
