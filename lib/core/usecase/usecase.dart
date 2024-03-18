abstract class UseCase<Type, Params> {
  Future<Type> call(String formData);
}
