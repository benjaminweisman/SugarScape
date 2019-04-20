import java.util.Collections;
import java.util.Random;
import java.util.List;
import java.util.Map;

class FertilityRule {
  Map<Character, Integer[]> childbearingOnset;
  Map<Character, Integer[]> climactericOnset;
  Map<Agent, Integer[]> map;
  Random random = new Random();

  
  public FertilityRule(Map<Character, Integer[]> childbearingOnset, Map<Character,Integer[]> climactericOnset){
    this.childbearingOnset = childbearingOnset;
    this.climactericOnset = climactericOnset;
    this.map = new HashMap<Agent, Integer[]>();
  }
  
  public boolean isFertile(Agent a){
    if (a.sugarLevel <= 0){
      map.remove(a);
      return false;
    }
    
    if (map.containsKey(a) == false){
      Integer[] childbearing = childbearingOnset.get(a.getSex());
      Integer[] climacteric = climactericOnset.get(a.getSex());
      int childbearingAge = (int)random(childbearing[0], childbearing[1] + 1);
      int climactericAge =  (int)random(climacteric[0], climacteric[1] + 1);
      Integer[] fertile = {childbearingAge, climactericAge, a.sugarLevel};
    }
    //return true only if: c <= a.getAge() < o, using the values of c and o that were stored for this agent earlier.

    Integer[] fertileAgents = map.get(a);
    if(fertileAgents[0] <= a.getAge() && fertileAgents[1] > a.getAge() && fertileAgents[2] <= a.sugarLevel){
      return true;
    }
    return false;
  }
  
  public boolean canBreed(Agent a, Agent b, LinkedList<Square> local){
    int l = 0;
    if(isFertile(a) && isFertile(b) && a.getSex() != b.getSex()){
      for(int i = 0; i < local.size();i++){
        if(local.get(i).getAgent().equals(b)){
          l = 1;
        }
        if(local.get(i).getAgent() == null){
          if (l == 1)
            return true;
          }
        }
      }
      return false;
    }
    
  public Agent breed(Agent a, Agent b, LinkedList<Square> aLocal, LinkedList<Square> bLocal){
    if(canBreed(a,b, aLocal) == false && canBreed(a,b, bLocal) == false){
      return null;
    }
      int metabolism;
      boolean parentMetabolism = random.nextBoolean();
      
      if (parentMetabolism == false){
        metabolism = a.getMetabolism();
      }
      metabolism = b.getMetabolism();
      
      int vision;
      boolean parentVision = random.nextBoolean();
      
      if (parentVision == false){
        vision = a.getVision();
      }
      vision = b.getVision();
      
      MovementRule m = a.getMovementRule();
      
      char sex;
      boolean parentSex = random.nextBoolean();
      
      if (parentSex == false){
        sex = a.getSex();
      }
      sex = b.getSex();
      
      Agent child = new Agent(metabolism, vision, 0, m, sex);
      
      a.gift(child, map.get(a)[2]/2);
      b.gift(child, map.get(b)[2]/2);
      
      child.nurture(a,b);
      
      if ((int(2) == 0)){
        for(Square s:aLocal){
          if (s.getAgent() == null) s.setAgent(child);
        }
      }
      for(Square s:bLocal){
        if (s.getAgent() == null) s.setAgent(child);
      }
      return child;
   }
}
