package DnF;

public abstract class 캐릭터 {
    protected String 캐릭터명;
    protected int 레벨;
    protected int 체력;
    protected int 공격력;
    
    protected 인벤토리 인벤토리 = new 인벤토리(); 

    public abstract int 스킬발동();
    public abstract String get스킬명(); 

    public String get캐릭터명() { return 캐릭터명; }
    public int get레벨() { return 레벨; }
    public int get체력() { return 체력; }
    public int get공격력() { return 공격력; }
    
    public 인벤토리 인벤토리조회() { return 인벤토리; }
}