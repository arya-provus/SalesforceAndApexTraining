public class OpportunityUsingAccount {

    public void createOpportunity(){
        Account acc= new Account();
        acc=[SELECT Id, Name FROM Account LIMIT 1];
        Opportunity opp=new Opportunity();
        opp.AccountId=acc.id;
        opp.Name=acc.Name +'opp';
        opp.StageName='Prospecting';
        opp.CloseDate=System.Today();
        insert opp;
        
    }
}