package entities;

/**
 * Root of all entities which have identifier fields.
 *
 * @author Oleksii Synelnyk
 */
public abstract class Entity {

    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
