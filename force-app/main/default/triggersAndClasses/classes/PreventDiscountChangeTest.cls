@isTest
public class PreventDiscountChangeTest {
@isTest
static void testDiscountChangeNotAllowed() {
    Quote quote = TestDataClass.createQuote();
    quote.Status = 'Submitted'; 
    update quote;

    QuoteLineItem qli = new QuoteLineItem(
        Quantity = 1,
        UnitPrice = 100,
        PricebookEntryId = TestDataClass.createPricebookEntry((TestDataClass.createProduct()).Id).Id,
        QuoteId = quote.Id,   
        Discount = 10
    );
    insert qli;


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

    @isTest
    static void testDiscountChangeAllowed() {

        Product2 product = TestDataClass.createProduct();
        PricebookEntry pbe = TestDataClass.createPricebookEntry(product.Id);
        Quote quote = TestDataClass.createQuote();   
        QuoteLineItem qli = new QuoteLineItem(
            QuoteId = quote.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 1,
            UnitPrice = 100,
            Discount = 10
        );
        insert qli;

        Test.startTest();

        qli.Discount = 20;
        update qli;

        Test.stopTest();

        QuoteLineItem updatedQLI = [
            SELECT Discount
            FROM QuoteLineItem
            WHERE Id = :qli.Id
        ];

        System.assertEquals(20, updatedQLI.Discount);
    }
}