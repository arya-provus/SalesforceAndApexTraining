@isTest
public class TestDiscountTrigger {
	/*@testSetup
    static void setupData(){
        Product_Category__c productCategory=new Product_Category__c(
            Name='Product category for testing DiscountTrigger',
            Max_Discount__c= 25.00
        );
        insert productCategory;
        
        Product2 product=new Product2(
        	Name='product 1 for testing discountTrigger',
            IsActive=true,
            Product_Category__c=productCategory.Id
        );
        insert product;
        

        PricebookEntry pbe = new PricebookEntry(
            Product2Id = product.Id,
            Pricebook2Id = Test.getStandardPricebookId(),
            UnitPrice = 100,
            IsActive = true
        );
        insert pbe;
        
        Opportunity opp=new Opportunity(
        	Name='opportunity for testing discountTriggers',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(5)
        );
        insert opp;
        
        Quote quote = new Quote(
        Name = 'Test Quote for testing discountTrigger',
        OpportunityId = opp.Id,
        Status = 'Draft',
        Approval_Required__c = false,
        Pricebook2Id = Test.getStandardPricebookId()
        );
        insert quote;
    }
*/
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