trigger discountTrigger on QuoteLineItem (after insert, after update) {

    System.debug('trigger invoked!!!');
    DiscountTriggerHandler.handleDiscount(Trigger.new);

}