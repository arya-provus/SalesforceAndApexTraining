@isTest
public class QuantityValidationTriggerTest {

   @isTest
static void testNegativeQuantity() {
    Product2 product = TestDataClass.createProduct();
    PricebookEntry pbe = TestDataClass.createPricebookEntry(product.Id);
    Quote quote = TestDataClass.createQuote();

    QuoteLineItem qli = new QuoteLineItem(
        QuoteId = quote.Id,
        PricebookEntryId = pbe.Id,
        Quantity = -2,
        UnitPrice = 100,
        Discount = 10
    );

    Test.startTest();
    try {
        insert qli;
        System.assert(false, 'The insert should have failed due to negative quantity.');
    } catch (DmlException e) {
        String message = e.getDmlMessage(0);
        System.assert(message.contains('Quantity must be greater than 0'), 
            'Expected message "Quantity must be greater than 0" but got: ' + message);
    }
    Test.stopTest();
}
    @isTest
    static void testValidQuantity() {
        QuoteLineItem qli = TestDataClass.createCompleteTestData(10);

        qli.Quantity = 2;

        Test.startTest();
        update qli;
        Test.stopTest();

        System.assertNotEquals(null, qli.Id, 'QuoteLineItem should be inserted/updated successfully');
    }
}