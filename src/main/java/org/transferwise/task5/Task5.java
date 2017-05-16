package org.transferwise.task5;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import okhttp3.*;
import org.transferwise.common.Payment;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Task5 {
	
	private static final Map<String, String> POPS = new HashMap<>();
	private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();
	private static final OkHttpClient OK_HTTP_CLIENT = new OkHttpClient();
	static {
		POPS.put("Angela Merkel", "Germany");
		POPS.put("Barack Obama", "USA");
		POPS.put("Helmut Kohl", "Germany");
		POPS.put("Elizabeth Alexandra Mary", "United Kingdom");
		POPS.put("Julius Caesar", "Italy");
		POPS.put("Toomas Hendrik Ilves", "Estonia");
		POPS.put("Taavi Rõivas", "Estonia");
		POPS.put("Reuven Rivlin", "Israel");
		POPS.put("Bill Clinton", "USA");
		POPS.put("David Johnston", "Canada");
		POPS.put("Peter Cosgrove", "Australia");
		POPS.put("Dalia Grybauskaitė", "Lithuania");
		POPS.put("Raimonds Vējonis", "Latvia");
		POPS.put("Andrzej Duda", "Poland");
		POPS.put("Borut Pahor", "Slovenia");
		POPS.put("Mariano Rajoy", "Spain");
		POPS.put("Marcelo Sousa", "Portugal");
		POPS.put("Heinz Fischer", "Austria");
		POPS.put("Mikheil Saakashvili", "Ukraine");
		POPS.put("Tony Blair", "United Kingdom");
		
		OBJECT_MAPPER.findAndRegisterModules();
	}
	
	public static void main(String[] args) throws IOException {
		List<Payment> payments = getPayments();
		List<Payment> popPayments = getPopPayments(payments);
		
		markAsPeps(popPayments);
		payments.removeAll(popPayments);
		markAsNonPeps(payments);
		
		System.out.println("done");
	}
	
	private static List<Payment> getPopPayments(List<Payment> payments) {
		return payments.stream()
					   .filter(e -> POPS.containsKey(e.getRecipientName().trim()) &&
									POPS.containsValue(e.getRecipientCountry().trim()))
					   .collect(Collectors.toList());
	}
	
	private static List<Payment> getPayments() {
		Request.Builder builder = new Request.Builder();
		Request request = builder.get().url("http://54.229.242.6/payment/?token=74a9361c75d4124ca1d087bdcfd2a3e9").build();
		try {
			Response response = OK_HTTP_CLIENT.newCall(request).execute();
			ResponseBody body = response.body();
			if (body != null) {
				String json = body.source().readUtf8();
				return OBJECT_MAPPER.readValue(json, new TypeReference<List<Payment>>() {});
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return Collections.emptyList();
	}
	
	private static void markAsNonPeps(List<Payment> payments) {
		payments.forEach(e -> {
			String url = "http://54.229.242.6/payment/" + e.getId() + "/aml/?token=74a9361c75d4124ca1d087bdcfd2a3e9";
			Request req = new Request.Builder()
					.delete()
					.url(url)
					.build();
			executeRequest(url, req);
		});
	}

	private static void markAsPeps(List<Payment> payments) {
		payments.forEach(e -> {
					String url = "http://54.229.242.6/payment/" + e.getId() + "/aml/?token=74a9361c75d4124ca1d087bdcfd2a3e9";
					Request req = new Request.Builder()
							.put(RequestBody.create(MediaType.parse("application/json; charset=utf-8"), ""))
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
