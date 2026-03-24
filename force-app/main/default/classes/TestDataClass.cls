public class TestDataClass {

    public static Product_Category__c createProductCategory(){

        Product_Category__c category = new Product_Category__c(
            Name = 'Test Category',
            Max_Discount__c = 20
        );
        insert category;

        return category;
    }

    public static Product2 createProduct(){

        Product_Category__c category = createProductCategory();

        Product2 product = new Product2(
            Name = 'Test Product',
            IsActive = true,
            Product_Category__c = category.Id
        );
        insert product;

        return product;
    }

    public static PricebookEntry createPricebookEntry(Id productId){

        PricebookEntry pbe = new PricebookEntry(
            Product2Id = productId,
            Pricebook2Id = Test.getStandardPricebookId(),
            UnitPrice = 100,
            IsActive = true
        );
        insert pbe;

        return pbe;
    }

    public static Opportunity createOpportunity(){

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(5)
        );
        insert opp;

        return opp;
    }

    public static Quote createQuote(){

        Opportunity opp = createOpportunity();

        Quote quote = new Quote(
            Name = 'Test Quote',
            OpportunityId = opp.Id,
            Status = 'Draft',
            Pricebook2Id = Test.getStandardPricebookId(),
            Approval_Required__c = false
        );
        insert quote;

        return quote;
    }

    public static QuoteLineItem createQuoteLineItem(Decimal discount){

        Product2 product = createProduct();
        PricebookEntry pbe = createPricebookEntry(product.Id);
        Quote quote = createQuote();

        QuoteLineItem qli = new QuoteLineItem(
            QuoteId = quote.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 1,
            UnitPrice = 100,
            Discount = discount
        );
        insert qli;

        return qli;
    }

    public static QuoteLineItem createCompleteTestData(Decimal discount){

        return createQuoteLineItem(discount);
    }
    
}