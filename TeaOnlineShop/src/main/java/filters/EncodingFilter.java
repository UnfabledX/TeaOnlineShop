package filters;

import java.lang.reflect.Field;
import java.nio.charset.StandardCharsets;

//problem with adding product in Ukrainian language on page add-product.jsp ()
//not solved yet - hieroglyphs instead of Ukrainian.
public class EncodingFilter {

    public static void convert(Object o) {
        try {
            for (Field field : o.getClass().getDeclaredFields()) {
                if (field.getType() == String.class) {
                    field.setAccessible(true);
                    String value = new String(((String) field.get(o)).getBytes(), StandardCharsets.UTF_8);
                    field.set(o, value);
                }
            }
        } catch (IllegalAccessException ex) {
            System.out.println("Exception " + ex);
        }
    }
}
