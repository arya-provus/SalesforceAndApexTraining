public class QuantityValidationTriggerHandler {

    public static void handleQuantity(List<QuoteLineItem> qli){
       for(QuoteLineItem item: qli){
        if(item.Quantity == null || item.Quantity <= 0){
            item.addError('Quantity must be greater than 0');
        }
    	}
    }
}