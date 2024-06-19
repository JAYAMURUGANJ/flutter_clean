abstract class TempleListEvent {
  const TempleListEvent();
}

class GetTempleList extends TempleListEvent {
  String seniorgradeTemples;
  GetTempleList({
    required this.seniorgradeTemples,
  });
}
