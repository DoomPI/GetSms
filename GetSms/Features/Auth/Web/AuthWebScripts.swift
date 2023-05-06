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

let hideAuthComponets = """
(function() { document.getElementsByClassName('navbar-button')[0].style.display='none';
    document.getElementsByClassName('navbar-collapsed')[0].style.display='none';
    document.getElementsByClassName('col-xl-4')[0].style.display='none'; })()
"""

let hideComponets = """
(function() { document.getElementsByClassName('navbar-button')[0].style.display='none';
            document.getElementsByClassName('navbar-collapsed')[0].style.display='none';
            document.getElementsByClassName('btn btn-transparent')[0].style.display='none';
            document.getElementsByClassName('active-number')[0].style.display='none';
            document.getElementsByClassName('list-number active')[0].style.display='none';})()
"""
