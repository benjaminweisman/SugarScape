SugarGrid myGrid;
Graph numGraph;
Graph ageAvgGraph;
Graph wealthGraph;
Graph ageGraph;

void setup() { 
  /* Testing */
  (new SquareTester()).test();
  (new AgentTester()).test();
  (new SugarGridTester()).test();  
  (new GrowbackRuleTester()).test();
  (new StackTester()).test();
  (new QueueTester()).test();
  (new ReplacementRuleTester()).test();
  (new SeasonalGrowbackRuleTester()).test();

  size(1200,800);
  background(128);
  
  int minMetabolism = 3;
  int maxMetabolism = 6;
  int minVision = 2;
  int maxVision = 4;
  int minInitialSugar = 5;
  int maxInitialSugar = 10;
  MovementRule mr = new PollutionMovementRule();
  AgentFactory af = new AgentFactory(minMetabolism, maxMetabolism, minVision, maxVision, 
                                     minInitialSugar, maxInitialSugar, mr);

  int alpha = 2;
  int beta = 1;
  int gamma = 1;
  int equator = 1;
  int numSquares = 4; 
  SeasonalGrowbackRule sgr = new SeasonalGrowbackRule(alpha, beta, gamma, equator, numSquares);
  
  myGrid = new SugarGrid(40,40,20, sgr);
  myGrid.addSugarBlob(15,15,2,8);
  myGrid.addSugarBlob(35,25,2,8);
  for (int i = 0; i < 75; i++) {
    Agent a = af.makeAgent();
    myGrid.addAgentAtRandom(a);
  }
  
  numGraph = new NumberOfAgentsTimeSeriesGraph(850, 50, 300, 150);
  ageAvgGraph = new AverageAgentAgeTimeSeriesGraph(850, 250, 300, 150, 1000);
  wealthGraph = new SortedAgentWealthGraph(850, 450, 300, 150);
  //ageGraph = new AgeCDFGraph(850, 650, 300, 150);
  frameRate(2);
  
  ArrayList ar = new ArrayList<Pair>();
  ar.add(new Pair<String,Integer> ("test", 1)); 
  ar.add(new Pair<String,Integer> ("test2", 2)); 
  ar.add(new Pair<String,Integer> ("test3", 3)); 
  //ar.remove(0);
  for(int i = 0; i <= ar.size(); i++){
    System.out.print(ar);
  }
}

void draw() {  
  numGraph.update(myGrid);
  ageAvgGraph.update(myGrid);
  wealthGraph.update(myGrid);
  //ageGraph.update(myGrid);
  myGrid.update();
  //background(255);
  myGrid.display();
  

}
