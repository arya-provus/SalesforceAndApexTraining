public class TriggerHandler1 {

    public static void beforeInsertAccount(List<Account> accList){
       for(Account acc:accList){
           if(acc.Industry=='Technology'){
              acc.Description='adding description with before insert trigger by triggerhandler class method if industry is technology';
           }
           else{
              acc.Description='adding description with before insert trigger by triggerhandler class method in remaining cases';
           }
       }
    }
    
        public static void afterInsertAccount(List<Account> accList){
       for(Account acc:accList){
           Opportunity opportunity= new Opportunity();
           
           if(acc.Industry=='Technology'){
               opportunity.AccountId=acc.Id;
               opportunity.Name='opportunity for account if industry is Technology '+acc.Id;
               opportunity.CloseDate=System.Today();
               opportunity.StageName='Prospecting';
           }
           else{
               opportunity.AccountId=acc.Id;
               opportunity.Name='opportunity for account if industry is not Technology ' + acc.Id;
               opportunity.CloseDate=System.Today();
               opportunity.StageName='Prospecting';
               
           }
           insert opportunity;
       }
    }
    
    
  /*  public static void afterInsertContact(List<Contact> conList){
       for(Contact con:conList){
           if(con.Name=='Ms. Arya Godase'){
              con.Title='adding title with after insert trigger by triggerhandler class method if name is arya';
           }
           else{
			  con.Title='adding title with after insert trigger by triggerhandler class method';           }
       }
    }
*/
    
}