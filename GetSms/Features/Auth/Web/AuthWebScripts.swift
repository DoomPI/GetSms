//
//  AuthWebScripts.swift
//  GetSms
//
//  Created by Роман Ломтев on 09.04.2023.
//

let authScript = """
    (function() {
        return (document.getElementsByClassName('sidebar')[0].getAttribute('data-api'));
    })();
"""
