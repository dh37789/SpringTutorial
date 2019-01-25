package kr.or.ddit.utils;

import java.util.HashMap;
import java.util.Map;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

@Component
public class CryptoGenerator {
	// 반환값 : 공개키의 가수부 => javascript RSA 객체에 제공
	// 		  공개키의 지수부      RSA 객체를 통해서 제공된 공개키를 활용해 암호화
	public Map<String, String> getGeneratePairKey(HttpSession session){
		// 공개키, 비밀키 생성
		KeyPairGenerator generator = null;
		// 공개키, 비밀키 저장
		KeyPair keyPair = null;
		// 공개키 가수부, 지수부 분리
		KeyFactory factory = null;
		// 비밀키
		PrivateKey privateKey = null;
		// 공개키
		PublicKey publicKey = null;
		
		Map<String, String> publicKeyMap = new HashMap<String, String>();
		
		try {
			generator = KeyPairGenerator.getInstance("RSA");
			// 공개키, 비밀키 사이즈 설정 : 짝수!!
			generator.initialize(2048);
			
			// 생성된 공개키, 비밀키를 할당
			keyPair = generator.generateKeyPair();
			
			// 비밀키 할당
			privateKey = keyPair.getPrivate();
			session.setAttribute("privateKey", privateKey);
			
			// 공개키 할당
			publicKey = keyPair.getPublic();
			
			factory = KeyFactory.getInstance("RSA");
			
			RSAPublicKeySpec publicKeySpec = 
					(RSAPublicKeySpec)factory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			
			// 단정도(32bit-float), 배정도(64bit-double)
			// -143.1231243154134123123125364353
			// 단정도(32bit-float) 2진수 : 부호비트(양수-0|음수-1) + 지수(소수점 위치 8bit) + 가수부(실수값 표현23bit)
			// 배정도(64bit-double) 2진수 : 부호비트(양수-0|음수-1) + 지수(소수점 위치 11bit) + 가수부(실수값 표현52bit)
			
			// 공개키 (가수부)
			String publicKeyModulus	= publicKeySpec.getModulus().toString(16);
			// 공개키 (지수부)
			String publicKeyExponent = publicKeySpec.getPublicExponent().toString(16);
			
			publicKeyMap.put("modulus", publicKeyModulus);
			publicKeyMap.put("exponent", publicKeyExponent);
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		}
		return publicKeyMap;
	}
	
	public String decryptRSA(HttpSession session, 
			String secureValue){
		PrivateKey privateKey = (PrivateKey) session.getAttribute("privateKey");
		
		String returnValue = "";
		
		try {
			Cipher cipher = Cipher.getInstance("RSA");
				cipher.init(Cipher.DECRYPT_MODE, privateKey);
			
			byte[] targetByte = hexToByteArray(secureValue);
			
			byte[] beforeStringByte = cipher.doFinal(targetByte);
			
			// 암호문 => 평문으로 변경
			returnValue = new String(beforeStringByte);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return returnValue;
	}

	private static byte[] hexToByteArray(String secureValue) {
		if(secureValue == null || secureValue.length()%2 != 0){
			return new byte[]{};
		}
		byte[] bytes = new byte[secureValue.length()/2];
		
		for (int i = 0; i < secureValue.length(); i+=2) {
			byte value = (byte) Integer.parseInt(secureValue.substring(i, i+2), 16);
			bytes[(int)Math.floor(i/2)] = value;
		}
		return bytes;
	}
					
}
