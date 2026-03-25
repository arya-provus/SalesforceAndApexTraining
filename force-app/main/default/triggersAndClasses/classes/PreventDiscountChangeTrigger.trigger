

trigger PreventDiscountChangeTrigger on QuoteLineItem (before update) {

PreventDiscountChangeTriggerHandler.preventDiscountChange(Trigger.new, Trigger.oldMap);
}