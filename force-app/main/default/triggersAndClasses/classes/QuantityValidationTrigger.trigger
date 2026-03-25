trigger QuantityValidationTrigger on QuoteLineItem (before insert, before update) {

QuantityValidationTriggerHandler.handleQuantity(Trigger.new);
}