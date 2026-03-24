// trigger PreventDiscountChangeTrigger on QuoteLineItem (before update) {

//     DiscountValidationAfterSubmitHandler.preventDiscountChange(Trigger.new, Trigger.oldMap);

// }

trigger PreventDiscountChangeTrigger on QuoteLineItem (before update) {

    for(QuoteLineItem item : Trigger.new){

        QuoteLineItem oldItem = Trigger.oldMap.get(item.Id);

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