import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  Uri tourMode({required String endpoint}) {
    return Uri.parse('${dotenv.get('URL_API')}/tour/$endpoint');
  }

  Uri ticket({required String endpoint}) {
    return Uri.parse('${dotenv.get('URL_API')}/ticket/$endpoint');
  }

  Uri user({required String endpoint}) {
    return Uri.parse('${dotenv.get('URL_API')}/user/$endpoint');
  }

  Uri emblem({required String endpoint}) {
    return Uri.parse('${dotenv.get('URL_API')}/emblem/$endpoint');
  }

  Uri quiz({required String endpoint}) {
    return Uri.parse('${dotenv.get('URL_API')}/quiz/$endpoint');
  }

  Uri coupon({required String endpoint}) {
    return Uri.parse('${dotenv.get('URL_API')}/coupon/$endpoint');
  }

  Uri museumPiece({required String endpoint}) {
    return Uri.parse('${dotenv.get('URL_API')}/piece/$endpoint');
  }

  Uri product({required String endpoint}) {
    return Uri.parse('${dotenv.get('URL_API')}/product/$endpoint');
  }

  Uri productCategory({required String endpoint}) {
    return Uri.parse('${dotenv.get('URL_API')}/product/category/$endpoint');
  }

  Uri museumInformation({required String endpoint}) {
    return Uri.parse('${dotenv.get('URL_API')}/museumInformation/$endpoint');
  }
}
