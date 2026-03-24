@isTest
public class TestQuantityValidationTrigger {

   @isTest
static void testNegativeQuantity() {
    // Create test data
    Product2 product = TestDataClass.createProduct();
    PricebookEntry pbe = TestDataClass.createPricebookEntry(product.Id);
    Quote quote = TestDataClass.createQuote();

    // Manually set negative quantity
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
        // Use TestDataClass helper for valid quantity
        QuoteLineItem qli = TestDataClass.createCompleteTestData(10);

        // Update quantity to a valid number just to be explicit
        qli.Quantity = 2;

        Test.startTest();
        update qli;
        Test.stopTest();

        System.assertNotEquals(null, qli.Id, 'QuoteLineItem should be inserted/updated successfully');
    }
}