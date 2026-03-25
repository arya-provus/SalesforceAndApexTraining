// trigger PreventDiscountChangeTrigger on QuoteLineItem (before update) {

//     DiscountValidationAfterSubmitHandler.preventDiscountChange(Trigger.new, Trigger.oldMap);

// }

trigger PreventDiscountChangeTrigger on QuoteLineItem (before update) {

PreventDiscountChangeTriggerHandler.preventDiscountChange(Trigger.new, Trigger.oldMap);
}