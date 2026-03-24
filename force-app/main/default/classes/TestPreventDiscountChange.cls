@isTest
public class TestPreventDiscountChange {
@isTest
static void testDiscountChangeNotAllowed() {
    // Step 1: Create a Quote and force it to a "Locked" status
    Quote quote = TestDataClass.createQuote();
    quote.Status = 'Submitted'; // Change this to whatever status blocks updates in your trigger
    update quote;

    QuoteLineItem qli = new QuoteLineItem(
        Quantity = 1,
        UnitPrice = 100,
        PricebookEntryId = TestDataClass.createPricebookEntry((TestDataClass.createProduct()).Id).Id,
        QuoteId = quote.Id,   
        Discount = 10
    );
    insert qli;

    // Step 2: Try to change discount
    qli.Discount = 20;

    Test.startTest();
    try {
        update qli;
        System.assert(false, 'Expected error was not thrown because Quote is NOT in Draft status');
    } catch (DmlException e) {
        System.assert(e.getDmlMessage(0).contains('Discount cannot be changed'), 
            'Expected specific error message but got: ' + e.getDmlMessage(0));
    }
    Test.stopTest();
}

    // ---------- Test: Discount change should be allowed when Quote is Draft ----------
    @isTest
    static void testDiscountChangeAllowed() {

        // Create test data using factory
        Product2 product = TestDataClass.createProduct();
        PricebookEntry pbe = TestDataClass.createPricebookEntry(product.Id);
        Quote quote = TestDataClass.createQuote();   // Status = Draft

        // Insert QuoteLineItem
        QuoteLineItem qli = new QuoteLineItem(
            QuoteId = quote.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 1,
            UnitPrice = 100,
            Discount = 10
        );
        insert qli;

        Test.startTest();

        // Change discount (should work)
        qli.Discount = 20;
        update qli;

        Test.stopTest();

        // Verify discount updated
        QuoteLineItem updatedQLI = [
            SELECT Discount
            FROM QuoteLineItem
            WHERE Id = :qli.Id
        ];

        System.assertEquals(20, updatedQLI.Discount);
    }
}