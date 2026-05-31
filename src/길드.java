package DnF;

import java.util.ArrayList;
import java.util.List;

public class 길드 {
    private String 길드명;
    private List<캐릭터> 캐릭터리스트 = new ArrayList<>();
    private int 최대인원 = 5;

    public 길드(String 길드명) {
        this.길드명 = 길드명;
    }

    public boolean 캐릭터가입(캐릭터 캐릭터) {
        if (정원초과확인()) {
            return false;
        }
        for (캐릭터 c : 캐릭터리스트) {
            if (c.get캐릭터명().equals(캐릭터.get캐릭터명())) {
                return false; 
            }
        }
        캐릭터리스트.add(캐릭터);
        return true;
    }

    public boolean 정원초과확인() {
        return 캐릭터리스트.size() >= 최대인원;
    }

    public String get길드명() { return 길드명; }
    public List<캐릭터> get캐릭터리스트() { return 캐릭터리스트; }
    public int get현재원() { return 캐릭터리스트.size(); }
}