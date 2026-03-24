public class InvalidDiscountTriggerHandler {

    public static void invalidDiscount(List<QuoteLineItem> qli){
       for(QuoteLineItem item: qli){
            if(item.Discount>100 || item.Discount<0){
                item.addError('Invalid Discount');
            }
    	}
    }
}