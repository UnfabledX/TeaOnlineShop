package filters;

import org.mozilla.universalchardet.UniversalDetector;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

/**
 * Class EncodingFilter is designated for filtering
 * object with non-UTF8 String instances to object
 * with String instances in UTF-8 encoding.
 *
 * @author Oleksii Synelnyk
 */

public class EncodingFilter {

    /**
     * Convert object string fields from ISO-8859-1
     * to UTF-8 encoding.
     *
     * @param o arbitrary object which needs to be filtered
     */
    public static void convert(Object o) {
        try {
            for (Field field : o.getClass().getDeclaredFields()) {
                if (field.getType() == String.class) {
                    field.setAccessible(true);
                    String value = new String(((String) field.get(o)).getBytes(StandardCharsets.ISO_8859_1),
                            StandardCharsets.UTF_8);
                    field.set(o, value);
                }
            }
        } catch (IllegalAccessException ex) {
            System.out.println("Exception " + ex);
        }
    }

    /*private static String findEncoding(String str) {
        UniversalDetector detector = new UniversalDetector(null);
        int length = str.getBytes().length;
        detector.handleData(str.getBytes(), 0, length);
        detector.dataEnd();
        String encoding = detector.getDetectedCharset();
        return encoding != null ? encoding : "ISO-8859-1";
    }

    public static void main(String[] args) throws UnsupportedEncodingException {
        byte[] bytes1 = "чай".getBytes(StandardCharsets.UTF_8);
        byte[] bytes2 = "чай".getBytes(StandardCharsets.ISO_8859_1);
        byte[] bytes3 = "Џ®«м§®ў вҐ«м".getBytes();
        System.out.println(Arrays.toString(bytes1));
        System.out.println(Arrays.toString(bytes2));
        String str1 = new String(bytes1);
        String str2 = new String(bytes2);
        String str3 = new String(bytes3, "windows-1251");
        System.out.println(str1);
        System.out.println(str2);
        System.out.println(str3);
        System.out.println(findEncoding("Џ®«м§®ў вҐ«м"));

    }*/
}
