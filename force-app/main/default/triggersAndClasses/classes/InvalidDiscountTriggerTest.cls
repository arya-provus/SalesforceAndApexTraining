@isTest
public class InvalidDiscountTriggerTest{
@isTest
static void testDiscountgraterthan100() {
    Quote quote = TestDataClass.createQuote();
    update quote;

    QuoteLineItem qli = new QuoteLineItem(
        Quantity = 1,
        UnitPrice = 100,
        PricebookEntryId = TestDataClass.createPricebookEntry((TestDataClass.createProduct()).Id).Id,
        QuoteId = quote.Id,   
        Discount = 101
    );
    


    Test.startTest();
    try {
        insert qli;
        System.assert(false, 'Expected error was not thrown for discount greater than 100');
    } catch (DmlException e) {
        System.assert(e.getDmlMessage(0).contains('Invalid Discount'), 
            'Expected specific error message but got: ' + e.getDmlMessage(0));
    }
    Test.stopTest();
}

    @isTest
static void testDiscountLessThanZero() {
    Quote quote = TestDataClass.createQuote();
    update quote;

    QuoteLineItem qli = new QuoteLineItem(
        Quantity = 1,
        UnitPrice = 100,
        PricebookEntryId = TestDataClass.createPricebookEntry((TestDataClass.createProduct()).Id).Id,
        QuoteId = quote.Id,   
        Discount = -1
    );
    


    Test.startTest();
    try {
        insert qli;
        System.assert(false, 'Expected error was not thrown for discount less than 0');
    } catch (DmlException e) {
        System.assert(e.getDmlMessage(0).contains('Invalid Discount'), 
            'Expected specific error message but got: ' + e.getDmlMessage(0));
    }
    Test.stopTest();
}
}