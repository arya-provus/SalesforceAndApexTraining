trigger QuantityValidationTrigger on QuoteLineItem (before insert, before update) {

    for(QuoteLineItem item : Trigger.new){

        if(item.Quantity == null || item.Quantity <= 0){
            item.addError('Quantity must be greater than 0');
        }
    }
}