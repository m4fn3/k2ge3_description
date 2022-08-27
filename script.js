let lib = Process.findModuleByName("LINE")  // library

function symbol(name) {
    return lib.getExportByName(name) // symbol
}

// hook
Interceptor.attach(symbol("LineTalkService_sendChatChecked"), {
    onEnter(args) {
        console.log("call -> sendChatChecked()")
    },
    onLeave(ret) {
        console.log(ret)
    }
})
