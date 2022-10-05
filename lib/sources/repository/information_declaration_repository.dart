import 'package:car_world_system/sources/model/informationDeclarationModel.dart';
import 'package:car_world_system/sources/repository/information_declaration_api_provider.dart';

class InformationDeclarationRepository {
  InformationDeclarationApiProvider informationDeclarationApiProvider =
      InformationDeclarationApiProvider();
  Future<bool> inputInformation(InformationDeclarationModel user) {
    return informationDeclarationApiProvider.inputInformation(user);
  }
}
