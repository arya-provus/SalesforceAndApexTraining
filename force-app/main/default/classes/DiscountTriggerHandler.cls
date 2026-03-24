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
        
        /*
        for(QuoteLineItem item :qli){
            if(item.Product2Id!=null){
                productIds.add(item.Product2Id);
            }
        }
        
        Map<Id, Product2> productMap = new Map<Id, Product2>(
            [SELECT Id,
                    Product_Category__c,
                    Product_Category__r.Max_Discount__c
             FROM Product2
             WHERE Id IN :productIds]);
            
        for(QuoteLineItem item: qli)
        {
            
            if(productMap.containsKey(item.Product2Id)){
                Decimal maxDiscount=productMap.get(item.Product2Id).Product_Category__r.Max_Discount__c;
                if(maxDiscount<item.Discount){
                    quoteIds.add(item.QuoteId);
                }
                else{
                    return;
                }
                
            }
        }
        List<Quote> quoteList= [select Id, Status, Approval_Required__c from Quote where Id in :quoteIds];
        for(Quote q:quoteList){
            q.Status='Submitted';
            q.Approval_Required__c= true;
        }
        update quoteList;

*/
    }
    
}