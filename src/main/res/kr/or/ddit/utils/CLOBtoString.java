package kr.or.ddit.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;

import oracle.sql.CLOB;

public class CLOBtoString {
	public static String clobToString(CLOB target) throws SQLException, IOException {
		StringBuffer buffer = new StringBuffer();
		BufferedReader reader = new BufferedReader(target.getCharacterStream());
		String str = "";
		while ((str = reader.readLine()) != null) {
			buffer.append(str);
		}
		reader.close();
		return buffer.toString();
	}
}
