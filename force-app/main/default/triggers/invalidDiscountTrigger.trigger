trigger invalidDiscountTrigger on QuoteLineItem (before insert, before update) {
	InvalidDiscountTriggerHandler.invalidDiscount(Trigger.new);
}