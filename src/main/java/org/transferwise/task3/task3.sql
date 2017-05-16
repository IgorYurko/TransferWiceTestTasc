SELECT
  twa.name as bankName,
  twa.accountNumber as sourceAcountNumber,
  b.name as targetbankName,
  ba.accountNumber as targetAccountNumber,
  ba.accountName,
  p.amount
from payment p
  JOIN transfer_wice_acounts twa on p.sourceCurrency = twa.currency
  JOIN banks b on p.recipientBankId = b.id
  JOIN bank_account ba on p.iban = ba.accountNumber