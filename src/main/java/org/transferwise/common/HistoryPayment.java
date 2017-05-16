package org.transferwise.common;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class HistoryPayment {
	private Boolean fraud;
	private String email;
	private Double amount;
	private String sourceCurrency;
	private String targetCurrency;
	private String recipientName;
	private String recipientCountry;
	private String type;
	private String iban;
	private String ip;
	private LocalDateTime created;
}
