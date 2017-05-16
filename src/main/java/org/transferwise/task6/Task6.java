package org.transferwise.task6;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import okhttp3.*;
import org.transferwise.common.HistoryPayment;
import org.transferwise.common.Payment;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class Task6 {
	private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();
	private static final OkHttpClient OK_HTTP_CLIENT = new OkHttpClient();
	static {
		OBJECT_MAPPER.findAndRegisterModules();
	}
	
	public static void main(String[] args) throws IOException {
		List<Payment> payments = getNewPayments();
		List<HistoryPayment> historyPayments = getHistoryPayments();
		List<HistoryPayment> frauds = getFrauds(historyPayments);
		List<Payment> newFrauds = findFrauds(payments, frauds);
		
		markFraud(newFrauds);
		payments.removeAll(newFrauds);
		markNonFraud(payments);
		
		System.out.println("done");
	}
	
	private static List<Payment> findFrauds(List<Payment> payments, List<HistoryPayment> frauds) {
		return payments.stream()
										 .filter(e -> frauds.stream()
															 .anyMatch(hp -> hp.getEmail().equals(e.getEmail()) ||
																			 hp.getIban().equals(e.getIban()) ||
																			 hp.getIp().equals(e.getIp()) ||
																			 hp.getRecipientName().equals(e.getRecipientName())
															 ))
										 .collect(Collectors.toList());
	}
	
	private static List<HistoryPayment> getFrauds(List<HistoryPayment> historyPayments) {
		return historyPayments.stream()
													  .filter(e -> Boolean.TRUE.equals(e.getFraud()))
													  .collect(Collectors.toList());
	}
	
	private static List<Payment> getNewPayments() {
		List<Payment> payments = loadData("http://54.229.242.6/payment/?token=74a9361c75d4124ca1d087bdcfd2a3e9",
										  new TypeReference<List<Payment>>() {});
		return payments == null ? Collections.EMPTY_LIST : payments;
	}
	
	private static List<HistoryPayment> getHistoryPayments() {
		List<HistoryPayment> payments = loadData("http://54.229.242.6/payment/history/?token=74a9361c75d4124ca1d087bdcfd2a3e9",
												 new TypeReference<List<HistoryPayment>>() {});
		return payments == null ? Collections.EMPTY_LIST : payments;
	}
	
	private static <T> T loadData(String url, TypeReference<T> obj) {
		Request request = new Request.Builder()
				.get()
				.url(url)
				.build();
		try {
			Response response = OK_HTTP_CLIENT.newCall(request).execute();
			ResponseBody body = response.body();
			if (body != null) {
				String json = body.source().readUtf8();
				return OBJECT_MAPPER.readValue(json, obj);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private static void markFraud(List<Payment> frauds) {
		frauds.forEach(e -> {
			String url = "http://54.229.242.6/payment/" + e.getId() + "/fraud/?token=74a9361c75d4124ca1d087bdcfd2a3e9";
			Request req = new Request.Builder()
					.put(RequestBody.create(MediaType.parse("application/json; charset=utf-8"), ""))
					.url(url)
					.build();
			executeRequest(url, req);
		});
	}
	
	private static void markNonFraud(List<Payment> nonFrauds) {
		nonFrauds.forEach(e -> {
			String url = "http://54.229.242.6/payment/" + e.getId() + "/fraud/?token=74a9361c75d4124ca1d087bdcfd2a3e9";
			Request req = new Request.Builder()
					.delete()
					.url(url)
					.build();
			executeRequest(url, req);
		});
	}
	
	private static void executeRequest(String url, Request req) {
		try {
			System.out.println(url);
			Response response = OK_HTTP_CLIENT.newCall(req).execute();
			System.out.println(response.body().source().readUtf8());
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}
}
