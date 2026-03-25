@isTest
public class DiscountTriggerTest {

@isTest
    static void testDiscountOnInsert() {
        Product2 product = TestDataClass.createProduct();
        PricebookEntry pbe = TestDataClass.createPricebookEntry(product.Id);
        Quote quote = TestDataClass.createQuote();

        Test.startTest();

        QuoteLineItem qli = new QuoteLineItem(
            QuoteId = quote.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 1,
            UnitPrice = 100,
            Discount = 27
        );
        insert qli;

        Test.stopTest();

        Quote updatedQuote = [
            SELECT Status, Approval_Required__c
            FROM Quote
            WHERE Id = :quote.Id
        ];

        System.assertEquals('Submitted', updatedQuote.Status);
        System.assertEquals(true, updatedQuote.Approval_Required__c);
    }
    @isTest
    static void testDiscountOnUpdate() {
        Product2 product = TestDataClass.createProduct();
        PricebookEntry pbe = TestDataClass.createPricebookEntry(product.Id);
        Quote quote = TestDataClass.createQuote();

        QuoteLineItem qli = new QuoteLineItem(
            QuoteId = quote.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 1,
            UnitPrice = 100,
            Discount = 5
        );
        insert qli;

        Test.startTest();
        
        qli.Discount = 30;
        update qli;

        Test.stopTest();

        Quote updatedQuote = [
            SELECT Status, Approval_Required__c
            FROM Quote
            WHERE Id = :quote.Id
        ];

        System.assertEquals('Submitted', updatedQuote.Status);
        System.assertEquals(true, updatedQuote.Approval_Required__c);
    }
}