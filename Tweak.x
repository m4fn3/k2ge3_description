#include <dlfcn.h>
#import <substrate.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSBundle.h>


int sendChatChecked(void* this_) {
    return 0;
}
int destroyMessage(void* this_){
    return 0;
}

%ctor {
    // app directory
    NSString *appPath = [NSString stringWithFormat: @"%@%@", [[NSBundle mainBundle] bundlePath], @"/LINE"];
    void* exec = dlopen([appPath UTF8String], RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
    // symbol
    void* sym_sendChatChecked = dlsym(exec, "LineTalkService_sendChatChecked");
    void* sym_destroyMessage = dlsym(exec, "$s13LineMessaging7ChatDAOC14destroyMessage4with2inySo0A9OperationC_So22NSManagedObjectContextCtFZ");
    // hook
    MSHookFunction((void *)sym_sendChatChecked ,(void*)sendChatChecked, NULL);
    MSHookFunction((void *)sym_destroyMessage ,(void*)destroyMessage, NULL);
}
