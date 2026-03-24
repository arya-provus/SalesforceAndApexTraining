trigger trigger3 on Account (before insert, after insert) {

    if(Trigger.isBefore){
        TriggerHandler1.beforeInsertAccount(Trigger.new);
    }
    else{
        TriggerHandler1.afterInsertAccount(Trigger.new);
    }
    
}