package etc;

import java.util.regex.*;

public class Etc {
	public static boolean checkRegex(String text, String regex) {
		  Pattern p = Pattern.compile(regex);
		  Matcher m = p.matcher(text);
		  return m.matches();
	}
}
