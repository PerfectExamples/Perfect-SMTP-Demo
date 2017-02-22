//
//  main.swift
//  Perfect-SMTP-Demo
//
//  Created by Rockford Wei on 2017-02-22.
//  Copyright © 2017 PerfectlySoft. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2017 - 2018 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

// in this demo, the stdlib sleep() function will be called, so use this import.
#if os(Linux)
import LinuxBridge
#else
import Darwin
#endif

// import the Perfect SMTP library
import PerfectSMTP

// setup the mail server login information, *NOTE* please modify these information
let client = SMTPClient(url: "smtp://smtp.gmx.com", username: "judysmith1964@gmx.com", password:"yourpassword")

// draft an email
var email = EMail(client: client)

// set the subject
email.subject = "hello"

// set the sender
email.from = Recipient(name: "Judith Smith", address: "judysmith1964@gmx.com")

// set the html content
email.content = "<h1>Hello, world!</h1><hr><img src='http://www.perfect.org/images/perfect-logo-2-0.svg'>"

// set the recipients (include the sender self)
email.to.append(email.from)
email.cc.append(Recipient(address: "rockywei@gmx.com"))

// attach some files, *NOTE* please change to your local files instead.
email.attachments.append("/tmp/hello.txt")
email.attachments.append("/tmp/welcome.png")

var wait = true
do {
  try email.send { code, header, body in
    print("response code: \(code)")
    print("response header: \(header)")
    print("response body: \(body)")
    wait = false
  }//end send
}catch(let err) {
  print("Failed to send: \(err)")
}//end do

while(wait) {
  sleep(1)
}//end while

print("done!")
