package org.transferwise.task2;

import java.util.Deque;
import java.util.LinkedList;

public class Task2 {
	private static final int CHAIRS = 100;
	
	public static void main(String[] args) {
		System.out.println("Survivor " + getSurvivor(CHAIRS));
	}
	
	private static int getSurvivor(int numChairs) {
		Deque<Integer> chairs = new LinkedList<>();
		fillDeque(numChairs, chairs);
		int skip = 0;
		while (chairs.size() > 1) {
			System.out.println("Killed " + chairs.removeFirst());
			skip++;
			int shift = skip % chairs.size();
			for (int i = 0; i < shift; i++) {
				chairs.addLast(chairs.removeFirst());
			}
		}
		return chairs.getFirst();
	}
	
	private static void fillDeque(int numChairs, Deque<Integer> chairs) {
		for (int i = 1; i <=numChairs ; i++) {
			chairs.addLast(chairs.size() + 1);
		}
	}
}
