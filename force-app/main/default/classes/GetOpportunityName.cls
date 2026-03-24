public with sharing class GetOpportunityName {
    public static void getName(){
        Account acc= [SELECT Id FROM Account LIMIT 1];
        List <Opportunity> oppList= [SELECT Name FROM Opportunity WHERE AccountId = :acc.Id];
        for(Opportunity opp: oppList){
            System.debug('Opportunity Name: ' + opp.Name);
        }
    }
}