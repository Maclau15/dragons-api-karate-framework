package api.data;

import java.util.Random;

public class GenerateData {

	public static String getEmail() {
		String email = "autogeneratedE";
		String provider = "@tekschool.us";
		int randomNumber = (int) (Math.random() * 10000);
		String autoEmail = email + randomNumber + provider;
		return autoEmail;

	}

	public static String getPhoneNumber() {
		String phoneNumber = "9";
		for (int i = 0; i < 9; i++) {
			phoneNumber += (int) (Math.random() * 10);
		}
		return phoneNumber;

	}

	// Create a method that return random phone number 10 digit
	public static long phoneNumber() {
		Random r = new Random();
		long phoneNum = r.nextLong();
		phoneNum = Math.abs(phoneNum);
		phoneNum = phoneNum % 10000000000L;
		return phoneNum;
	}
	// Create a method that return random Car License Plate

	public static String getLicensePlate() {
		Random random = new Random();
		StringBuilder sb = new StringBuilder();
		String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		int count = 3;
		for (int i = 0; i < count; i++) {
			int randomIndex = random.nextInt(letters.length());
			char randomChar = letters.charAt(randomIndex);
			sb.append(randomChar);
	}
		for (int i = 0; i < 3; i++) {
			int randomDigit = (int) (Math.random() * 10);
			sb.append(randomDigit);
		}
		return sb.toString();

	}

	public static String carLicense() {

		String letters = "ABC";
		int randNum = (int) (Math.random() * 1000);
		String license = letters + randNum;
		return license;
	}

}
