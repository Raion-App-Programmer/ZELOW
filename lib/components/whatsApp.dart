import 'package:url_launcher/url_launcher.dart';

Future<void> bukaWhatsapp({required String nomor, String? pesan}) async {
  // Ganti awalan 0 dengan 62
  final nomorInternasional = nomor.replaceFirst('0', '62');

  // Tambahkan pesan jika ada
  final message = pesan != null ? "?text=${Uri.encodeComponent(pesan)}" : "";

  final url = Uri.parse('https://wa.me/$nomorInternasional$message');
  final urlWeb = Uri.parse('https://web.whatsapp.com/send?phone=$nomorInternasional$pesan');

  if (await canLaunchUrl(url)) {
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e){
      await launchUrl(urlWeb, mode: LaunchMode.externalApplication);
    }
  }else {
    await launchUrl(urlWeb, mode: LaunchMode.externalApplication);
  }
}
