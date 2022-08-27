import frida
import sys


def on_message(message, data):
    if message["type"] == "error":  # error
        print(f"{message['stack']}")
    else:  # data
        print(message["payload"])


def on_detach(type_, log):
    print("Process terminated!")


device = frida.get_usb_device()  # device
pid = device.spawn("jp.naver.line")  # launch
session = device.attach(pid)  # attach

with open("script.js", encoding="utf-8") as file:
    js_script = file.read()  # JavaScript
script = session.create_script(js_script)  # load
script.on("message", on_message)
session.on("detached", on_detach)
script.load()  # apply js
device.resume(pid)
sys.stdin.read()
