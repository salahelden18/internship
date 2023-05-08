import 'package:flutter/material.dart';
import 'package:internship/widgets/background_linear_gradient.dart';
import 'package:internship/widgets/header_widget.dart';
import 'package:internship/widgets/main_content_widget.dart';

import '../../widgets/space_height.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const String routeName = '/privacy-policy';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            const BackgroundLinearGradient(),
            MainContentWidget(
              size: size,
              child: Column(
                children: const [
                  HeaderWidget(
                    icon: Icons.privacy_tip,
                    text: 'Privacy Policy',
                  ),
                  SpaceHeight(),
                  Text(
                    'Türkiye’ de kurulu, Saray Mahallesi Site Yolu Sokak Anel İş Merkezi No: 5 Kat: 3, 34768 Ümraniye/İstanbul adresinde mukim, ticaret sicil gazetesine 424015 no ile kayıtlı, 0524016374100063 mersis no’ lu, Anadolu Kurumlar Vergi Dairesi, 5240163741 no’ lu vergi mükellefi, Kariyer.Net Elektronik Yayıncılık ve İletişim Hizmetleri A.Ş. (“Şirket” veya “Platform”) olarak; veri sorumlusu sıfatıyla, ticari ilişkilerimiz kapsamında veya sizlerle olan iş ilişkimiz dahilinde, kişisel verilerinizin, işlenmelerini gerektiren amaç çerçevesinde ve bu amaç ile bağlantılı, sınırlı ve ölçülü şekilde, tarafımıza bildirdiğiniz şekliyle kişisel verilerin doğruluğunu ve en güncel halini koruyarak, kaydedileceğini, depolanacağını, muhafaza edileceğini, yeniden düzenleneceğini, kanunen bu kişisel verileri talep etmeye yetkili olan kurumlar ile paylaşılacağını, yurtiçi veya yurtdışı üçüncü kişilere aktarılacağını, devredileceğini, sınıflandırılabileceğini ve Kişisel Verileri Koruma Kanunu’nda (Bundan sonra “KVKK” olarak anılacaktır) sayılan sair şekillerde işlenebileceğini bildiririz;Aşağıda belirttiğimiz ve tarafımıza sağladığınız kişisel verilerinizin her koşulda; duruma göre aşağıda belirtilen şekillerde elde ettiğimiz kişisel verilerinizin hukuki ilişkilerimiz kapsamında,',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
