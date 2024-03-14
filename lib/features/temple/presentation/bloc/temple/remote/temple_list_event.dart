abstract class TempleListEvent {
  const TempleListEvent();
}

class GetTempleList extends TempleListEvent {
  String formData;
  GetTempleList(
    this.formData,
  );
}
