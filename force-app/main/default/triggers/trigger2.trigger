trigger trigger2 on Account (before insert) {

    for(Account acc: Trigger.new){
        acc.Description='This descroiption is being added by trigger';
    }
}