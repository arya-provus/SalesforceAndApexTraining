public class DiscountTriggerHandler {

    public static void handleDiscount(List<QuoteLineItem> qli){
        Set<Id> quoteIds=new Set<Id>();
        Set<Id> productIds=new Set<Id>();
        if(qli==null){
            system.debug('qli is null');
            return;
        }
        for(QuoteLineItem item :qli){
            if(item.Exceeds_Max_Discount__c==true){
                quoteIds.add(item.QuoteId);
            }
        }
        
        List<Quote> quoteList= [select Id, Status, Approval_Required__c from Quote where Id in :quoteIds];
        for(Quote q:quoteList){
            q.Status='Submitted';
            q.Approval_Required__c= true;
        }
        update quoteList;
        
        
    }
    
}