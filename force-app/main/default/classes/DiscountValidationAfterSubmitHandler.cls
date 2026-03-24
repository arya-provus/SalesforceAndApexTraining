public class DiscountValidationAfterSubmitHandler {

    public static void preventDiscountChange(List<QuoteLineItem> newList,
                                             Map<Id, QuoteLineItem> oldMap){

        Set<Id> quoteIds = new Set<Id>();

        // Step 1: collect quote ids only where discount changed
        for(QuoteLineItem newItem : newList){

            QuoteLineItem oldItem = oldMap.get(newItem.Id);

            if(newItem.Discount != oldItem.Discount){
                quoteIds.add(newItem.QuoteId);
            }
        }

        // Step 2: get quote status
        Map<Id, Quote> quoteMap = new Map<Id, Quote>(
            [SELECT Id, Status
             FROM Quote
             WHERE Id IN :quoteIds]
        );

        // Step 3: stop update if quote is submitted
        for(QuoteLineItem newItem : newList){

            QuoteLineItem oldItem = oldMap.get(newItem.Id);

            if(newItem.Discount != oldItem.Discount){

                Quote parentQuote = quoteMap.get(newItem.QuoteId);

                if(parentQuote != null && parentQuote.Status == 'Submitted'){
                    newItem.addError('Discount cannot be changed after submission');
                }
            }
        }
    }
}