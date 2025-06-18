import 'package:promotions/core/utils/date_period.dart';
import 'package:promotions/models/promotion/promotion_model.dart';
import 'package:share_plus/share_plus.dart';

class ShareHelper {
  ShareHelper._();

  static Future<void> sharePromotion(PromotionModel promotion) async {
    final shareText = _buildShareText(promotion);

    final params = ShareParams(
      subject: promotion.title,
      text: shareText,
    );

    await SharePlus.instance.share(params);
  }

  static String _buildShareText(PromotionModel promotion) {
    return '''${promotion.title}

${promotion.description}

📅 Период: ${datePeriod(promotion.startDate, promotion.endDate)}''';
  }
}
