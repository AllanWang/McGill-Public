package test;

import com.sun.istack.internal.NotNull;

import java.util.Comparator;

/**
 * Created by Allan Wang on 2017-09-21.
 */
public class UniversalComparator implements Comparator<UniversalComparator.Card> {

    //class frames (assume implementation)
    interface Card {
        Rank getRank();

        Suit getSuit();
    }

    enum Rank {

    }

    enum Suit {

    }

    //end of class frame
    private final CompareType type;

    public UniversalComparator(CompareType type) {
        this.type = type;
    }

    /**
     * Implementing the comparison logic in enums avoids the use of switch statements.
     * In this case, it actually doesn't make sense to wrap the enum in another class.
     * You can simply execute
     * <p>
     * CompareType.RANK.compare(..., ...)
     */
    enum CompareType implements Comparator<Card> {
        RANK {
            @Override
            public int compare(@NotNull Card c1, @NotNull Card c2) {
                return c1.getRank().ordinal() - c2.getRank().ordinal();
            }
        },
        SUIT {
            @Override
            public int compare(@NotNull Card c1, @NotNull Card c2) {
                return c1.getSuit().ordinal() - c2.getSuit().ordinal();
            }
        };
    }

    @Override
    public int compare(@NotNull Card o1, @NotNull Card o2) {
        return type.compare(o1, o2);
    }
}