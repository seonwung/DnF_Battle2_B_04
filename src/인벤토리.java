package DnF;

import java.util.ArrayList;
import java.util.List;

public class 인벤토리 {
    private List<아이템> 아이템리스트 = new ArrayList<>();
    private int 최대용량 = 10;

    public boolean 아이템추가(아이템 아이템) {
        if (용량초과여부()) {
            return false;
        }
        아이템리스트.add(아이템);
        return true;
    }

    public boolean 용량초과여부() {
        return 아이템리스트.size() >= 최대용량;
    }

    public List<아이템> get아이템리스트() {
        return 아이템리스트;
    }
    
    public int get현재수량() {
        return 아이템리스트.size();
    }
}