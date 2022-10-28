package entities;

/**
 * Role entity. Represents user role of
 * authorized client or administrator.
 *
 * @author Oleksii Synelnyk
 */

public enum UserRole {
    ADMIN,
    CLIENT;

    /**
     * Returns id number of each user role beginning from 0.
     * @return the ordinal user role number.
     */
    public int getId() {
        return ordinal();
    }

    public String getName() {
        return name().toLowerCase();
    }

}