class TransactionData{
  final List<Transaction> data;
  TransactionData({required this.data});

  factory TransactionData.fromJson(Map<String, dynamic> transactionJson) =>
    TransactionData(
      data: List.from(
        transactionJson["data"]["tabungan"].map(
          (transaction) => Transaction.fromModel(transaction),
        ),
      ),
    );
}


class Transaction{
  final int id;
  final String date;
  final int transactionId;
  final int transactionNominal;

  Transaction({
    required this.id,
    required this.date,
    required this.transactionId,
    required this.transactionNominal
  });

  factory Transaction.fromModel(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: json['trx_tanggal'],
      transactionId: json['trx_id'],
      transactionNominal: json['trx_nominal']
    );
  }
}