public class PreventDiscountChangeTriggerHandler {

    public static void preventDiscountChange(List<QuoteLineItem> newList,
                                             Map<Id, QuoteLineItem> oldMap){

            for(QuoteLineItem item : newList){

        QuoteLineItem oldItem = oldMap.get(item.Id);

        // Check if discount actually changed
        if(item.Discount != null && oldItem.Discount != null &&
           item.Discount.setScale(2) != oldItem.Discount.setScale(2)){

            Quote q = [SELECT Status FROM Quote WHERE Id = :item.QuoteId];

            if(q.Status == 'Submitted'){
                item.addError('Discount cannot be changed after submission');
            }
        }
    }
}
}