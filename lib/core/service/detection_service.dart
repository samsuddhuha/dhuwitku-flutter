class DetectionService {
  static int extractNominal(String text) {
    final regex = RegExp(r'(\d+)\s*(rb|ribu|k|000)?');
    final match = regex.firstMatch(text.toLowerCase());

    if (match == null) return 0;

    int number = int.parse(match.group(1)!);

    if (text.contains('rb') || text.contains('ribu')) {
      number *= 1000;
    }

    return number;
  }

  static int detectStatus(String text) {
    final lower = text.toLowerCase();

    final incomeKeywords = ['dapat', 'gaji', 'masuk', 'bonus', 'jual'];
    final expenseKeywords = ['beli', 'bayar', 'keluar', 'jajan', 'transfer'];

    if (incomeKeywords.any((e) => lower.contains(e))) {
      return 1;
    }

    if (expenseKeywords.any((e) => lower.contains(e))) {
      return 2;
    }

    return 2; // default expense
  }

  static String extractInfo(String text) {
    return text;
  }
}
