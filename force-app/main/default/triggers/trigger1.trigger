trigger trigger1 on Account (before insert) {
System.debug('Hello ! This trigger is on Account object before inserting');
}