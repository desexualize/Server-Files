webpackJsonp([1], [, , , , , , , , , , function(t, e, n) {
    "use strict";
    var s = n(3);
    var r = n.n(s);
    var i = n(39);
    var a = n.n(i);
    var o = n(8);
    var c = n.n(o);
    var u = n(27);
    var l = n.n(u);
    var f = n(7);
    var h = n.n(f);
    var p = n(81);
    var d = n.n(p);
    var v = n(82);
    var m = n.n(v);
    var g = n(32);
    var _ = n.n(g);
    var w = n(21);
    var k = n(153);
    var y = n(15);
    var b = n(37);
    var C = n.n(b);
    var S = n(352);
    var A = n.n(S);
    var E = _()(A.a);
    var T = false;
    var I = "http://AQUAphone/";
    var P = function() {
        function t() {
            var e = this;
            d()(this, t);
            window.addEventListener("message", function(t) {
                var n = t.data.event;
                if (n !== undefined && typeof e["on" + n] === "function") {
                    e["on" + n](t.data)
                } else if (t.data.show !== undefined) {
                    w["a"].commit("SET_PHONE_VISIBILITY", t.data.show)
                }
            });
            this.config = null;
            this.voiceRTC = null;
            this.soundList = {}
        }
        m()(t, [{
            key: "post",
            value: function() {
                var t = h()(c.a.mark(function t(e, n) {
                    var s, r;
                    return c.a.wrap(function t(i) {
                        while (1) {
                            switch (i.prev = i.next) {
                                case 0:
                                    s = n === undefined ? "{}" : l()(n);
                                    i.next = 3;
                                    return window.jQuery.post(I + e, s);
                                case 3:
                                    r = i.sent;
                                    return i.abrupt("return", JSON.parse(r));
                                case 5:
                                case "end":
                                    return i.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e, n) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "log",
            value: function() {
                var t = h()(c.a.mark(function t() {
                    for (var e = arguments.length, n = Array(e), s = 0; s < e; s++) {
                        n[s] = arguments[s]
                    }
                    var r;
                    return c.a.wrap(function t(e) {
                        while (1) {
                            switch (e.prev = e.next) {
                                case 0:
                                    if (false) {
                                        e.next = 4;
                                        break
                                    }
                                    return e.abrupt("return", this.post("log", n));
                                case 4:
                                    return e.abrupt("return", (r = console).log.apply(r, n));
                                case 5:
                                case "end":
                                    return e.stop()
                            }
                        }
                    }, t, this)
                }));

                function e() {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "convertEmoji",
            value: function t(e) {
                var n = true;
                var s = false;
                var r = undefined;
                try {
                    for (var i = a()(E), o; !(n = (o = i.next()).done); n = true) {
                        var c = o.value;
                        e = e.replace(new RegExp(":" + c + ":", "g"), A.a[c])
                    }
                } catch (t) {
                    s = true;
                    r = t
                } finally {
                    try {
                        if (!n && i.return) {
                            i.return()
                        }
                    } finally {
                        if (s) {
                            throw r
                        }
                    }
                }
                return e
            }
        }, {
            key: "sendMessage",
            value: function() {
                var t = h()(c.a.mark(function t(e, n) {
                    return c.a.wrap(function t(s) {
                        while (1) {
                            switch (s.prev = s.next) {
                                case 0:
                                    return s.abrupt("return", this.post("sendMessage", {
                                        phoneNumber: e,
                                        message: n
                                    }));
                                case 1:
                                case "end":
                                    return s.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e, n) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "deleteMessage",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    return n.abrupt("return", this.post("deleteMessage", {
                                        id: e
                                    }));
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "deleteMessagesNumber",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    return n.abrupt("return", this.post("deleteMessageNumber", {
                                        number: e
                                    }));
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "deleteAllMessages",
            value: function() {
                var t = h()(c.a.mark(function t() {
                    return c.a.wrap(function t(e) {
                        while (1) {
                            switch (e.prev = e.next) {
                                case 0:
                                    return e.abrupt("return", this.post("deleteAllMessage"));
                                case 1:
                                case "end":
                                    return e.stop()
                            }
                        }
                    }, t, this)
                }));

                function e() {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "setMessageRead",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    return n.abrupt("return", this.post("setReadMessageNumber", {
                                        number: e
                                    }));
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "updateContact",
            value: function() {
                var t = h()(c.a.mark(function t(e, n, s) {
                    return c.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    return r.abrupt("return", this.post("updateContact", {
                                        id: e,
                                        display: n,
                                        phoneNumber: s
                                    }));
                                case 1:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e, n, s) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "addContact",
            value: function() {
                var t = h()(c.a.mark(function t(e, n) {
                    return c.a.wrap(function t(s) {
                        while (1) {
                            switch (s.prev = s.next) {
                                case 0:
                                    return s.abrupt("return", this.post("addContact", {
                                        display: e,
                                        phoneNumber: n
                                    }));
                                case 1:
                                case "end":
                                    return s.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e, n) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "deleteContact",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    return n.abrupt("return", this.post("deleteContact", {
                                        id: e
                                    }));
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "appelsDeleteHistorique",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    return n.abrupt("return", this.post("appelsDeleteHistorique", {
                                        numero: e
                                    }));
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "appelsDeleteAllHistorique",
            value: function() {
                var t = h()(c.a.mark(function t() {
                    return c.a.wrap(function t(e) {
                        while (1) {
                            switch (e.prev = e.next) {
                                case 0:
                                    return e.abrupt("return", this.post("appelsDeleteAllHistorique"));
                                case 1:
                                case "end":
                                    return e.stop()
                            }
                        }
                    }, t, this)
                }));

                function e() {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "closePhone",
            value: function() {
                var t = h()(c.a.mark(function t() {
                    return c.a.wrap(function t(e) {
                        while (1) {
                            switch (e.prev = e.next) {
                                case 0:
                                    return e.abrupt("return", this.post("closePhone"));
                                case 1:
                                case "end":
                                    return e.stop()
                            }
                        }
                    }, t, this)
                }));

                function e() {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "setUseMouse",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    return n.abrupt("return", this.post("useMouse", e));
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "setGPS",
            value: function() {
                var t = h()(c.a.mark(function t(e, n) {
                    return c.a.wrap(function t(s) {
                        while (1) {
                            switch (s.prev = s.next) {
                                case 0:
                                    return s.abrupt("return", this.post("setGPS", {
                                        x: e,
                                        y: n
                                    }));
                                case 1:
                                case "end":
                                    return s.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e, n) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "takePhoto",
            value: function() {
                var t = h()(c.a.mark(function t() {
                    var e;
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    w["a"].commit("SET_TEMPO_HIDE", true);
                                    n.next = 3;
                                    return this.post("takePhoto", {
                                        url: this.config.fileUploadService_Url,
                                        field: this.config.fileUploadService_Field
                                    });
                                case 3:
                                    e = n.sent;
                                    w["a"].commit("SET_TEMPO_HIDE", false);
                                    return n.abrupt("return", e);
                                case 6:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e() {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "getReponseText",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    if (false) {
                                        n.next = 4;
                                        break
                                    }
                                    return n.abrupt("return", this.post("reponseText", e || {}));
                                case 4:
                                    return n.abrupt("return", {
                                        text: window.prompt()
                                    });
                                case 5:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "faketakePhoto",
            value: function() {
                var t = h()(c.a.mark(function t() {
                    return c.a.wrap(function t(e) {
                        while (1) {
                            switch (e.prev = e.next) {
                                case 0:
                                    return e.abrupt("return", this.post("faketakePhoto"));
                                case 1:
                                case "end":
                                    return e.stop()
                            }
                        }
                    }, t, this)
                }));

                function e() {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "dnd",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    return n.abrupt("return", this.post("dnd", {
                                        dnd: e
                                    }));
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "setFocus",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    return n.abrupt("return", this.post("setFocus", {
                                        focus: e
                                    }));
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "callEvent",
            value: function() {
                var t = h()(c.a.mark(function t(e, n) {
                    return c.a.wrap(function t(s) {
                        while (1) {
                            switch (s.prev = s.next) {
                                case 0:
                                    return s.abrupt("return", this.post("callEvent", {
                                        eventName: e,
                                        data: n
                                    }));
                                case 1:
                                case "end":
                                    return s.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e, n) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "deleteALL",
            value: function() {
                var t = h()(c.a.mark(function t() {
                    return c.a.wrap(function t(e) {
                        while (1) {
                            switch (e.prev = e.next) {
                                case 0:
                                    localStorage.clear();
                                    w["a"].dispatch("tchatReset");
                                    w["a"].dispatch("notesReset");
                                    w["a"].dispatch("resetPhone");
                                    w["a"].dispatch("resetMessage");
                                    w["a"].dispatch("resetContact");
                                    w["a"].dispatch("resetBourse");
                                    w["a"].dispatch("resetAppels");
                                    return e.abrupt("return", this.post("deleteALL"));
                                case 9:
                                case "end":
                                    return e.stop()
                            }
                        }
                    }, t, this)
                }));

                function e() {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "getConfig",
            value: function() {
                var t = h()(c.a.mark(function t() {
                    var e;
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    if (!(this.config === null)) {
                                        n.next = 7;
                                        break
                                    }
                                    n.next = 3;
                                    return window.jQuery.get("/html/static/config/config.json");
                                case 3:
                                    e = n.sent;
                                    if (true) {
                                        this.config = JSON.parse(e)
                                    } else {
                                        this.config = e
                                    }
                                    if (this.config.useWebRTCVocal === true) {
                                        this.voiceRTC = new k["a"](this.config.RTCConfig);
                                        T = true
                                    }
                                    this.notififyUseRTC(this.config.useWebRTCVocal);
                                case 7:
                                    return n.abrupt("return", this.config);
                                case 8:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e() {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "onsetEnableApp",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    w["a"].dispatch("setEnableApp", e);
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "setIgnoreFocus",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    this.post("setIgnoreFocus", {
                                        ignoreFocus: e
                                    });
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "tchatGetMessagesChannel",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    this.post("tchat_getChannel", {
                                        channel: e
                                    });
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "tchatSendMessage",
            value: function() {
                var t = h()(c.a.mark(function t(e, n) {
                    return c.a.wrap(function t(s) {
                        while (1) {
                            switch (s.prev = s.next) {
                                case 0:
                                    this.post("tchat_addMessage", {
                                        channel: e,
                                        message: n
                                    });
                                case 1:
                                case "end":
                                    return s.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e, n) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "notesGetMessagesChannel",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    window.localStorage.setItem("gc_notas_locales", e);
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "notesSendMessage",
            value: function() {
                var t = h()(c.a.mark(function t(e, n) {
                    return c.a.wrap(function t(s) {
                        while (1) {
                            switch (s.prev = s.next) {
                                case 0:
                                    this.post("notes_addMessage", {
                                        channel: e,
                                        message: n
                                    });
                                case 1:
                                case "end":
                                    return s.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e, n) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "onupdateMyPhoneNumber",
            value: function t(e) {
                w["a"].commit("SET_MY_PHONE_NUMBER", e.myPhoneNumber)
            }
        }, {
            key: "onupdateMessages",
            value: function t(e) {
                w["a"].commit("SET_MESSAGES", e.messages)
            }
        }, {
            key: "onnewMessage",
            value: function t(e) {
                w["a"].commit("ADD_MESSAGE", e.message)
            }
        }, {
            key: "onupdateContacts",
            value: function t(e) {
                w["a"].commit("SET_CONTACTS", e.contacts)
            }
        }, {
            key: "onhistoriqueCall",
            value: function t(e) {
                w["a"].commit("SET_APPELS_HISTORIQUE", e.historique)
            }
        }, {
            key: "onupdateBankbalance",
            value: function t(e) {
                w["a"].commit("SET_BANK_AMONT", e.banking)
            }
        }, {
            key: "onupdateBourse",
            value: function t(e) {
                w["a"].commit("SET_BOURSE_INFO", e.bourse)
            }
        }, {
            key: "startCall",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    var n = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : undefined;
                    var s;
                    return c.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    if (!(T === true)) {
                                        r.next = 7;
                                        break
                                    }
                                    r.next = 3;
                                    return this.voiceRTC.prepareCall();
                                case 3:
                                    s = r.sent;
                                    return r.abrupt("return", this.post("startCall", {
                                        numero: e,
                                        rtcOffer: s,
                                        extraData: n
                                    }));
                                case 7:
                                    return r.abrupt("return", this.post("startCall", {
                                        numero: e,
                                        extraData: n
                                    }));
                                case 8:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "acceptCall",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    var n;
                    return c.a.wrap(function t(s) {
                        while (1) {
                            switch (s.prev = s.next) {
                                case 0:
                                    if (!(T === true)) {
                                        s.next = 7;
                                        break
                                    }
                                    s.next = 3;
                                    return this.voiceRTC.acceptCall(e);
                                case 3:
                                    n = s.sent;
                                    return s.abrupt("return", this.post("acceptCall", {
                                        infoCall: e,
                                        rtcAnswer: n
                                    }));
                                case 7:
                                    return s.abrupt("return", this.post("acceptCall", {
                                        infoCall: e
                                    }));
                                case 8:
                                case "end":
                                    return s.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "rejectCall",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    return n.abrupt("return", this.post("rejectCall", {
                                        infoCall: e
                                    }));
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "notififyUseRTC",
            value: function() {
                var t = h()(c.a.mark(function t(e) {
                    return c.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    return n.abrupt("return", this.post("notififyUseRTC", e));
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "onwaitingCall",
            value: function t(e) {
                w["a"].commit("SET_APPELS_INFO_IF_EMPTY", r()({}, e.infoCall, {
                    initiator: e.initiator
                }))
            }
        }, {
            key: "onacceptCall",
            value: function t(e) {
                var n = this;
                if (T === true) {
                    if (e.initiator === true) {
                        this.voiceRTC.onReceiveAnswer(e.infoCall.rtcAnswer)
                    }
                    this.voiceRTC.addEventListener("onCandidate", function(t) {
                        n.post("onCandidates", {
                            id: e.infoCall.id,
                            candidates: t
                        })
                    })
                }
                w["a"].commit("SET_APPELS_INFO_IS_ACCEPTS", true)
            }
        }, {
            key: "oncandidatesAvailable",
            value: function t(e) {
                this.voiceRTC.addIceCandidates(e.candidates)
            }
        }, {
            key: "onrejectCall",
            value: function t(e) {
                if (this.voiceRTC !== null) {
                    this.voiceRTC.close()
                }
                w["a"].commit("SET_APPELS_INFO", null)
            }
        }, {
            key: "ontchat_receive",
            value: function t(e) {
                w["a"].dispatch("tchatAddMessage", e)
            }
        }, {
            key: "ontchat_channel",
            value: function t(e) {
                w["a"].commit("TCHAT_SET_MESSAGES", e)
            }
        }, {
            key: "onnotes_receive",
            value: function t(e) {
                w["a"].dispatch("notesAddMessage", e)
            }
        }, {
            key: "onnotes_channel",
            value: function t(e) {
                w["a"].commit("NOTES_SET_MESSAGES", e)
            }
        }, {
            key: "onask_dnd",
            value: function t(e) {
                var n = window.localStorage["AQUA_fivem_dnd"] || false;
                this.post("dnd", {
                    dnd: n
                });
                w["a"].commit("SET_DND", n)
            }
        }, {
            key: "onSetFolders",
            value: function t(e) {
                w["a"].commit("SET_FOLDERS", e.folders)
            }
        }, {
            key: "onautoStartCall",
            value: function t(e) {
                this.startCall(e.number, e.extraData)
            }
        }, {
            key: "onautoAcceptCall",
            value: function t(e) {
                w["a"].commit("SET_APPELS_INFO", e.infoCall);
                this.acceptCall(e.infoCall)
            }
        }, {
            key: "twitter_login",
            value: function t(e, n) {
                this.post("twitter_login", {
                    username: e,
                    password: n
                })
            }
        }, {
            key: "twitter_changePassword",
            value: function t(e, n, s) {
                this.post("twitter_changePassword", {
                    username: e,
                    password: n,
                    newPassword: s
                })
            }
        }, {
            key: "twitter_createAccount",
            value: function t(e, n, s) {
                this.post("twitter_createAccount", {
                    username: e,
                    password: n,
                    avatarUrl: s
                })
            }
        }, {
            key: "twitter_postTweet",
            value: function t(e, n, s) {
                this.post("twitter_postTweet", {
                    username: e,
                    password: n,
                    message: s
                })
            }
        }, {
            key: "twitter_postTweetImg",
            value: function t(e, n, s) {
                this.post("twitter_postTweetImg", {
                    username: e,
                    password: n,
                    message: s
                })
            }
        }, {
            key: "twitter_toggleLikeTweet",
            value: function t(e, n, s) {
                this.post("twitter_toggleLikeTweet", {
                    username: e,
                    password: n,
                    tweetId: s
                })
            }
        }, {
            key: "twitter_setAvatar",
            value: function t(e, n, s) {
                this.post("twitter_setAvatarUrl", {
                    username: e,
                    password: n,
                    avatarUrl: s
                })
            }
        }, {
            key: "twitter_getTweets",
            value: function t(e, n) {
                this.post("twitter_getTweets", {
                    username: e,
                    password: n
                })
            }
        }, {
            key: "twitter_getFavoriteTweets",
            value: function t(e, n) {
                this.post("twitter_getFavoriteTweets", {
                    username: e,
                    password: n
                })
            }
        }, {
            key: "ontwitter_tweets",
            value: function t(e) {
                w["a"].commit("SET_TWEETS", e)
            }
        }, {
            key: "ontwitter_favoritetweets",
            value: function t(e) {
                w["a"].commit("SET_FAVORITE_TWEETS", e)
            }
        }, {
            key: "ontwitter_newTweet",
            value: function t(e) {
                w["a"].dispatch("addTweet", e.tweet)
            }
        }, {
            key: "ontwitter_setAccount",
            value: function t(e) {
                w["a"].dispatch("setAccount", e)
            }
        }, {
            key: "ontwitter_updateTweetLikes",
            value: function t(e) {
                w["a"].commit("UPDATE_TWEET_LIKE", e)
            }
        }, {
            key: "ontwitter_setTweetLikes",
            value: function t(e) {
                w["a"].commit("UPDATE_TWEET_ISLIKE", e)
            }
        }, {
            key: "ontwitter_showError",
            value: function t(e) {
                y["a"].notify({
                    title: w["a"].getters.IntlString(e.title, ""),
                    message: w["a"].getters.IntlString(e.message),
                    icon: "twitter",
                    backgroundColor: "#e0245e80"
                })
            }
        }, {
            key: "ontwitter_showSuccess",
            value: function t(e) {
                y["a"].notify({
                    title: w["a"].getters.IntlString(e.title, ""),
                    message: w["a"].getters.IntlString(e.message),
                    icon: "twitter"
                })
            }
        }, {
            key: "onplaySound",
            value: function t(e) {
                var n = e.sound,
                    s = e.volume,
                    r = s === undefined ? 1 : s;
                var i = "/html/static/sound/" + n;
                if (!n) return;
                if (this.soundList[n] !== undefined) {
                    this.soundList[n].volume = r
                } else {
                    this.soundList[n] = new b["Howl"]({
                        src: i,
                        volume: r,
                        loop: true,
                        onend: function t() {}
                    });
                    this.soundList[n].play()
                }
            }
        }, {
            key: "bankTransfer",
            value: function t(e, n) {
                this.post("bank_transfer", {
                    user_id: e,
                    amount: n
                })
            }
        }, {
            key: "blockNumber",
            value: function t(e) {
                this.post("block_number", {
                    number: e
                })
            }
        }, {
            key: "unblockNumber",
            value: function t(e) {
                this.post("unblock_number", {
                    number: e
                })
            }
        }, {
            key: "spawnvehicle",
            value: function t(e) {
                this.post("valet_spawn", {
                    spawncode: e
                })
            }
        }, {
            key: "onsetSoundVolume",
            value: function t(e) {
                var n = e.sound,
                    s = e.volume,
                    r = s === undefined ? 1 : s;
                if (this.soundList[n] !== undefined) {
                    this.soundList[n].volume = r
                }
            }
        }, {
            key: "onstopSound",
            value: function t(e) {
                var n = e.sound;
                if (this.soundList[n] !== undefined) {
                    this.soundList[n].pause();
                    delete this.soundList[n]
                }
            }
        }]);
        return t
    }();
    var $ = new P;
    e["a"] = $
}, function(t, e, n) {
    "use strict";
    var s = n(80);
    var r = n.n(s);
    var i = n(15);
    var a = n(292);
    var o = n.n(a);
    var c = n(293);
    var u = n.n(c);
    var l = n(21);
    var f = n(10);
    e["a"] = {
        CreateModal: function t() {
            var e = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
            return new r.a(function(t, n) {
                var s = new(i["a"].extend(o.a))({
                    el: document.createElement("div"),
                    propsData: e
                });
                document.querySelector("#app").appendChild(s.$el);
                s.$on("select", function(e) {
                    t(e);
                    s.$el.parentNode.removeChild(s.$el);
                    s.$destroy()
                });
                s.$on("cancel", function() {
                    t({
                        title: "cancel"
                    });
                    s.$el.parentNode.removeChild(s.$el);
                    s.$destroy()
                })
            })
        },
        CreateTextModal: function t() {
            var e = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
            if (l["a"].getters.useMouse === false) {
                return f["a"].getReponseText(e)
            }
            return new r.a(function(t, n) {
                var s = new(i["a"].extend(u.a))({
                    el: document.createElement("div"),
                    propsData: e
                });
                document.querySelector("#app").appendChild(s.$el);
                s.$on("valid", function(e) {
                    t(e);
                    s.$el.parentNode.removeChild(s.$el);
                    s.$destroy()
                });
                s.$on("cancel", function() {
                    n("UserCancel");
                    s.$el.parentNode.removeChild(s.$el);
                    s.$destroy()
                })
            })
        }
    }
}, , , function(t, e, n) {
    function s(t) {
        n(261)
    }
    var r = n(1)(n(176), n(329), s, "data-v-3a8bc553", null);
    t.exports = r.exports
}, , , , , , , function(t, e, n) {
    "use strict";
    var s = n(15);
    var r = n(4);
    var i = n(161);
    var a = n(158);
    var o = n(159);
    var c = n(155);
    var u = n(156);
    var l = n(160);
    var f = n(157);
    var h = n(162);
    var p = n(163);
    s["a"].use(r["c"]);
    e["a"] = new r["c"].Store({
        modules: {
            phone: i["a"],
            contacts: a["a"],
            messages: o["a"],
            appels: c["a"],
            bank: u["a"],
            bourse: f["a"],
            notes: l["a"],
            tchat: h["a"],
            twitter: p["a"]
        },
        strict: true
    })
}, , , , function(t, e, n) {
    function s(t) {
        n(278)
    }
    var r = n(1)(n(170), n(346), s, "data-v-def349b2", null);
    t.exports = r.exports
}, , , , function(t, e, n) {
    function s(t) {
        n(255)
    }
    var r = n(1)(n(169), n(323), s, "data-v-2804e189", null);
    t.exports = r.exports
}, , , , , , , , , function(t, e, n) {
    "use strict";
    e["a"] = a;
    e["b"] = o;
    var s = n(21);

    function r(t) {
        var e = t.match(/rgba?\((\d{1,3}), ?(\d{1,3}), ?(\d{1,3})\)?(?:, ?(\d(?:\.\d?))\))?/);
        if (e !== null) {
            return {
                red: parseInt(e[1], 10),
                green: parseInt(e[2], 10),
                blue: parseInt(e[3], 10)
            }
        }
        e = t.match(/^#([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})/);
        if (e !== null) {
            return {
                red: parseInt(e[1], 16),
                green: parseInt(e[2], 16),
                blue: parseInt(e[3], 16)
            }
        }
        return undefined
    }

    function i(t, e) {
        return t.reduce(function(t, n) {
            (t[n[e]] = t[n[e]] || []).push(n);
            return t
        }, {})
    }

    function a(t) {
        if (t.length === 0 || t[0] === "#") {
            return "#D32F2F"
        }
        var e = t.split("").reduce(function(t, e) {
            return (t << 5) - t + e.charCodeAt(0) | 0
        }, 0);
        return s["a"].getters.colors[Math.abs(e) % s["a"].getters.colors.length]
    }

    function o(t) {
        var e = r(t);
        if (e === undefined) {
            return "#000000"
        } else {
            if (e.red * .299 + e.green * .587 + e.blue * .114 > 186) {
                return "rgba(0, 0, 0, 0.87)"
            } else {
                return "#FFFFFF"
            }
        }
    }
}, , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , function(t, e, n) {
    "use strict";
    var s = n(15);
    e["a"] = new s["a"]
}, , , , , , , , , , , , , , , , , , , , , , , , function(t, e, n) {
    "use strict";
    var s = n(199);
    var r = n.n(s);
    var i = n(15);
    var a = n(287);
    var o = n.n(a);
    var c = n(79);
    var u = {
        install: function t(e) {
            if (this.installed) return;
            this.installed = true;
            i["a"].component("notification", o.a);
            var n = function t(e) {
                c["a"].$emit("add", e)
            };
            i["a"].notify = n;
            r()(i["a"].prototype, {
                $notify: {
                    get: function t() {
                        return i["a"].notify
                    }
                }
            })
        }
    };
    e["a"] = u
}, function(t, e, n) {
    "use strict";
    e["a"] = d;
    var s = n(32);
    var r = n.n(s);
    var i = 60;
    var a = i * 60;
    var o = a * 24;
    var c = o * 7;
    var u = o * 30;
    var l = o * 365;

    function f(t, e) {
        if (t === "just now") {
            return e
        }
        var n = Math.round(t);
        if (Array.isArray(e)) {
            return n > 1 ? e[1].replace(/%s/, n) : e[0].replace(/%s/, n)
        }
        return e.replace(/%s/, n)
    }

    function h(t) {
        var e = new Date(t);
        return e.toLocaleString()
    }
    var p = {
        en_US: ["just now", ["%s second ago", "%s seconds ago"],
            ["%s minute ago", "%s minutes ago"],
            ["%s hour ago", "%s hours ago"],
            ["%s day ago", "%s days ago"],
            ["%s week ago", "%s weeks ago"],
            ["%s month ago", "%s months ago"],
            ["%s year ago", "%s years ago"]
        ]
    };

    function d(t) {
        var e = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            n = e.name,
            s = n === undefined ? "timeago" : n,
            d = e.locale,
            v = d === undefined ? "en_US" : d,
            m = e.locales,
            g = m === undefined ? p : m;
        if (!g || r()(g).length === 0) {
            throw new TypeError("Expected locales to have at least one locale.")
        }
        var _ = {
            props: {
                since: {
                    required: true
                },
                locale: String,
                maxTime: Number,
                autoUpdate: Number,
                format: Function
            },
            data: function t() {
                return {
                    now: (new Date).getTime()
                }
            },
            computed: {
                currentLocale: function e() {
                    if (t.prototype.$timeago) {
                        var n = _.locales[_.locale];
                        if (n) {
                            return n
                        }
                    }
                    return g["en_US"]
                },
                sinceTime: function t() {
                    return new Date(this.since).getTime()
                },
                timeForTitle: function t() {
                    var e = this.now / 1e3 - this.sinceTime / 1e3;
                    if (this.maxTime && e > this.maxTime) {
                        return null
                    }
                    return this.format ? this.format(this.sinceTime) : h(this.sinceTime)
                },
                timeago: function t() {
                    var e = this.now / 1e3 - this.sinceTime / 1e3;
                    if (this.maxTime && e > this.maxTime) {
                        clearInterval(this.interval);
                        return this.format ? this.format(this.sinceTime) : h(this.sinceTime)
                    }
                    var n = e <= 5 ? f("just now", this.currentLocale[0]) : e < i ? f(e, this.currentLocale[1]) : e < a ? f(e / i, this.currentLocale[2]) : e < o ? f(e / a, this.currentLocale[3]) : e < c ? f(e / o, this.currentLocale[4]) : e < u ? f(e / c, this.currentLocale[5]) : e < l ? f(e / u, this.currentLocale[6]) : f(e / l, this.currentLocale[7]);
                    return n
                }
            },
            mounted: function t() {
                if (this.autoUpdate) {
                    this.update()
                }
            },
            render: function t(e) {
                return e("time", {
                    attrs: {
                        datetime: new Date(this.since),
                        title: this.timeForTitle
                    }
                }, this.timeago)
            },
            watch: {
                autoUpdate: function t(e) {
                    this.stopUpdate();
                    if (e) {
                        this.update()
                    }
                }
            },
            methods: {
                update: function t() {
                    var e = this;
                    var n = this.autoUpdate * 1e3;
                    this.interval = setInterval(function() {
                        e.now = (new Date).getTime()
                    }, n)
                },
                stopUpdate: function t() {
                    clearInterval(this.interval);
                    this.interval = null
                }
            },
            beforeDestroy: function t() {
                this.stopUpdate()
            }
        };
        _.locale = "en_US";
        _.locales = {};
        t.prototype.$timeago = {
            setCurrentLocale: function t(e) {
                _.locale = e
            },
            addLocale: function t(e, n) {
                _.locales[e] = n
            }
        };
        t.component(s, _)
    }
}, function(t, e, n) {
    "use strict";
    var s = {
        inserted: function t(e) {
            e.focus()
        }
    };
    e["a"] = s
}, function(t, e, n) {
    "use strict";
    var s = n(15);
    var r = n(350);
    var i = n(290);
    var a = n.n(i);
    var o = n(291);
    var c = n.n(o);
    var u = n(306);
    var l = n.n(u);
    var f = n(305);
    var h = n.n(f);
    var p = n(309);
    var d = n.n(p);
    var v = n(308);
    var m = n.n(v);
    var g = n(307);
    var _ = n.n(g);
    var w = n(296);
    var k = n.n(w);
    var y = n(297);
    var b = n.n(y);
    var C = n(300);
    var S = n.n(C);
    var A = n(294);
    var E = n.n(A);
    var T = n(295);
    var I = n.n(T);
    var P = n(314);
    var $ = n.n(P);
    var x = n(313);
    var M = n.n(x);
    var N = n(310);
    var U = n.n(N);
    var L = n(288);
    var D = n.n(L);
    var O = n(301);
    var R = n.n(O);
    var B = n(302);
    var F = n.n(B);
    var H = n(303);
    var G = n.n(H);
    var V = n(304);
    var j = n.n(V);
    s["a"].use(r["a"]);
    e["a"] = new r["a"]({
        mode: "history",
        routes: [{
            path: "/",
            name: "home",
            component: a.a
        }, {
            path: "/menu",
            name: "menu",
            component: c.a
        }, {
            path: "/contacts",
            name: "contacts",
            component: l.a
        }, {
            path: "/contact/:id/:number?",
            name: "contacts.view",
            component: h.a
        }, {
            path: "/messages",
            name: "messages",
            component: d.a
        }, {
            path: "/messages/select",
            name: "messages.selectcontact",
            component: _.a
        }, {
            path: "/messages/:number/:display",
            name: "messages.view",
            component: m.a
        }, {
            path: "/bank",
            name: "bank",
            component: D.a
        }, {
            path: "/photo",
            name: "photo",
            component: R.a
        }, {
            path: "/settings",
            name: "settings",
            component: U.a
        }, {
            path: "/phone",
            name: "phone",
            component: k.a
        }, {
            path: "/phoneactive",
            name: "phone.active",
            component: b.a
        }, {
            path: "/phoneNumber",
            name: "phone.number",
            component: S.a
        }, {
            path: "/notes",
            name: "notes",
            component: E.a
        }, {
            path: "/notes/:channel",
            name: "notes.channel.show",
            component: I.a
        }, {
            path: "/twitter/splash",
            name: "twitter.splash",
            component: $.a
        }, {
            path: "/twitter/view",
            name: "twitter.screen",
            component: M.a
        }, {
            path: "/valet",
            name: "valet",
            component: F.a
        }, {
            path: "/valet/:folder",
            name: "valet.view",
            component: G.a
        }, {
            path: "*",
            redirect: "/"
        }]
    })
}, function(t, e, n) {
    function s(t) {
        n(272)
    }
    var r = n(1)(n(164), n(340), s, null, null);
    t.exports = r.exports
}, , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , function(t, e, n) {
    "use strict";
    var s = n(39);
    var r = n.n(s);
    var i = n(27);
    var a = n.n(i);
    var o = n(8);
    var c = n.n(o);
    var u = n(7);
    var l = n.n(u);
    var f = n(81);
    var h = n.n(f);
    var p = n(82);
    var d = n.n(p);
    var v = {
        video: false,
        audio: true
    };
    var m = function() {
        function t(e) {
            h()(this, t);
            this.myPeerConnection = null;
            this.candidates = [];
            this.listener = {};
            this.myCandidates = [];
            this.audio = new Audio;
            this.offer = null;
            this.answer = null;
            this.initiator = null;
            this.RTCConfig = e
        }
        d()(t, [{
            key: "init",
            value: function() {
                var t = l()(c.a.mark(function t() {
                    return c.a.wrap(function t(e) {
                        while (1) {
                            switch (e.prev = e.next) {
                                case 0:
                                    e.next = 2;
                                    return this.close();
                                case 2:
                                    this.myPeerConnection = new RTCPeerConnection(this.RTCConfig);
                                    e.next = 5;
                                    return navigator.mediaDevices.getUserMedia(v);
                                case 5:
                                    this.stream = e.sent;
                                case 6:
                                case "end":
                                    return e.stop()
                            }
                        }
                    }, t, this)
                }));

                function e() {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "newConnection",
            value: function t() {
                this.close();
                this.candidates = [];
                this.myCandidates = [];
                this.listener = {};
                this.offer = null;
                this.answer = null;
                this.initiator = null;
                this.myPeerConnection = new RTCPeerConnection(this.RTCConfig);
                this.myPeerConnection.onaddstream = this.onaddstream.bind(this)
            }
        }, {
            key: "close",
            value: function t() {
                if (this.myPeerConnection !== null) {
                    this.myPeerConnection.close()
                }
                this.myPeerConnection = null
            }
        }, {
            key: "prepareCall",
            value: function() {
                var t = l()(c.a.mark(function t() {
                    return c.a.wrap(function t(e) {
                        while (1) {
                            switch (e.prev = e.next) {
                                case 0:
                                    e.next = 2;
                                    return this.init();
                                case 2:
                                    this.newConnection();
                                    this.initiator = true;
                                    this.myPeerConnection.addStream(this.stream);
                                    this.myPeerConnection.onicecandidate = this.onicecandidate.bind(this);
                                    e.next = 8;
                                    return this.myPeerConnection.createOffer();
                                case 8:
                                    this.offer = e.sent;
                                    this.myPeerConnection.setLocalDescription(this.offer);
                                    return e.abrupt("return", btoa(a()(this.offer)));
                                case 11:
                                case "end":
                                    return e.stop()
                            }
                        }
                    }, t, this)
                }));

                function e() {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "acceptCall",
            value: function() {
                var t = l()(c.a.mark(function t(e) {
                    var n;
                    return c.a.wrap(function t(s) {
                        while (1) {
                            switch (s.prev = s.next) {
                                case 0:
                                    n = JSON.parse(atob(e.rtcOffer));
                                    this.newConnection();
                                    this.initiator = false;
                                    s.next = 5;
                                    return navigator.mediaDevices.getUserMedia(v);
                                case 5:
                                    this.stream = s.sent;
                                    this.myPeerConnection.onicecandidate = this.onicecandidate.bind(this);
                                    this.myPeerConnection.addStream(this.stream);
                                    this.offer = new RTCSessionDescription(n);
                                    this.myPeerConnection.setRemoteDescription(this.offer);
                                    s.next = 12;
                                    return this.myPeerConnection.createAnswer();
                                case 12:
                                    this.answer = s.sent;
                                    this.myPeerConnection.setLocalDescription(this.answer);
                                    return s.abrupt("return", btoa(a()(this.answer)));
                                case 15:
                                case "end":
                                    return s.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "onReceiveAnswer",
            value: function() {
                var t = l()(c.a.mark(function t(e) {
                    var n;
                    return c.a.wrap(function t(s) {
                        while (1) {
                            switch (s.prev = s.next) {
                                case 0:
                                    n = JSON.parse(atob(e));
                                    this.answer = new RTCSessionDescription(n);
                                    this.myPeerConnection.setRemoteDescription(this.answer);
                                case 3:
                                case "end":
                                    return s.stop()
                            }
                        }
                    }, t, this)
                }));

                function e(e) {
                    return t.apply(this, arguments)
                }
                return e
            }()
        }, {
            key: "onicecandidate",
            value: function t(e) {
                if (e.candidate !== undefined) {
                    this.myCandidates.push(e.candidate);
                    if (this.listener["onCandidate"] !== undefined) {
                        var n = this.getAvailableCandidates();
                        var s = true;
                        var i = false;
                        var a = undefined;
                        try {
                            for (var o = r()(this.listener["onCandidate"]), c; !(s = (c = o.next()).done); s = true) {
                                var u = c.value;
                                u(n)
                            }
                        } catch (t) {
                            i = true;
                            a = t
                        } finally {
                            try {
                                if (!s && o.return) {
                                    o.return()
                                }
                            } finally {
                                if (i) {
                                    throw a
                                }
                            }
                        }
                    }
                }
            }
        }, {
            key: "getAvailableCandidates",
            value: function t() {
                var e = btoa(a()(this.myCandidates));
                this.myCandidates = [];
                return e
            }
        }, {
            key: "addIceCandidates",
            value: function t(e) {
                var n = this;
                if (this.myPeerConnection !== null) {
                    var s = JSON.parse(atob(e));
                    s.forEach(function(t) {
                        if (t !== null) {
                            n.myPeerConnection.addIceCandidate(t)
                        }
                    })
                }
            }
        }, {
            key: "addEventListener",
            value: function t(e, n) {
                if (e === "onCandidate") {
                    if (this.listener[e] === undefined) {
                        this.listener[e] = []
                    }
                    this.listener[e].push(n);
                    n(this.getAvailableCandidates())
                }
            }
        }, {
            key: "onaddstream",
            value: function t(e) {
                this.audio.srcObject = e.stream;
                this.audio.play()
            }
        }]);
        return t
    }();
    l()(c.a.mark(function t() {
        return c.a.wrap(function t(e) {
            while (1) {
                switch (e.prev = e.next) {
                    case 0:
                    case "end":
                        return e.stop()
                }
            }
        }, t, this)
    }))();
    e["a"] = m
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(15);
    var r = n(107);
    var i = n.n(r);
    var a = n(106);
    var o = n(21);
    var c = n(104);
    var u = n(10);
    var l = n(103);
    var f = n(105);
    var h = n(101);
    var p = n(102);
    s["a"].use(c["a"]);
    s["a"].use(l["a"]);
    s["a"].config.productionTip = false;
    s["a"].prototype.$bus = new s["a"];
    s["a"].prototype.$phoneAPI = u["a"];
    window.VueTimeago = c["a"];
    window.Vue = s["a"];
    window.store = o["a"];
    s["a"].directive("autofocus", f["a"]);
    s["a"].config.errorHandler = function(t, e, n) {
        console.log(t)
    };
    window.APP = new s["a"]({
        el: "#app",
        store: o["a"],
        router: a["a"],
        render: function t(e) {
            return e(i.a)
        }
    })
}, function(t, e, n) {
    "use strict";
    var s = n(40);
    var r = n.n(s);
    var i = n(10);
    var a = {
        appelsHistorique: [],
        appelsInfo: null
    };
    var o = {
        appelsHistorique: function t(e) {
            var n = e.appelsHistorique;
            return n
        },
        appelsInfo: function t(e) {
            var n = e.appelsInfo;
            return n
        },
        appelsDisplayName: function t(e, n) {
            if (e.appelsInfo === null) {
                return "ERROR"
            }
            if (e.appelsInfo.hidden === true) {
                return n.IntlString("APP_PHONE_NUMBER_HIDDEN")
            }
            var s = String(n.appelsDisplayNumber);
            var r = n.contacts.find(function(t) {
                return t.number === s
            }) || {};
            return r.display || n.IntlString("APP_PHONE_NUMBER_UNKNOWN")
        },
        appelsDisplayNumber: function t(e, n) {
            if (e.appelsInfo === null) {
                return "ERROR"
            }
            if (n.isInitiatorCall === true) {
                return e.appelsInfo.receiver_num
            }
            if (e.appelsInfo.hidden === true) {
                return "###-####"
            }
            return e.appelsInfo.transmitter_num
        },
        isInitiatorCall: function t(e, n) {
            if (e.appelsInfo === null) {
                return false
            }
            return e.appelsInfo.initiator === true
        }
    };
    var c = {
        startCall: function t(e, n) {
            var s = e.commit;
            var r = n.numero;
            i["a"].startCall(r)
        },
        acceptCall: function t(e) {
            var n = e.state;
            i["a"].acceptCall(n.appelsInfo)
        },
        rejectCall: function t(e) {
            var n = e.state;
            i["a"].rejectCall(n.appelsInfo)
        },
        ignoreCall: function t(e) {
            var n = e.commit;
            n("SET_APPELS_INFO", null)
        },
        appelsDeleteHistorique: function t(e, n) {
            var s = e.commit,
                r = e.state;
            var a = n.numero;
            i["a"].appelsDeleteHistorique(a);
            s("SET_APPELS_HISTORIQUE", r.appelsHistorique.filter(function(t) {
                return t.num !== a
            }))
        },
        appelsDeleteAllHistorique: function t(e) {
            var n = e.commit;
            i["a"].appelsDeleteAllHistorique();
            n("SET_APPELS_HISTORIQUE", [])
        },
        resetAppels: function t(e) {
            var n = e.commit;
            n("SET_APPELS_HISTORIQUE", []);
            n("SET_APPELS_INFO", null)
        }
    };
    var u = {
        SET_APPELS_HISTORIQUE: function t(e, n) {
            e.appelsHistorique = n
        },
        SET_APPELS_INFO_IF_EMPTY: function t(e, n) {
            if (e.appelsInfo === null) {
                e.appelsInfo = n
            }
        },
        SET_APPELS_INFO: function t(e, n) {
            e.appelsInfo = n
        },
        SET_APPELS_INFO_IS_ACCEPTS: function t(e, n) {
            if (e.appelsInfo !== null) {
                e.appelsInfo = r()({}, e.appelsInfo, {
                    is_accepts: n
                })
            }
        }
    };
    e["a"] = {
        state: a,
        getters: o,
        actions: c,
        mutations: u
    };
    if (false) {
        a.appelsHistorique = [{
            id: 1,
            incoming: 0,
            num: "336-4557",
            owner: "336-4557",
            accepts: 0,
            time: 1528374759e3
        }, {
            id: 2,
            incoming: 0,
            num: "police",
            owner: "336-4557",
            accepts: 1,
            time: 1528374787e3
        }, {
            id: 3,
            incoming: 1,
            num: "555-5555",
            owner: "336-4557",
            accepts: 1,
            time: 1528374566e3
        }, {
            id: 4,
            incoming: 1,
            num: "555-5555",
            owner: "336-4557",
            accepts: 0,
            time: 1528371227e3
        }];
        a.appelsInfo = {
            initiator: false,
            id: 5,
            transmitter_src: 5,
            transmitter_num: "336-4557",
            receiver_src: undefined,
            receiver_num: "###-####",
            is_valid: 0,
            is_accepts: 0,
            hidden: 0
        }
    }
}, function(t, e, n) {
    "use strict";
    var s = n(10);
    var r = {
        bankAmont: "0"
    };
    var i = {
        bankAmont: function t(e) {
            var n = e.bankAmont;
            return n
        }
    };
    var a = {
        sendpara: function t(e, n) {
            var r = e.state;
            var i = n.id,
                a = n.amount;
            s["a"].bankTransfer(i, a)
        }
    };
    var o = {
        SET_BANK_AMONT: function t(e, n) {
            e.bankAmont = n
        }
    };
    e["a"] = {
        state: r,
        getters: i,
        actions: a,
        mutations: o
    }
}, function(t, e, n) {
    "use strict";
    var s = {
        bourseInfo: []
    };
    var r = {
        bourseInfo: function t(e) {
            var n = e.bourseInfo;
            return n
        }
    };
    var i = {
        resetBourse: function t(e) {
            var n = e.commit;
            n("SET_BOURSE_INFO", [])
        }
    };
    var a = {
        SET_BOURSE_INFO: function t(e, n) {
            e.bourseInfo = n
        }
    };
    e["a"] = {
        state: s,
        getters: r,
        actions: i,
        mutations: a
    };
    if (false) {
        s.bourseInfo = [{
            difference: 0,
            libelle: "Diamante",
            price: 1540.2
        }, {
            difference: 20,
            libelle: "Hierro",
            price: 54.2
        }, {
            difference: -20.5,
            libelle: "Cobre",
            price: 254.2
        }]
    }
}, function(t, e, n) {
    "use strict";
    var s = n(16);
    var r = n.n(s);
    var i = n(10);
    var a = {
        contacts: [],
        defaultContacts: []
    };
    var o = {
        contacts: function t(e) {
            var n = e.contacts,
                s = e.defaultContacts;
            return [].concat(r()(n), r()(s))
        }
    };
    var c = {
        updateContact: function t(e, n) {
            var s = n.id,
                r = n.display,
                a = n.number;
            i["a"].updateContact(s, r, a)
        },
        addContact: function t(e, n) {
            var s = n.display,
                r = n.number;
            i["a"].addContact(s, r)
        },
        deleteContact: function t(e, n) {
            var s = n.id;
            i["a"].deleteContact(s)
        },
        resetContact: function t(e) {
            var n = e.commit;
            n("SET_CONTACTS", [])
        }
    };
    var u = {
        SET_CONTACTS: function t(e, n) {
            e.contacts = n.sort(function(t, e) {
                return t.display.localeCompare(e.display)
            })
        },
        SET_DEFAULT_CONTACTS: function t(e, n) {
            e.defaultContacts = n
        }
    };
    e["a"] = {
        state: a,
        getters: o,
        actions: c,
        mutations: u
    };
    if (false) {
        a.contacts = [{
            id: 2,
            number: "336-4557",
            display: "John doe"
        }, {
            id: 4,
            number: "336-4553",
            display: "Nop user"
        }]
    }
}, function(t, e, n) {
    "use strict";
    var s = n(10);
    var r = {
        messages: []
    };
    var i = {
        messages: function t(e) {
            var n = e.messages;
            return n
        },
        nbMessagesUnread: function t(e) {
            var n = e.messages;
            return n.filter(function(t) {
                return t.isRead !== 1
            }).length
        }
    };
    var a = {
        setMessages: function t(e, n) {
            var s = e.commit;
            s("SET_MESSAGES", n)
        },
        sendMessage: function t(e, n) {
            var r = e.commit;
            var i = n.phoneNumber,
                a = n.message;
            s["a"].sendMessage(i, a)
        },
        deleteMessage: function t(e, n) {
            var r = e.commit;
            var i = n.id;
            s["a"].deleteMessage(i)
        },
        deleteMessagesNumber: function t(e, n) {
            var r = e.commit,
                i = e.state;
            var a = n.num;
            s["a"].deleteMessagesNumber(a);
            r("SET_MESSAGES", i.messages.filter(function(t) {
                return t.transmitter !== a
            }))
        },
        deleteAllMessages: function t(e) {
            var n = e.commit;
            s["a"].deleteAllMessages();
            n("SET_MESSAGES", [])
        },
        setMessageRead: function t(e, n) {
            var r = e.commit;
            s["a"].setMessageRead(n);
            r("SET_MESSAGES_READ", {
                num: n
            })
        },
        resetMessage: function t(e) {
            var n = e.commit;
            n("SET_MESSAGES", [])
        }
    };
    var o = {
        SET_MESSAGES: function t(e, n) {
            e.messages = n
        },
        ADD_MESSAGE: function t(e, n) {
            e.messages.push(n)
        },
        SET_MESSAGES_READ: function t(e, n) {
            var s = n.num;
            for (var r = 0; r < e.messages.length; r += 1) {
                if (e.messages[r].transmitter === s && e.messages[r].isRead !== 1) {
                    e.messages[r].isRead = 1
                }
            }
        }
    };
    e["a"] = {
        state: r,
        getters: i,
        actions: a,
        mutations: o
    };
    if (false) {
        var c = (new Date).getTime();
        var u = "" + Math.floor(Math.random() * 1e7);
        r.messages = [{
            id: 0,
            transmitter: "0000",
            receiver: "06",
            time: c - 160,
            message: "#666-123",
            isRead: 1,
            owner: 0
        }, {
            id: 1,
            transmitter: u,
            receiver: "06",
            time: c - 160,
            message: "Salut sa va ?!!!",
            isRead: 1,
            owner: 0
        }, {
            id: 2,
            transmitter: u,
            time: c,
            message: "Tu fait quoi?",
            isRead: 1,
            owner: 0
        }, {
            id: 3,
            transmitter: u,
            time: c,
            message: "Oui est toi ?",
            isRead: 1,
            owner: 1
        }, {
            id: 4,
            transmitter: u,
            time: c,
            message: "GPS : 244 - 123",
            isRead: 1,
            owner: 0
        }, {
            id: 2,
            transmitter: u,
            time: c,
            message: "Tu fait quoi?",
            isRead: 1,
            owner: 0
        }, {
            id: 3,
            transmitter: u,
            time: c,
            message: "Oui est toi ?",
            isRead: 1,
            owner: 1
        }, {
            id: 4,
            transmitter: u,
            time: c,
            message: "GPS : 244 - 123",
            isRead: 1,
            owner: 0
        }, {
            id: 2,
            transmitter: u,
            time: c,
            message: "Tu fait quoi?",
            isRead: 1,
            owner: 0
        }, {
            id: 3,
            transmitter: u,
            time: c,
            message: "Oui est toi ?",
            isRead: 1,
            owner: 1
        }, {
            id: 4,
            transmitter: u,
            time: c,
            message: "GPS : 244 - 123",
            isRead: 1,
            owner: 0
        }, {
            id: 2,
            transmitter: u,
            time: c,
            message: "Tu fait quoi?",
            isRead: 1,
            owner: 0
        }, {
            id: 3,
            transmitter: u,
            time: c,
            message: "Oui est toi ?",
            isRead: 1,
            owner: 1
        }, {
            id: 4,
            transmitter: u,
            time: c,
            message: "GPS : 244 - 123",
            isRead: 1,
            owner: 0
        }, {
            id: 2,
            transmitter: u,
            time: c,
            message: "Tu fait quoi?",
            isRead: 1,
            owner: 0
        }, {
            id: 3,
            transmitter: u,
            time: c,
            message: "Oui est toi ?",
            isRead: 1,
            owner: 1
        }, {
            id: 4,
            transmitter: u,
            time: c,
            message: "GPS : 244 - 123",
            isRead: 1,
            owner: 0
        }, {
            id: 2,
            transmitter: u,
            time: c,
            message: "Tu fait quoi?",
            isRead: 1,
            owner: 0
        }, {
            id: 3,
            transmitter: u,
            time: c,
            message: "Oui est toi ?",
            isRead: 1,
            owner: 1
        }, {
            id: 4,
            transmitter: u,
            time: c,
            message: "GPS : 244 - 123",
            isRead: 1,
            owner: 0
        }, {
            id: 2,
            transmitter: u,
            time: c,
            message: "Tu fait quoi?",
            isRead: 1,
            owner: 0
        }, {
            id: 3,
            transmitter: u,
            time: c,
            message: "Oui est toi ?",
            isRead: 1,
            owner: 1
        }, {
            id: 4,
            transmitter: u,
            time: c,
            message: "GPS: 244.21, -123.15",
            isRead: 1,
            owner: 0
        }, {
            id: 5,
            transmitter: "police",
            time: c,
            message: "Tu fait quoi?",
            isRead: 1,
            owner: 1
        }, {
            id: 6,
            transmitter: "ambulance",
            time: c,
            message: "Oui est toi ?",
            isRead: 1,
            owner: 1
        }, {
            id: 7,
            transmitter: "01",
            time: c,
            message: "Salut sa va ?",
            isRead: 1,
            owner: 0
        }, {
            id: 8,
            transmitter: "01",
            time: c,
            message: "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
            isRead: 0,
            owner: 1
        }, {
            id: 9,
            transmitter: "01",
            time: c,
            message: "GPS: -1034.5810546875, -2734.1027832031",
            isRead: 1,
            owner: 0
        }, {
            id: 44,
            transmitter: "01",
            time: c,
            message: "https://i.imgur.com/gthahbs.png",
            isRead: 1,
            owner: 0
        }, {
            id: 10,
            transmitter: "02",
            time: c,
            message: "Salut sa va ?",
            isRead: 1,
            owner: 0
        }, {
            id: 11,
            transmitter: "04",
            time: c,
            message: "Salut sa va ?",
            isRead: 1,
            owner: 0
        }, {
            id: 12,
            transmitter: "04",
            time: c,
            message: "Salut sa va ?",
            isRead: 1,
            owner: 0
        }, {
            id: 13,
            transmitter: "09",
            time: c,
            message: "Tu sais pas !",
            isRead: 1,
            owner: 0
        }]
    }
}, function(t, e, n) {
    "use strict";
    var s = n(40);
    var r = n.n(s);
    var i = n(27);
    var a = n.n(i);
    var o = n(10);
    var c = n(37);
    var u = n.n(c);
    var l = "gc_notes_channels";
    var f = null;
    var h = {
        channels: JSON.parse(localStorage[l] || null) || [],
        currentChannel: null,
        messagesChannel: []
    };
    var p = {
        notesChannels: function t(e) {
            var n = e.channels;
            return n
        },
        notesCurrentChannel: function t(e) {
            var n = e.currentChannel;
            return n
        },
        notesMessages: function t(e) {
            var n = e.messagesChannel;
            return n
        }
    };
    var d = {
        notesReset: function t(e) {
            var n = e.commit;
            n("NOTES_SET_MESSAGES", {
                messages: []
            });
            n("NOTES_SET_CHANNEL", {
                channel: null
            });
            n("NOTES_REMOVES_ALL_CHANNELS")
        },
        notesSetChannel: function t(e, n) {
            var s = e.state,
                r = e.commit,
                i = e.dispatch;
            var a = n.channel;
            if (s.currentChannel !== a) {
                r("NOTES_SET_MESSAGES", {
                    messages: []
                });
                r("NOTES_SET_CHANNEL", {
                    channel: a
                });
                i("notesGetMessagesChannel", {
                    channel: a
                })
            }
        },
        notesAddMessage: function t(e, n) {
            var s = e.state,
                r = e.commit,
                i = e.getters;
            var a = n.message;
            var o = a.channel;
            if (s.channels.find(function(t) {
                    return t.channel === o
                }) !== undefined) {
                if (f !== null) {
                    f.pause();
                    f = null
                }
                f = new c["Howl"]({
                    src: "/html/static/sound/tchatNotification.ogg",
                    volume: i.volume
                });
                f.play()
            }
            r("NOTES_ADD_MESSAGES", {
                message: a
            })
        },
        notesAddChannel: function t(e, n) {
            var s = e.commit;
            var r = n.channel;
            s("NOTES_ADD_CHANNELS", {
                channel: r
            })
        },
        notesRemoveChannel: function t(e, n) {
            var s = e.commit;
            var r = n.channel;
            s("NOTES_REMOVES_CHANNELS", {
                channel: r
            })
        },
        notesGetMessagesChannel: function t(e, n) {
            var s = e.commit;
            var r = n.channel;
            o["a"].notesGetMessagesChannel(r)
        },
        notesSendMessage: function t(e, n) {
            var s = n.channel,
                r = n.message;
            o["a"].notesSendMessage(s, r)
        }
    };
    var v = {
        NOTES_SET_CHANNEL: function t(e, n) {
            var s = n.channel;
            e.currentChannel = s
        },
        NOTES_ADD_CHANNELS: function t(e, n) {
            var s = n.channel;
            e.channels.push({
                channel: s
            });
            localStorage[l] = a()(e.channels)
        },
        NOTES_REMOVES_CHANNELS: function t(e, n) {
            var s = n.channel;
            e.channels = e.channels.filter(function(t) {
                return t.channel !== s
            });
            localStorage[l] = a()(e.channels)
        },
        NOTES_REMOVES_ALL_CHANNELS: function t(e) {
            e.channels = [];
            localStorage[l] = a()(e.channels)
        },
        NOTES_ADD_MESSAGES: function t(e, n) {
            var s = n.message;
            if (s.channel === e.currentChannel) {
                e.messagesChannel.push(s)
            }
        },
        NOTES_SET_MESSAGES: function t(e, n) {
            var s = n.messages;
            e.messagesChannel = s
        }
    };
    e["a"] = {
        state: h,
        getters: p,
        actions: d,
        mutations: v
    };
    if (false) {
        h.currentChannel = "debug";
        h.messagesChannel = JSON.parse('[{"channel":"teste","message":"teste","id":6,"time":1528671680000},{"channel":"teste","message":"Hop","id":5,"time":1528671153000}]');
        for (var m = 0; m < 200; m++) {
            h.messagesChannel.push(_Object$assign({}, h.messagesChannel[0], {
                id: 100 + m,
                message: "mess " + m
            }))
        }
        h.messagesChannel.push({
            message: "Message sur plusieur ligne car il faut bien !!! Ok !",
            id: 5e3,
            time: (new Date).getTime()
        });
        h.messagesChannel.push({
            message: "Message sur plusieur ligne car il faut bien !!! Ok !",
            id: 5e3,
            time: (new Date).getTime()
        });
        h.messagesChannel.push({
            message: "Message sur plusieur ligne car il faut bien !!! Ok !",
            id: 5e3,
            time: new Date(4567845).getTime()
        })
    }
}, function(t, e, n) {
    "use strict";
    var s = n(27);
    var r = n.n(s);
    var i = n(8);
    var a = n.n(i);
    var o = n(7);
    var c = n.n(o);
    var u = n(39);
    var l = n.n(u);
    var f = n(32);
    var h = n.n(f);
    var p = n(15);
    var d = n(10);
    var v = {
        show: "production" !== "production",
        tempoHide: false,
        myPhoneNumber: "###-####",
        background: JSON.parse(window.localStorage["AQUA_fivem_background"] || null),
        coque: JSON.parse(window.localStorage["AQUA_fivem_coque"] || null),
        ringtone: JSON.parse(window.localStorage["AQUA_fivem_ringtone"] || null),
        zoom: window.localStorage["AQUA_fivem_zoom"] || "80%",
        volume: parseFloat(window.localStorage["AQUA_fivem_volume"]) || 1,
        mouse: window.localStorage["AQUA_fivem_mouse"] === "true",
        lang: window.localStorage["AQUA_fivem_language"],
        config: {
            reseau: "AQUA 5G",
            useFormatNumberFrance: false,
            apps: [],
            themeColor: "#2A56C6",
            colors: ["#2A56C6"],
            language: {}
        },
        dnd: window.localStorage["AQUA_fivem_dnd"] || false,
        folders: [{
            display: "Test Vehicles",
            vehicles: [{
                display: "Audi RS7",
                spawncode: "audirs7"
            }]
        }]
    };
    d["a"].setUseMouse(v.mouse);
    var m = {
        show: function t(e) {
            var n = e.show;
            return n
        },
        tempoHide: function t(e) {
            var n = e.tempoHide;
            return n
        },
        myPhoneNumber: function t(e) {
            var n = e.myPhoneNumber;
            return n
        },
        volume: function t(e) {
            var n = e.volume;
            return n
        },
        enableTakePhoto: function t(e) {
            var n = e.config;
            return n.enableTakePhoto === true
        },
        background: function t(e) {
            var n = e.background,
                s = e.config;
            if (n === null) {
                if (s.background_default !== undefined) {
                    return s.background_default
                }
                return {
                    label: "Default",
                    value: "default.jpg"
                }
            }
            return n
        },
        backgroundLabel: function t(e, n) {
            return n.background.label
        },
        backgroundURL: function t(e, n) {
            if (n.background.value.startsWith("http") === true) {
                return n.background.value
            }
            return "/html/static/img/background/" + n.background.value
        },
        coque: function t(e) {
            var n = e.coque,
                s = e.config;
            if (n === null) {
                if (s && s.coque_default !== undefined) {
                    return s.coque_default
                }
                return {
                    label: "base",
                    value: "base.jpg"
                }
            }
            return n
        },
        ringtone: function t(e) {
            var n = e.ringtone,
                s = e.config;
            if (n === null) {
                if (s && s.ringtone_default !== undefined) {
                    return s.ringtone_default
                }
                return {
                    label: "Panters",
                    value: "ring.ogg"
                }
            }
            return n
        },
        coqueLabel: function t(e, n) {
            return n.coque.label
        },
        ringtoneLabel: function t(e, n) {
            return n.ringtone.label
        },
        zoom: function t(e) {
            var n = e.zoom;
            return n
        },
        useMouse: function t(e) {
            var n = e.mouse;
            return n
        },
        config: function t(e) {
            var n = e.config;
            return n
        },
        warningMessageCount: function t(e) {
            var n = e.config;
            return n.warningMessageCount || 250
        },
        useFormatNumberFrance: function t(e) {
            var n = e.config;
            return n.useFormatNumberFrance
        },
        themeColor: function t(e) {
            var n = e.config;
            return n.themeColor
        },
        colors: function t(e) {
            var n = e.config;
            return n.colors
        },
        Apps: function t(e, n) {
            var s = e.config,
                r = e.lang;
            return s.apps.filter(function(t) {
                return t.enabled !== false
            }).map(function(t) {
                if (t.puceRef !== undefined) {
                    t.puce = n[t.puceRef]
                }
                var e = r + "__name";
                t.intlName = t[e] || t.name;
                return t
            })
        },
        AppsHome: function t(e, n) {
            return n.Apps.filter(function(t) {
                return t.inHomePage === true
            })
        },
        availableLanguages: function t(e) {
            var n = e.config;
            var s = h()(n.language);
            var r = {};
            var i = true;
            var a = false;
            var o = undefined;
            try {
                for (var c = l()(s), u; !(i = (u = c.next()).done); i = true) {
                    var f = u.value;
                    r[n.language[f].NAME] = f
                }
            } catch (t) {
                a = true;
                o = t
            } finally {
                try {
                    if (!i && c.return) {
                        c.return()
                    }
                } finally {
                    if (a) {
                        throw o
                    }
                }
            }
            return r
        },
        IntlString: function t(e) {
            var n = e.config,
                s = e.lang;
            s = s || n.defaultLanguage;
            if (n.language[s] === undefined) {
                return function(t) {
                    return t
                }
            }
            return function(t, e) {
                return n.language[s][t] || e || t
            }
        },
        dnd: function t(e) {
            var n = e.dnd;
            return n
        },
        folders: function t(e) {
            var n = e.folders;
            return n
        }
    };
    var g = {
        loadConfig: function t(e) {
            var n = this;
            var s = e.commit,
                r = e.state;
            return c()(a.a.mark(function t() {
                var e, i, o, c, u, f, v, m, g;
                return a.a.wrap(function t(n) {
                    while (1) {
                        switch (n.prev = n.next) {
                            case 0:
                                n.next = 2;
                                return d["a"].getConfig();
                            case 2:
                                e = n.sent;
                                i = h()(e.language);
                                o = true;
                                c = false;
                                u = undefined;
                                n.prev = 7;
                                for (f = l()(i); !(o = (v = f.next()).done); o = true) {
                                    m = v.value;
                                    g = e.language[m].TIMEAGO;
                                    if (g !== undefined) {
                                        p["a"].prototype.$timeago.addLocale(m, g)
                                    }
                                }
                                n.next = 15;
                                break;
                            case 11:
                                n.prev = 11;
                                n.t0 = n["catch"](7);
                                c = true;
                                u = n.t0;
                            case 15:
                                n.prev = 15;
                                n.prev = 16;
                                if (!o && f.return) {
                                    f.return()
                                }
                            case 18:
                                n.prev = 18;
                                if (!c) {
                                    n.next = 21;
                                    break
                                }
                                throw u;
                            case 21:
                                return n.finish(18);
                            case 22:
                                return n.finish(15);
                            case 23:
                                p["a"].prototype.$timeago.setCurrentLocale(r.lang);
                                if (e.defaultContacts !== undefined) {
                                    s("SET_DEFAULT_CONTACTS", e.defaultContacts)
                                }
                                s("SET_CONFIG", e);
                            case 26:
                            case "end":
                                return n.stop()
                        }
                    }
                }, t, n, [
                    [7, 11, 15, 23],
                    [16, , 18, 22]
                ])
            }))()
        },
        setEnableApp: function t(e, n) {
            var s = e.commit,
                r = e.state;
            var i = n.appName,
                a = n.enable,
                o = a === undefined ? true : a;
            s("SET_APP_ENABLE", {
                appName: i,
                enable: o
            })
        },
        setVisibility: function t(e, n) {
            var s = e.commit;
            s("SET_PHONE_VISIBILITY", n)
        },
        setZoon: function t(e, n) {
            var s = e.commit;
            window.localStorage["AQUA_fivem_zoom"] = n;
            s("SET_ZOOM", n)
        },
        setBackground: function t(e, n) {
            var s = e.commit;
            window.localStorage["AQUA_fivem_background"] = r()(n);
            s("SET_BACKGROUND", n)
        },
        setCoque: function t(e, n) {
            var s = e.commit;
            window.localStorage["AQUA_fivem_coque"] = r()(n);
            s("SET_COQUE", n)
        },
        setringtone: function t(e, n) {
            var s = e.commit;
            window.localStorage["AQUA_fivem_ringtone"] = r()(n);
            s("SET_ringtone", n)
        },
        setVolume: function t(e, n) {
            var s = e.commit;
            window.localStorage["AQUA_fivem_volume"] = n;
            s("SET_VOLUME", n)
        },
        setLanguage: function t(e, n) {
            var s = e.commit;
            window.localStorage["AQUA_fivem_language"] = n;
            p["a"].prototype.$timeago.setCurrentLocale(n);
            s("SET_LANGUAGE", n)
        },
        setMouseSupport: function t(e, n) {
            var s = e.commit;
            window.localStorage["AQUA_fivem_mouse"] = n;
            d["a"].setUseMouse(n);
            s("SET_MOUSE_SUPPORT", n)
        },
        closePhone: function t() {
            d["a"].closePhone()
        },
        setDND: function t(e, n) {
            var s = e.commit;
            window.localStorage["AQUA_fivem_dnd"] = n;
            s("SET_DND", n);
            d["a"].dnd(n)
        },
        resetPhone: function t(e) {
            var n = e.dispatch,
                s = e.getters;
            n("setZoon", "70%");
            n("setVolume", 1);
            n("setBackground", s.config.background_default);
            n("setCoque", s.config.coque_default);
            n("setringtone", s.config.ringtone_default);
            n("setLanguage", "en_US");
            n("setDND", false)
        }
    };
    var _ = {
        SET_CONFIG: function t(e, n) {
            e.config = n
        },
        SET_APP_ENABLE: function t(e, n) {
            var s = n.appName,
                r = n.enable;
            var i = e.config.apps.findIndex(function(t) {
                return t.name === s
            });
            if (i !== -1) {
                p["a"].set(e.config.apps[i], "enabled", r)
            }
        },
        SET_PHONE_VISIBILITY: function t(e, n) {
            e.show = n;
            e.tempoHide = false
        },
        SET_TEMPO_HIDE: function t(e, n) {
            e.tempoHide = n
        },
        SET_MY_PHONE_NUMBER: function t(e, n) {
            e.myPhoneNumber = n
        },
        SET_BACKGROUND: function t(e, n) {
            e.background = n
        },
        SET_COQUE: function t(e, n) {
            e.coque = n
        },
        SET_ringtone: function t(e, n) {
            e.ringtone = n
        },
        SET_ZOOM: function t(e, n) {
            e.zoom = n
        },
        SET_VOLUME: function t(e, n) {
            e.volume = n
        },
        SET_LANGUAGE: function t(e, n) {
            e.lang = n
        },
        SET_MOUSE_SUPPORT: function t(e, n) {
            e.mouse = n
        },
        SET_DND: function t(e, n) {
            e.dnd = n;
            console.log("state.dnd", e.dnd)
        },
        SET_FOLDERS: function t(e, n) {
            e.folders = n
        }
    };
    e["a"] = {
        state: v,
        getters: m,
        actions: g,
        mutations: _
    }
}, function(t, e, n) {
    "use strict";
    var s = n(40);
    var r = n.n(s);
    var i = n(27);
    var a = n.n(i);
    var o = n(10);
    var c = n(37);
    var u = n.n(c);
    var l = "gc_tchat_channels";
    var f = null;
    var h = {
        channels: JSON.parse(localStorage[l] || null) || [],
        currentChannel: null,
        messagesChannel: []
    };
    var p = {
        tchatChannels: function t(e) {
            var n = e.channels;
            return n
        },
        tchatCurrentChannel: function t(e) {
            var n = e.currentChannel;
            return n
        },
        tchatMessages: function t(e) {
            var n = e.messagesChannel;
            return n
        }
    };
    var d = {
        tchatReset: function t(e) {
            var n = e.commit;
            n("TCHAT_SET_MESSAGES", {
                messages: []
            });
            n("TCHAT_SET_CHANNEL", {
                channel: null
            });
            n("TCHAT_REMOVES_ALL_CHANNELS")
        },
        tchatSetChannel: function t(e, n) {
            var s = e.state,
                r = e.commit,
                i = e.dispatch;
            var a = n.channel;
            if (s.currentChannel !== a) {
                r("TCHAT_SET_MESSAGES", {
                    messages: []
                });
                r("TCHAT_SET_CHANNEL", {
                    channel: a
                });
                i("tchatGetMessagesChannel", {
                    channel: a
                })
            }
        },
        tchatAddMessage: function t(e, n) {
            var s = e.state,
                r = e.commit,
                i = e.getters;
            var a = n.message;
            var o = a.channel;
            if (s.channels.find(function(t) {
                    return t.channel === o
                }) !== undefined) {
                if (f !== null) {
                    f.pause();
                    f = null
                }
                f = new c["Howl"]({
                    src: "/html/static/sound/tchatNotification.ogg",
                    volume: i.volume
                });
                f.play()
            }
            r("TCHAT_ADD_MESSAGES", {
                message: a
            })
        },
        tchatAddChannel: function t(e, n) {
            var s = e.commit;
            var r = n.channel;
            s("TCHAT_ADD_CHANNELS", {
                channel: r
            })
        },
        tchatRemoveChannel: function t(e, n) {
            var s = e.commit;
            var r = n.channel;
            s("TCHAT_REMOVES_CHANNELS", {
                channel: r
            })
        },
        tchatGetMessagesChannel: function t(e, n) {
            var s = e.commit;
            var r = n.channel;
            o["a"].tchatGetMessagesChannel(r)
        },
        tchatSendMessage: function t(e, n) {
            var s = n.channel,
                r = n.message;
            o["a"].tchatSendMessage(s, r)
        }
    };
    var v = {
        TCHAT_SET_CHANNEL: function t(e, n) {
            var s = n.channel;
            e.currentChannel = s
        },
        TCHAT_ADD_CHANNELS: function t(e, n) {
            var s = n.channel;
            e.channels.push({
                channel: s
            });
            localStorage[l] = a()(e.channels)
        },
        TCHAT_REMOVES_CHANNELS: function t(e, n) {
            var s = n.channel;
            e.channels = e.channels.filter(function(t) {
                return t.channel !== s
            });
            localStorage[l] = a()(e.channels)
        },
        TCHAT_REMOVES_ALL_CHANNELS: function t(e) {
            e.channels = [];
            localStorage[l] = a()(e.channels)
        },
        TCHAT_ADD_MESSAGES: function t(e, n) {
            var s = n.message;
            if (s.channel === e.currentChannel) {
                e.messagesChannel.push(s)
            }
        },
        TCHAT_SET_MESSAGES: function t(e, n) {
            var s = n.messages;
            e.messagesChannel = s
        }
    };
    e["a"] = {
        state: h,
        getters: p,
        actions: d,
        mutations: v
    };
    if (false) {
        h.currentChannel = "debug";
        h.messagesChannel = JSON.parse('[{"channel":"teste","message":"teste","id":6,"time":1528671680000},{"channel":"teste","message":"Hop","id":5,"time":1528671153000}]');
        for (var m = 0; m < 200; m++) {
            h.messagesChannel.push(_Object$assign({}, h.messagesChannel[0], {
                id: 100 + m,
                message: "mess " + m
            }))
        }
        h.messagesChannel.push({
            message: "Message sur plusieur ligne car il faut bien !!! Ok !",
            id: 5e3,
            time: (new Date).getTime()
        });
        h.messagesChannel.push({
            message: "Message sur plusieur ligne car il faut bien !!! Ok !",
            id: 5e3,
            time: (new Date).getTime()
        });
        h.messagesChannel.push({
            message: "Message sur plusieur ligne car il faut bien !!! Ok !",
            id: 5e3,
            time: new Date(4567845).getTime()
        })
    }
}, function(t, e, n) {
    "use strict";
    var s = n(16);
    var r = n.n(s);
    var i = n(10);
    var a = n(15);
    var o = {
        twitterUsername: localStorage["gcphone_twitter_username"],
        twitterPassword: localStorage["gcphone_twitter_password"],
        twitterAvatarUrl: localStorage["gcphone_twitter_avatarUrl"],
        twitterNotification: localStorage["gcphone_twitter_notif"] ? parseInt(localStorage["gcphone_twitter_notif"]) : 1,
        twitterNotificationSound: localStorage["gcphone_twitter_notif_sound"] !== "false",
        tweets: [],
        favoriteTweets: []
    };
    var c = {
        twitterUsername: function t(e) {
            var n = e.twitterUsername;
            return n
        },
        twitterPassword: function t(e) {
            var n = e.twitterPassword;
            return n
        },
        twitterAvatarUrl: function t(e) {
            var n = e.twitterAvatarUrl;
            return n
        },
        twitterNotification: function t(e) {
            var n = e.twitterNotification;
            return n
        },
        twitterNotificationSound: function t(e) {
            var n = e.twitterNotificationSound;
            return n
        },
        tweets: function t(e) {
            var n = e.tweets;
            return n
        },
        favoriteTweets: function t(e) {
            var n = e.favoriteTweets;
            return n
        }
    };
    var u = {
        twitterCreateNewAccount: function t(e, n) {
            var s = n.username,
                r = n.password,
                a = n.avatarUrl;
            i["a"].twitter_createAccount(s, r, a)
        },
        twitterLogin: function t(e, n) {
            var s = e.commit;
            var r = n.username,
                a = n.password;
            i["a"].twitter_login(r, a)
        },
        twitterChangePassword: function t(e, n) {
            var s = e.state;
            i["a"].twitter_changePassword(s.twitterUsername, s.twitterPassword, n)
        },
        twitterLogout: function t(e) {
            var n = e.commit;
            localStorage.removeItem("gcphone_twitter_username");
            localStorage.removeItem("gcphone_twitter_password");
            localStorage.removeItem("gcphone_twitter_avatarUrl");
            n("UPDATE_ACCOUNT", {
                username: undefined,
                password: undefined,
                avatarUrl: undefined
            })
        },
        twitterSetAvatar: function t(e, n) {
            var s = e.state;
            var r = n.avatarUrl;
            i["a"].twitter_setAvatar(s.twitterUsername, s.twitterPassword, r)
        },
        twitterPostTweet: function t(e, n) {
            var s = e.state,
                r = e.commit;
            var a = n.message;
            if (/^https?:\/\/.*\.(png|jpg|jpeg|gif)$/.test(a)) {
                i["a"].twitter_postTweetImg(s.twitterUsername, s.twitterPassword, a)
            } else {
                i["a"].twitter_postTweet(s.twitterUsername, s.twitterPassword, i["a"].convertEmoji(a))
            }
        },
        twitterToogleLike: function t(e, n) {
            var s = e.state;
            var r = n.tweetId;
            i["a"].twitter_toggleLikeTweet(s.twitterUsername, s.twitterPassword, r)
        },
        setAccount: function t(e, n) {
            var s = e.commit;
            localStorage["gcphone_twitter_username"] = n.username;
            localStorage["gcphone_twitter_password"] = n.password;
            localStorage["gcphone_twitter_avatarUrl"] = n.avatarUrl;
            s("UPDATE_ACCOUNT", n)
        },
        addTweet: function t(e, n) {
            var s = e.commit,
                r = e.state;
            var i = r.twitterNotification === 2;
            if (r.twitterNotification === 1) {
                i = n.message && n.message.toLowerCase().indexOf(r.twitterUsername.toLowerCase()) !== -1
            }
            if (i === true) {
                a["a"].notify({
                    message: n.message,
                    title: n.author + " :",
                    icon: "twitter",
                    sound: r.twitterNotificationSound ? "Twitter_Sound_Effect.ogg" : undefined
                })
            }
            s("ADD_TWEET", {
                tweet: n
            })
        },
        fetchTweets: function t(e) {
            var n = e.state;
            i["a"].twitter_getTweets(n.twitterUsername, n.twitterPassword)
        },
        fetchFavoriteTweets: function t(e) {
            var n = e.state;
            i["a"].twitter_getFavoriteTweets(n.twitterUsername, n.twitterPassword)
        },
        setTwitterNotification: function t(e, n) {
            var s = e.commit;
            localStorage["gcphone_twitter_notif"] = n;
            s("SET_TWITTER_NOTIFICATION", {
                notification: n
            })
        },
        setTwitterNotificationSound: function t(e, n) {
            var s = e.commit;
            localStorage["gcphone_twitter_notif_sound"] = n;
            s("SET_TWITTER_NOTIFICATION_SOUND", {
                notificationSound: n
            })
        }
    };
    var l = {
        SET_TWITTER_NOTIFICATION: function t(e, n) {
            var s = n.notification;
            e.twitterNotification = s
        },
        SET_TWITTER_NOTIFICATION_SOUND: function t(e, n) {
            var s = n.notificationSound;
            e.twitterNotificationSound = s
        },
        UPDATE_ACCOUNT: function t(e, n) {
            var s = n.username,
                r = n.password,
                i = n.avatarUrl;
            e.twitterUsername = s;
            e.twitterPassword = r;
            e.twitterAvatarUrl = i
        },
        SET_TWEETS: function t(e, n) {
            var s = n.tweets;
            e.tweets = s
        },
        SET_FAVORITE_TWEETS: function t(e, n) {
            var s = n.tweets;
            e.favoriteTweets = s
        },
        ADD_TWEET: function t(e, n) {
            var s = n.tweet;
            e.tweets = [s].concat(r()(e.tweets))
        },
        UPDATE_TWEET_LIKE: function t(e, n) {
            var s = n.tweetId,
                r = n.likes;
            var i = e.tweets.findIndex(function(t) {
                return t.id === s
            });
            if (i !== -1) {
                e.tweets[i].likes = r
            }
            var a = e.favoriteTweets.findIndex(function(t) {
                return t.id === s
            });
            if (a !== -1) {
                e.favoriteTweets[a].likes = r
            }
        },
        UPDATE_TWEET_ISLIKE: function t(e, n) {
            var s = n.tweetId,
                r = n.isLikes;
            var i = e.tweets.findIndex(function(t) {
                return t.id === s
            });
            if (i !== -1) {
                a["a"].set(e.tweets[i], "isLikes", r)
            }
            var o = e.favoriteTweets.findIndex(function(t) {
                return t.id === s
            });
            if (o !== -1) {
                a["a"].set(e.favoriteTweets[o], "isLikes", r)
            }
        }
    };
    e["a"] = {
        state: o,
        getters: c,
        actions: u,
        mutations: l
    };
    if (false) {
        o.favoriteTweets = [{
            id: 1,
            message: "https://pbs.twimg.com/profile_images/702982240184107008/tUKxvkcs_400x400.jpg",
            author: "Gannon",
            time: new Date,
            likes: 3,
            isLikes: 60
        }, {
            id: 2,
            message: "Borderlands 3 arrives on Xbox One, PS4, and PC on September 13, 2019! Tune in to the Gameplay Reveal Event on May 1st, where we’ll debut the first hands-on looks! Pre-order now to get the Gold Weapon Skins Pack! ➜ https://borderlands.com  ",
            author: "Gearbox Official",
            authorIcon: "https://pbs.twimg.com/profile_images/702982240184107008/tUKxvkcs_400x400.jpg",
            time: new Date,
            likes: 65
        }, {
            id: 3,
            message: "",
            img: "https://cdn.discordapp.com/attachments/563443658192322576/563473765569396746/samurai-background-hd-1920x1200-45462.jpg",
            author: "Gannon",
            time: new Date
        }, {
            id: 4,
            message: "Super Message de la mort.",
            author: "Gannon",
            authorIcon: "https://pbs.twimg.com/profile_images/986085090684960768/AcD9lOLw_bigger.jpg",
            likes: 0,
            time: new Date
        }, {
            id: 5,
            message: "Super Message de la mort.",
            author: "Gannon",
            authorIcon: "https://pbs.twimg.com/profile_images/986085090684960768/AcD9lOLw_bigger.jpg",
            likes: 0,
            time: new Date
        }, {
            id: 6,
            message: "Super Message de la mort.",
            author: "Gannon",
            authorIcon: "https://pbs.twimg.com/profile_images/986085090684960768/AcD9lOLw_bigger.jpg",
            likes: 0,
            time: new Date
        }, {
            id: 7,
            message: "Super Message de la mort.",
            author: "Gannon",
            authorIcon: "https://pbs.twimg.com/profile_images/986085090684960768/AcD9lOLw_bigger.jpg",
            likes: 0,
            time: new Date
        }, {
            id: 8,
            message: "Super Message de la mort.",
            author: "Gannon",
            authorIcon: "https://pbs.twimg.com/profile_images/986085090684960768/AcD9lOLw_bigger.jpg",
            likes: 0,
            time: new Date
        }]
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(248);
    var a = n.n(i);
    var o = n(247);
    var c = n.n(o);
    var u = n(4);
    var l = n(37);
    var f = n.n(l);
    e["default"] = {
        name: "app",
        components: {},
        data: function t() {
            return {
                soundCall: null
            }
        },
        methods: r()({}, n.i(u["a"])(["loadConfig", "rejectCall"]), {
            closePhone: function t() {
                this.$phoneAPI.closePhone()
            }
        }),
        computed: r()({}, n.i(u["b"])(["show", "zoom", "coque", "ringtone", "appelsInfo", "myPhoneNumber", "volume", "tempoHide"])),
        watch: {
            appelsInfo: function t(e, n) {
                if (this.appelsInfo !== null && this.appelsInfo.is_accepts !== true) {
                    if (this.soundCall !== null) {
                        this.soundCall.pause()
                    }
                    var s = null;
                    if (this.appelsInfo.initiator === true) {
                        s = "/html/static/sound/Phone_Call_Sound_Effect.ogg";
                        this.soundCall = new l["Howl"]({
                            src: s,
                            volume: this.volume,
                            loop: true,
                            onend: function t() {}
                        })
                    } else {
                        s = "/html/static/sound/" + this.ringtone.value;
                        if (this.ringtone.value.match("http://") || this.ringtone.value.match("https://")) {
                            s = this.ringtone.value
                        }
                        this.soundCall = new l["Howl"]({
                            src: s,
                            volume: this.volume,
                            loop: true,
                            onend: function t() {}
                        })
                    }
                    this.soundCall.play()
                } else if (this.soundCall !== null) {
                    this.soundCall.pause();
                    this.soundCall = null
                }
                if (e === null && n !== null) {
                    this.$router.push({
                        name: "home"
                    });
                    return
                }
                if (e !== null) {
                    this.$router.push({
                        name: "phone.active"
                    })
                }
            },
            show: function t() {
                if (this.appelsInfo !== null) {
                    this.$router.push({
                        name: "phone.active"
                    })
                } else {
                    this.$router.push({
                        name: "home"
                    })
                }
                if (this.show === false && this.appelsInfo !== null) {
                    this.rejectCall()
                }
            }
        },
        mounted: function t() {
            var e = this;
            this.loadConfig();
            window.addEventListener("message", function(t) {
                if (t.data.keyUp !== undefined) {
                    e.$bus.$emit("keyUp" + t.data.keyUp)
                }
            });
            window.addEventListener("keyup", function(t) {
                var n = ["ArrowRight", "ArrowLeft", "ArrowUp", "ArrowDown", "Backspace", "Enter"];
                if (n.indexOf(t.key) !== -1) {
                    e.$bus.$emit("keyUp" + t.key)
                }
                if (t.key === "Escape") {
                    e.$phoneAPI.closePhone()
                }
            })
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(8);
    var r = n.n(s);
    var i = n(3);
    var a = n.n(i);
    var o = n(7);
    var c = n.n(o);
    var u = n(79);
    var l = n(37);
    var f = n.n(l);
    e["default"] = {
        data: function t() {
            return {
                currentId: 0,
                list: []
            }
        },
        mounted: function t() {
            u["a"].$on("add", this.addItem)
        },
        methods: {
            addItem: function t() {
                var e = this;
                var n = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
                return c()(r.a.mark(function t() {
                    var s, i, o;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    s = a()({}, n, {
                                        id: e.currentId++,
                                        duration: parseInt(n.duration) || 3e3
                                    });
                                    e.list.push(s);
                                    window.setTimeout(function() {
                                        e.destroy(s.id)
                                    }, s.duration);
                                    if (n.sound !== null && n.sound !== undefined) {
                                        i = "/html/static/sound/" + n.sound;
                                        o = new l["Howl"]({
                                            src: i,
                                            onend: function t() {
                                                o.src = null
                                            }
                                        });
                                        o.play()
                                    }
                                case 4:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, e)
                }))()
            },
            style: function t(e) {
                return {
                    backgroundColor: e.backgroundColor
                }
            },
            destroy: function t(e) {
                this.list = this.list.filter(function(t) {
                    return t.id !== e
                })
            }
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(4);
    var a = n(29);
    var o = n.n(a);
    e["default"] = {
        components: {
            InfoBare: o.a
        },
        data: function t() {
            return {
                id: "",
                paratutar: "",
                currentSelect: 0
            }
        },
        methods: r()({}, n.i(i["a"])(["sendpara"]), {
            scrollIntoViewIfNeeded: function t() {
                this.$nextTick(function() {
                    document.querySelector("focus").scrollIntoViewIfNeeded()
                })
            },
            onBackspace: function t() {
                if (this.ignoreControls === true) return;
                this.$phoneAPI.closePhone()
            },
            iptal: function t() {
                this.$phoneAPI.closePhone()
            },
            paragonder: function t() {
                var e = this;
                var n = this.paratutar.trim();
                if (n === "") return;
                this.paratutar = "";
                this.$phoneAPI.bankTransfer(this.id, n);
                this.$phoneAPI.setFocus(true).then(function(t) {
                    e.ignoreControls = true
                })
            },
            onUp: function t() {
                if (this.currentSelect - 1 >= 0) {
                    this.currentSelect = this.currentSelect - 1
                }
                this.$refs["form" + this.currentSelect].focus()
            },
            onDown: function t() {
                if (this.currentSelect + 1 <= 3) {
                    this.currentSelect = this.currentSelect + 1
                }
                this.$refs["form" + this.currentSelect].focus()
            },
            onEnter: function t() {
                var e = this;
                if (this.ignoreControls === true) return;
                if (this.currentSelect === 2) {
                    this.paragonder()
                } else if (this.currentSelect === 0) {
                    if (this.id === "") {
                        this.$phoneAPI.setFocus(true).then(function(t) {
                            e.ignoreControls = true
                        })
                    } else {
                        this.$phoneAPI.setFocus(false).then(function(t) {
                            e.ignoreControls = false
                        })
                    }
                } else if (this.currentSelect === 1) {
                    if (this.paratutar === "") {
                        this.$phoneAPI.setFocus(true).then(function(t) {
                            e.ignoreControls = true
                        })
                    } else {
                        this.$phoneAPI.setFocus(false).then(function(t) {
                            e.ignoreControls = false
                        })
                    }
                } else if (this.currentSelect === 3) {
                    this.iptal()
                }
            }
        }),
        computed: r()({}, n.i(i["b"])(["bankAmont", "IntlString"]), {
            bankAmontFormat: function t() {
                return Intl.NumberFormat().format(this.bankAmont)
            }
        }),
        created: function t() {
            this.display = this.$route.params.display;
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter)
            }
            this.$bus.$on("keyUpBackspace", this.onBackspace)
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.onBackspace)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    e["default"] = {
        data: function t() {
            return {
                time: "",
                myInterval: 0
            }
        },
        methods: {
            updateTime: function t() {
                var e = new Date;
                var n = e.getMinutes();
                n = n > 9 ? n : "0" + n;
                var s = e.getHours();
                s = s > 9 ? s : "0" + s;
                var r = s + ":" + n;
                this.time = r
            }
        },
        created: function t() {
            this.updateTime();
            this.myInterval = setInterval(this.updateTime, 1e3)
        },
        beforeDestroy: function t() {
            clearInterval(this.myInterval)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(4);
    var a = n(29);
    var o = n.n(a);
    e["default"] = {
        components: {
            InfoBare: o.a
        },
        data: function t() {
            return {
                currentSelect: 0 + "_home",
                nBotonesMenu: 3
            }
        },
        computed: r()({}, n.i(i["b"])(["IntlString", "useMouse", "nbMessagesUnread", "backgroundURL", "messages", "AppsHome", "warningMessageCount", "Apps"])),
        methods: r()({}, n.i(i["a"])(["closePhone", "setMessages"]), {
            onLeft: function t() {
                if (typeof this.currentSelect === "string" && this.currentSelect.match("_home")) {
                    var e = parseInt(this.currentSelect.split("_")[0]);
                    if (e == 2) {
                        this.currentSelect = 1 + "_home";
                        return
                    }
                    if (e === this.AppsHome.length - 1) {
                        e = 1
                    }
                    if (e - 1 < 0) {
                        this.currentSelect = this.AppsHome.length - 1 + "_home"
                    } else {
                        this.currentSelect = e - 1 + "_home"
                    }
                    return
                }
                var n = Math.floor(this.currentSelect / this.nBotonesMenu);
                var s = (this.currentSelect + this.nBotonesMenu - 1) % this.nBotonesMenu + n * this.nBotonesMenu;
                this.currentSelect = Math.min(s, this.Apps.length - 1)
            },
            onRight: function t() {
                if (typeof this.currentSelect === "string" && this.currentSelect.match("_home")) {
                    var e = parseInt(this.currentSelect.split("_")[0]);
                    if (e === this.AppsHome.length - 1) {
                        e = -1
                    }
                    this.currentSelect = e + 1 + "_home";
                    return
                }
                var n = Math.floor(this.currentSelect / this.nBotonesMenu);
                var s = (this.currentSelect + 1) % this.nBotonesMenu + n * this.nBotonesMenu;
                if (s >= this.Apps.length) {
                    s = n * this.nBotonesMenu
                }
                this.currentSelect = s
            },
            onUp: function t() {
                if (typeof this.currentSelect === "string" && this.currentSelect.match("_home")) {
                    this.currentSelect = 0;
                    return
                }
                var e = this.currentSelect - this.nBotonesMenu;
                if (e < 0) {
                    var n = this.currentSelect % this.nBotonesMenu;
                    e = Math.floor((this.Apps.length - 1) / this.nBotonesMenu) * this.nBotonesMenu;
                    this.currentSelect = 0 + "_home"
                } else {
                    this.currentSelect = e
                }
            },
            onDown: function t() {
                if (typeof this.currentSelect === "string" && this.currentSelect.match("_home")) {
                    var e = parseInt(this.currentSelect.split("_")[0]);
                    this.currentSelect = 0;
                    return
                }
                var n = this.currentSelect % this.nBotonesMenu;
                var s = this.currentSelect + this.nBotonesMenu;
                if (s >= this.Apps.filter(function(t) {
                        return !t.inHomePage
                    }).length) {
                    s = n + "_home"
                }
                this.currentSelect = s
            },
            openApp: function t(e) {
                this.$router.push({
                    name: e.routeName
                })
            },
            onEnter: function t() {
                if (typeof this.currentSelect === "string" && this.currentSelect.match("_home")) {
                    var e = parseInt(this.currentSelect.split("_")[0]);
                    this.openApp(this.AppsHome[e]);
                    return
                }
                this.openApp(this.Apps.filter(function(t) {
                    return !t.inHomePage
                })[this.currentSelect])
            },
            onBack: function t() {
                this.closePhone()
            }
        }),
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowLeft", this.onLeft);
                this.$bus.$on("keyUpArrowRight", this.onRight);
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter)
            } else {
                this.currentSelect = -1
            }
            this.$bus.$on("keyUpBackspace", this.onBack)
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowLeft", this.onLeft);
            this.$bus.$off("keyUpArrowRight", this.onRight);
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.onBack)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(4);
    var r = n(289);
    var i = n.n(r);
    e["default"] = {
        computed: n.i(s["b"])(["config"]),
        components: {
            CurrentTime: i.a
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(14);
    var a = n.n(i);
    var o = n(29);
    var c = n.n(o);
    var u = n(4);
    e["default"] = {
        name: "hello",
        components: {
            PhoneTitle: a.a,
            InfoBare: c.a
        },
        data: function t() {
            return {
                currentSelect: 0
            }
        },
        props: {
            title: {
                type: String,
                default: "Title"
            },
            showHeader: {
                type: Boolean,
                default: true
            },
            showInfoBare: {
                type: Boolean,
                default: true
            },
            list: {
                type: Array,
                required: true
            },
            color: {
                type: String,
                default: "#FFFFFF"
            },
            showIcons: {
                type: Boolean,
                default: true
            },
            backgroundColor: {
                type: String,
                default: "#4CAF50"
            },
            keyDispay: {
                type: String,
                default: "display"
            },
            disable: {
                type: Boolean,
                default: false
            },
            titleBackgroundColor: {
                type: String,
                default: "#FFFFFF"
            }
        },
        watch: {
            list: function t() {
                this.currentSelect = 0
            }
        },
        computed: r()({}, n.i(u["b"])(["useMouse"])),
        methods: {
            styleTitle: function t() {
                return {
                    color: this.color,
                    backgroundColor: this.backgroundColor
                }
            },
            stylePuce: function t(e) {
                e = e || {};
                if (e.icon !== undefined) {
                    return {
                        backgroundImage: "url(" + e.icon + ")",
                        backgroundSize: "cover",
                        color: "rgba(0,0,0,0)"
                    }
                }
                return {
                    color: e.color || this.color,
                    backgroundColor: e.backgroundColor || this.backgroundColor,
                    borderRadius: "50%"
                }
            },
            scrollIntoViewIfNeeded: function t() {
                this.$nextTick(function() {
                    document.querySelector(".select").scrollIntoViewIfNeeded()
                })
            },
            onUp: function t() {
                if (this.disable === true) return;
                this.currentSelect = this.currentSelect === 0 ? this.list.length - 1 : this.currentSelect - 1;
                this.scrollIntoViewIfNeeded()
            },
            onDown: function t() {
                if (this.disable === true) return;
                this.currentSelect = this.currentSelect === this.list.length - 1 ? 0 : this.currentSelect + 1;
                this.scrollIntoViewIfNeeded()
            },
            selectItem: function t(e) {
                this.$emit("select", e)
            },
            optionItem: function t(e) {
                this.$emit("option", e)
            },
            back: function t() {
                this.$emit("back")
            },
            onRight: function t() {
                if (this.disable === true) return;
                this.$emit("option", this.list[this.currentSelect])
            },
            onEnter: function t() {
                if (this.disable === true) return;
                this.$emit("select", this.list[this.currentSelect])
            }
        },
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpArrowRight", this.onRight);
                this.$bus.$on("keyUpEnter", this.onEnter)
            } else {
                this.currentSelect = -1
            }
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpArrowRight", this.onRight);
            this.$bus.$off("keyUpEnter", this.onEnter)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(4);
    var a = n(29);
    var o = n.n(a);
    e["default"] = {
        components: {
            InfoBare: o.a
        },
        data: function t() {
            return {
                currentSelect: 0,
                nBotonesMenu: 3
            }
        },
        computed: r()({}, n.i(i["b"])(["nbMessagesUnread", "backgroundURL", "Apps", "useMouse"])),
        methods: r()({}, n.i(i["b"])(["closePhone"]), {
            onLeft: function t() {
                var e = Math.floor(this.currentSelect / this.nBotonesMenu);
                var n = (this.currentSelect + this.nBotonesMenu - 1) % this.nBotonesMenu + e * this.nBotonesMenu;
                this.currentSelect = Math.min(n, this.Apps.length - 1)
            },
            onRight: function t() {
                var e = Math.floor(this.currentSelect / this.nBotonesMenu);
                var n = (this.currentSelect + 1) % this.nBotonesMenu + e * this.nBotonesMenu;
                if (n >= this.Apps.length) {
                    n = e * this.nBotonesMenu
                }
                this.currentSelect = n
            },
            onUp: function t() {
                var e = this.currentSelect - this.nBotonesMenu;
                if (e < 0) {
                    var n = this.currentSelect % this.nBotonesMenu;
                    e = Math.floor((this.Apps.length - 1) / this.nBotonesMenu) * this.nBotonesMenu;
                    this.currentSelect = Math.min(e + n, this.Apps.length - 1)
                } else {
                    this.currentSelect = e
                }
            },
            onDown: function t() {
                var e = this.currentSelect % this.nBotonesMenu;
                var n = this.currentSelect + this.nBotonesMenu;
                if (n >= this.Apps.length) {
                    n = e
                }
                this.currentSelect = n
            },
            openApp: function t(e) {
                this.$router.push({
                    name: e.routeName
                })
            },
            onEnter: function t() {
                this.openApp(this.Apps[this.currentSelect])
            },
            onBack: function t() {
                this.$router.push({
                    name: "home"
                })
            }
        }),
        mounted: function t() {},
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowLeft", this.onLeft);
                this.$bus.$on("keyUpArrowRight", this.onRight);
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter)
            } else {
                this.currentSelect = -1
            }
            this.$bus.$on("keyUpBackspace", this.onBack)
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowLeft", this.onLeft);
            this.$bus.$off("keyUpArrowRight", this.onRight);
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.onBack)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(21);
    var a = n(4);
    e["default"] = {
        name: "Modal",
        store: i["a"],
        data: function t() {
            return {
                currentSelect: 0
            }
        },
        props: {
            choix: {
                type: Array,
                default: function t() {
                    return []
                }
            }
        },
        computed: r()({}, n.i(a["b"])(["useMouse"])),
        methods: {
            scrollIntoViewIfNeeded: function t() {
                this.$nextTick(function() {
                    document.querySelector(".modal-choix.select").scrollIntoViewIfNeeded()
                })
            },
            onUp: function t() {
                this.currentSelect = this.currentSelect === 0 ? 0 : this.currentSelect - 1;
                this.scrollIntoViewIfNeeded()
            },
            onDown: function t() {
                this.currentSelect = this.currentSelect === this.choix.length - 1 ? this.currentSelect : this.currentSelect + 1;
                this.scrollIntoViewIfNeeded()
            },
            selectItem: function t(e) {
                this.$emit("select", e)
            },
            onEnter: function t() {
                this.$emit("select", this.choix[this.currentSelect])
            },
            cancel: function t() {
                this.$emit("cancel")
            }
        },
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter)
            } else {
                this.currentSelect = -1
            }
            this.$bus.$on("keyUpBackspace", this.cancel)
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.cancel)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(21);
    var a = n(4);
    e["default"] = {
        name: "TextModal",
        store: i["a"],
        data: function t() {
            return {
                inputText: ""
            }
        },
        props: {
            title: {
                type: String,
                default: function t() {
                    return ""
                }
            },
            text: {
                type: String,
                default: function t() {
                    return ""
                }
            },
            limit: {
                type: Number,
                default: 255
            }
        },
        computed: r()({}, n.i(a["b"])(["IntlString", "themeColor"]), {
            color: function t() {
                return this.themeColor || "#2A56C6"
            }
        }),
        methods: {
            scrollIntoViewIfNeeded: function t() {
                this.$nextTick(function() {
                    document.querySelector(".modal-choix.select").scrollIntoViewIfNeeded()
                })
            },
            onUp: function t() {
                this.currentSelect = this.currentSelect === 0 ? 0 : this.currentSelect - 1;
                this.scrollIntoViewIfNeeded()
            },
            onDown: function t() {
                this.currentSelect = this.currentSelect === this.choix.length - 1 ? this.currentSelect : this.currentSelect + 1;
                this.scrollIntoViewIfNeeded()
            },
            selectItem: function t(e) {
                this.$emit("select", e)
            },
            onEnter: function t() {
                this.$emit("select", this.choix[this.currentSelect])
            },
            cancel: function t() {
                this.$emit("cancel")
            },
            valide: function t() {
                this.$emit("valid", {
                    text: this.inputText
                })
            }
        },
        created: function t() {
            this.inputText = this.text
        },
        mounted: function t() {
            var e = this;
            this.$nextTick(function() {
                e.$refs.textarea.focus()
            })
        },
        beforeDestroy: function t() {}
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(8);
    var r = n.n(s);
    var i = n(7);
    var a = n.n(i);
    var o = n(3);
    var c = n.n(o);
    var u = n(4);
    var l = n(11);
    var f = n(14);
    var h = n.n(f);
    e["default"] = {
        components: {
            PhoneTitle: h.a
        },
        data: function t() {
            return {
                currentSelect: 0,
                ignoreControls: false
            }
        },
        watch: {
            list: function t() {
                this.currentSelect = 0
            }
        },
        computed: c()({}, n.i(u["b"])(["IntlString", "useMouse", "notesChannels", "Apps"])),
        methods: c()({}, n.i(u["a"])(["notesAddChannel", "notesRemoveChannel"]), {
            scrollIntoViewIfNeeded: function t() {
                var e = this;
                this.$nextTick(function() {
                    var t = e.$el.querySelector(".select");
                    if (t !== null) {
                        t.scrollIntoViewIfNeeded()
                    }
                })
            },
            onUp: function t() {
                if (this.ignoreControls === true) return;
                this.currentSelect = this.currentSelect === 0 ? 0 : this.currentSelect - 1;
                this.scrollIntoViewIfNeeded()
            },
            onDown: function t() {
                if (this.ignoreControls === true) return;
                this.currentSelect = this.currentSelect === this.notesChannels.length - 1 ? this.currentSelect : this.currentSelect + 1;
                this.scrollIntoViewIfNeeded()
            },
            onRight: function t() {
                var e = this;
                return a()(r.a.mark(function t() {
                    var n, s;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    if (!(e.ignoreControls === true)) {
                                        r.next = 2;
                                        break
                                    }
                                    return r.abrupt("return");
                                case 2:
                                    e.ignoreControls = true;
                                    n = [{
                                        id: 1,
                                        title: e.IntlString("APP_DARKTCHAT_NEW_NOTE"),
                                        icons: "fa-plus",
                                        color: "dodgerblue"
                                    }, {
                                        id: 2,
                                        title: e.IntlString("APP_DARKTCHAT_DELETE_NOTE"),
                                        icons: "fa-minus",
                                        color: "tomato"
                                    }, {
                                        id: 3,
                                        title: e.IntlString("APP_DARKTCHAT_CANCEL"),
                                        icons: "fa-undo"
                                    }];
                                    if (e.notesChannels.length === 0) {
                                        n.splice(1, 1)
                                    }
                                    r.next = 7;
                                    return l["a"].CreateModal({
                                        choix: n
                                    });
                                case 7:
                                    s = r.sent;
                                    e.ignoreControls = false;
                                    r.t0 = s.id;
                                    r.next = r.t0 === 1 ? 12 : r.t0 === 2 ? 14 : r.t0 === 3 ? 16 : 16;
                                    break;
                                case 12:
                                    e.addChannelOption();
                                    return r.abrupt("break", 16);
                                case 14:
                                    e.removeChannelOption();
                                    return r.abrupt("break", 16);
                                case 16:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, e)
                }))()
            },
            onEnter: function t() {
                var e = this;
                return a()(r.a.mark(function t() {
                    var n, s;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    if (!(e.ignoreControls === true)) {
                                        r.next = 2;
                                        break
                                    }
                                    return r.abrupt("return");
                                case 2:
                                    if (!(e.notesChannels.length === 0)) {
                                        r.next = 12;
                                        break
                                    }
                                    e.ignoreControls = true;
                                    n = [{
                                        id: 1,
                                        title: e.IntlString("APP_DARKTCHAT_NEW_CHANNEL"),
                                        icons: "fa-plus",
                                        color: "green"
                                    }, {
                                        id: 3,
                                        title: e.IntlString("APP_DARKTCHAT_CANCEL"),
                                        icons: "fa-undo"
                                    }];
                                    r.next = 7;
                                    return l["a"].CreateModal({
                                        choix: n
                                    });
                                case 7:
                                    s = r.sent;
                                    e.ignoreControls = false;
                                    if (s.id === 1) {
                                        e.addChannelOption()
                                    }
                                    r.next = 12;
                                    break;
                                case 12:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, e)
                }))()
            },
            showChannel: function t(e) {
                this.$router.push({
                    name: "notes.channel.show",
                    params: {
                        channel: e
                    }
                })
            },
            onBack: function t() {
                if (this.ignoreControls === true) return;
                this.$router.push({
                    name: "home"
                })
            },
            addChannelOption: function t() {
                var e = this;
                return a()(r.a.mark(function t() {
                    var n, s;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    r.prev = 0;
                                    r.next = 3;
                                    return l["a"].CreateTextModal({
                                        limit: 280,
                                        title: e.IntlString("APP_DARKTCHAT_NEW_CHANNEL")
                                    });
                                case 3:
                                    n = r.sent;
                                    s = (n || {}).text || " ";
                                    s;
                                    if (s.length > 0) {
                                        e.currentSelect = 0;
                                        e.notesAddChannel({
                                            channel: s
                                        })
                                    }
                                    r.next = 11;
                                    break;
                                case 9:
                                    r.prev = 9;
                                    r.t0 = r["catch"](0);
                                case 11:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, e, [
                        [0, 9]
                    ])
                }))()
            },
            removeChannelOption: function t() {
                var e = this;
                return a()(r.a.mark(function t() {
                    var n;
                    return r.a.wrap(function t(s) {
                        while (1) {
                            switch (s.prev = s.next) {
                                case 0:
                                    n = e.notesChannels[e.currentSelect].channel;
                                    e.currentSelect = 0;
                                    e.notesRemoveChannel({
                                        channel: n
                                    });
                                case 3:
                                case "end":
                                    return s.stop()
                            }
                        }
                    }, t, e)
                }))()
            }
        }),
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpArrowRight", this.onRight);
                this.$bus.$on("keyUpEnter", this.onEnter);
                this.$bus.$on("keyUpBackspace", this.onBack)
            } else {
                this.currentSelect = -1
            }
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpArrowRight", this.onRight);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.onBack)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(8);
    var r = n.n(s);
    var i = n(7);
    var a = n.n(i);
    var o = n(3);
    var c = n.n(o);
    var u = n(4);
    var l = n(14);
    var f = n.n(l);
    e["default"] = {
        components: {
            PhoneTitle: f.a
        },
        data: function t() {
            return {
                message: "",
                channel: "",
                currentSelect: 0
            }
        },
        computed: c()({}, n.i(u["b"])(["notesMessages", "notesCurrentChannel", "useMouse"]), {
            channelName: function t() {
                return "# " + this.channel
            }
        }),
        watch: {
            notesMessages: function t() {
                var e = this.$refs.elementsDiv;
                e.scrollTop = e.scrollHeight
            }
        },
        methods: c()({
            setChannel: function t(e) {
                this.channel = e;
                this.notesSetChannel({
                    channel: e
                })
            }
        }, n.i(u["a"])(["notesSetChannel", "notesSendMessage"]), {
            scrollIntoViewIfNeeded: function t() {
                var e = this;
                this.$nextTick(function() {
                    var t = e.$el.querySelector(".select");
                    if (t !== null) {
                        t.scrollIntoViewIfNeeded()
                    }
                })
            },
            onUp: function t() {
                var e = this.$refs.elementsDiv;
                e.scrollTop = e.scrollTop - 120
            },
            onDown: function t() {
                var e = this.$refs.elementsDiv;
                e.scrollTop = e.scrollTop + 120
            },
            onEnter: function t() {
                var e = this;
                return a()(r.a.mark(function t() {
                    var n, s;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    r.next = 2;
                                    return e.$phoneAPI.getReponseText();
                                case 2:
                                    n = r.sent;
                                    if (n !== undefined && n.text !== undefined) {
                                        s = n.text.trim();
                                        if (s.length !== 0) {
                                            e.notesSendMessage({
                                                channel: e.channel,
                                                message: s
                                            })
                                        }
                                    }
                                case 4:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, e)
                }))()
            },
            sendMessage: function t() {
                var e = this.message.trim();
                if (e.length !== 0) {
                    this.notesSendMessage({
                        channel: this.channel,
                        message: e
                    });
                    this.message = ""
                }
            },
            onBack: function t() {
                if (this.useMouse === true && document.activeElement.tagName !== "BODY") return;
                this.onQuit()
            },
            onQuit: function t() {
                this.$router.push({
                    name: "notes.channel"
                })
            },
            formatTime: function t(e) {
                var n = new Date(e);
                return n.toLocaleTimeString()
            }
        }),
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter)
            } else {
                this.currentSelect = -1
            }
            this.$bus.$on("keyUpBackspace", this.onBack);
            this.setChannel(this.$route.params.channel)
        },
        mounted: function t() {
            window.c = this.$refs.elementsDiv;
            var e = this.$refs.elementsDiv;
            e.scrollTop = e.scrollHeight
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.onBack)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(4);
    var a = n(29);
    var o = n.n(a);
    e["default"] = {
        components: {
            InfoBare: o.a
        },
        computed: r()({}, n.i(i["b"])(["themeColorTitle"]), {
            style: function t() {
                return {
                    backgroundColor: this.backgroundColor || this.themeColorTitle,
                    color: this.color || "#FFF"
                }
            }
        }),
        methods: {
            back: function t() {
                this.$emit("back")
            }
        },
        props: {
            title: {
                type: String,
                required: true
            },
            showInfoBare: {
                type: Boolean,
                default: true
            },
            backgroundColor: {
                type: String
            }
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(4);
    var a = n(14);
    var o = n.n(a);
    var c = n(299);
    var u = n.n(c);
    var l = n(298);
    var f = n.n(l);
    e["default"] = {
        components: {
            PhoneTitle: o.a
        },
        data: function t() {
            return {
                currentMenuIndex: 1
            }
        },
        computed: r()({}, n.i(i["b"])(["IntlString", "useMouse", "themeColor"]), {
            subMenu: function t() {
                return [{
                    Comp: u.a,
                    name: this.IntlString("APP_PHONE_MENU_FAVORITES"),
                    icon: "star"
                }, {
                    Comp: f.a,
                    name: this.IntlString("APP_PHONE_MENU_CONTACTS"),
                    icon: "user"
                }]
            }
        }),
        methods: {
            getColorItem: function t(e) {
                if (this.currentMenuIndex === e) {
                    return {
                        color: this.themeColor
                    }
                }
                return {}
            },
            swapMenu: function t(e) {
                this.currentMenuIndex = e
            },
            onLeft: function t() {
                this.currentMenuIndex = Math.max(this.currentMenuIndex - 1, 0)
            },
            onRight: function t() {
                this.currentMenuIndex = Math.min(this.currentMenuIndex + 1, this.subMenu.length - 1)
            },
            onBackspace: function t() {
                if (this.ignoreControls === true) return;
                this.$router.push({
                    name: "home"
                })
            }
        },
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpBackspace", this.onBackspace);
                this.$bus.$on("keyUpArrowLeft", this.onLeft);
                this.$bus.$on("keyUpArrowRight", this.onRight)
            }
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpBackspace", this.onBackspace);
            this.$bus.$off("keyUpArrowLeft", this.onLeft);
            this.$bus.$off("keyUpArrowRight", this.onRight)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(4);
    var a = n(29);
    var o = n.n(a);
    e["default"] = {
        components: {
            InfoBare: o.a
        },
        data: function t() {
            return {
                time: -1,
                intervalNum: undefined,
                select: 1,
                status: 0
            }
        },
        methods: r()({}, n.i(i["a"])(["acceptCall", "rejectCall", "ignoreCall"]), {
            onBackspace: function t() {
                if (this.status === 1) {
                    this.onRejectCall()
                } else {
                    this.onIgnoreCall()
                }
            },
            onEnter: function t() {
                if (this.status === 0) {
                    if (this.select === 0) {
                        this.onRejectCall()
                    } else {
                        this.onAcceptCall()
                    }
                }
            },
            raccrocher: function t() {
                this.onRejectCall()
            },
            deccrocher: function t() {
                if (this.status === 0) {
                    this.onAcceptCall()
                }
            },
            onLeft: function t() {
                if (this.status === 0) {
                    this.select = 0
                }
            },
            onRight: function t() {
                if (this.status === 0) {
                    this.select = 1
                }
            },
            updateTime: function t() {
                this.time += 1
            },
            onRejectCall: function t() {
                this.rejectCall();
                this.$phoneAPI.setIgnoreFocus(false)
            },
            onAcceptCall: function t() {
                this.acceptCall();
                this.$phoneAPI.setIgnoreFocus(true)
            },
            onIgnoreCall: function t() {
                this.ignoreCall();
                this.$phoneAPI.setIgnoreFocus(false);
                this.$router.push({
                    name: "home"
                })
            },
            startTimer: function t() {
                if (this.intervalNum === undefined) {
                    this.time = 0;
                    this.intervalNum = setInterval(this.updateTime, 1e3)
                }
            }
        }),
        watch: {
            appelsInfo: function t() {
                if (this.appelsInfo === null) return;
                if (this.appelsInfo.is_accepts === true) {
                    this.status = 1;
                    this.$phoneAPI.setIgnoreFocus(true);
                    this.startTimer()
                }
            }
        },
        computed: r()({}, n.i(i["b"])(["IntlString", "backgroundURL", "useMouse", "appelsInfo", "appelsDisplayName", "appelsDisplayNumber", "myPhoneNumber"]), {
            timeDisplay: function t() {
                if (this.time < 0) {
                    return ". . ."
                }
                var e = Math.floor(this.time / 60);
                var n = this.time % 60;
                if (n < 10) {
                    n = "0" + n
                }
                return e + ":" + n
            }
        }),
        mounted: function t() {
            if (this.appelsInfo !== null && this.appelsInfo.initiator === true) {
                this.status = 1;
                this.$phoneAPI.setIgnoreFocus(true)
            }
        },
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpEnter", this.onEnter);
                this.$bus.$on("keyUpArrowLeft", this.onLeft);
                this.$bus.$on("keyUpArrowRight", this.onRight)
            }
            this.$bus.$on("keyUpBackspace", this.onBackspace)
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpBackspace", this.onBackspace);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpArrowLeft", this.onLeft);
            this.$bus.$off("keyUpArrowRight", this.onRight);
            if (this.intervalNum !== undefined) {
                window.clearInterval(this.intervalNum)
            }
            this.$phoneAPI.setIgnoreFocus(false)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(16);
    var r = n.n(s);
    var i = n(3);
    var a = n.n(i);
    var o = n(4);
    var c = n(38);
    var u = n(25);
    var l = n.n(u);
    e["default"] = {
        name: "Contacts",
        components: {
            List: l.a
        },
        data: function t() {
            return {}
        },
        methods: a()({}, n.i(o["a"])(["startCall"]), {
            onSelect: function t(e) {
                if (e !== undefined) {
                    if (e.custom === true) {
                        this.$router.push({
                            name: "phone.number"
                        })
                    } else {
                        this.startCall({
                            numero: e.number
                        })
                    }
                }
            }
        }),
        computed: a()({}, n.i(o["b"])(["IntlString", "contacts"]), {
            contactsList: function t() {
                return [{
                    display: this.IntlString("APP_PHONE_ENTER_NUMBER"),
                    letter: "#",
                    backgroundColor: "#D32F2F",
                    custom: true
                }].concat(r()(this.contacts.slice(0).map(function(t) {
                    t.backgroundColor = n.i(c["a"])(t.number);
                    return t
                })))
            }
        }),
        created: function t() {},
        beforeDestroy: function t() {}
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(16);
    var r = n.n(s);
    var i = n(3);
    var a = n.n(i);
    var o = n(4);
    var c = n(25);
    var u = n.n(c);
    var l = n(11);
    e["default"] = {
        name: "Favoris",
        components: {
            List: u.a
        },
        data: function t() {
            return {
                ignoreControls: false
            }
        },
        computed: a()({}, n.i(o["b"])(["config"]), {
            callList: function t() {
                return this.config.serviceCall || []
            }
        }),
        methods: {
            onSelect: function t(e) {
                var n = this;
                if (this.ignoreControls === true) return;
                this.ignoreControls = true;
                l["a"].CreateModal({
                    choix: [].concat(r()(e.subMenu), [{
                        title: "Cancelar"
                    }])
                }).then(function(t) {
                    n.ignoreControls = false;
                    if (t.title === "Cancelar") return;
                    n.$phoneAPI.callEvent(t.eventName, t.type);
                    n.$router.push({
                        name: "home"
                    })
                })
            }
        },
        created: function t() {},
        beforeDestroy: function t() {}
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(4);
    var a = n(14);
    var o = n.n(a);
    e["default"] = {
        components: {
            PhoneTitle: o.a
        },
        data: function t() {
            return {
                numero: "",
                keyInfo: [{
                    primary: "1",
                    secondary: ""
                }, {
                    primary: "2",
                    secondary: "abc"
                }, {
                    primary: "3",
                    secondary: "def"
                }, {
                    primary: "4",
                    secondary: "ghi"
                }, {
                    primary: "5",
                    secondary: "jkl"
                }, {
                    primary: "6",
                    secondary: "mmo"
                }, {
                    primary: "7",
                    secondary: "pqrs"
                }, {
                    primary: "8",
                    secondary: "tuv"
                }, {
                    primary: "9",
                    secondary: "wxyz"
                }, {
                    primary: "-",
                    secondary: "",
                    isNotNumber: true
                }, {
                    primary: "0",
                    secondary: "+"
                }, {
                    primary: "+",
                    secondary: "+",
                    isNotNumber: true
                }],
                keySelect: 0
            }
        },
        methods: r()({}, n.i(i["a"])(["startCall"]), {
            onLeft: function t() {
                this.keySelect = Math.max(this.keySelect - 1, 0)
            },
            onRight: function t() {
                this.keySelect = Math.min(this.keySelect + 1, 11)
            },
            onDown: function t() {
                this.keySelect = Math.min(this.keySelect + 3, 12)
            },
            onUp: function t() {
                if (this.keySelect > 2) {
                    if (this.keySelect === 12) {
                        this.keySelect = 10
                    } else {
                        this.keySelect = this.keySelect - 3
                    }
                }
            },
            onEnter: function t() {
                if (this.keySelect === 12) {
                    if (this.numero.length > 0) {
                        this.startCall({
                            numero: this.numeroFormat
                        })
                    }
                } else {
                    this.numero += this.keyInfo[this.keySelect].primary
                }
            },
            onBackspace: function t() {
                if (this.ignoreControls === true) return;
                if (this.numero.length !== 0) {
                    this.numero = this.numero.slice(0, -1)
                } else {
                    history.back()
                }
            },
            deleteNumber: function t() {
                if (this.numero.length !== 0) {
                    this.numero = this.numero.slice(0, -1)
                }
            },
            onPressKey: function t(e) {
                this.numero = this.numero + e.primary
            },
            onPressCall: function t() {
                this.startCall({
                    numero: this.numeroFormat
                })
            },
            quit: function t() {
                history.back()
            }
        }),
        computed: r()({}, n.i(i["b"])(["IntlString", "useMouse", "useFormatNumberFrance"]), {
            numeroFormat: function t() {
                if (this.useFormatNumberFrance === true) {
                    return this.numero
                }
                var e = this.numero.startsWith("#") ? 4 : 3;
                if (this.numero.length > e) {
                    return this.numero.slice(0, e) + "-" + this.numero.slice(e)
                } else {
                    return this.numero
                }
            }
        }),
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpBackspace", this.onBackspace);
                this.$bus.$on("keyUpArrowLeft", this.onLeft);
                this.$bus.$on("keyUpArrowRight", this.onRight);
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter)
            } else {
                this.keySelect = -1
            }
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpBackspace", this.onBackspace);
            this.$bus.$off("keyUpArrowLeft", this.onLeft);
            this.$bus.$off("keyUpArrowRight", this.onRight);
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(10);
    e["default"] = {
        created: function t() {
            s["a"].faketakePhoto()
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(4);
    var a = n(25);
    var o = n.n(a);
    e["default"] = {
        components: {
            List: o.a
        },
        data: function t() {
            return {
                currentSelect: 0,
                nBotonesMenu: 3
            }
        },
        computed: r()({}, n.i(i["b"])(["folders"])),
        methods: r()({}, n.i(i["a"])(["closePhone", "setMessages"]), {
            onSelect: function t(e) {
                this.$router.push({
                    path: "/valet/" + e.display
                })
            },
            onLeft: function t() {},
            onRight: function t() {},
            onUp: function t() {},
            onDown: function t() {},
            onEnter: function t() {},
            onBack: function t() {
                this.$router.go(-1)
            }
        }),
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowLeft", this.onLeft);
                this.$bus.$on("keyUpArrowRight", this.onRight);
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter)
            } else {
                this.currentSelect = -1
            }
            this.$bus.$on("keyUpBackspace", this.onBack)
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowLeft", this.onLeft);
            this.$bus.$off("keyUpArrowRight", this.onRight);
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.onBack)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(39);
    var r = n.n(s);
    var i = n(3);
    var a = n.n(i);
    var o = n(4);
    var c = n(25);
    var u = n.n(c);
    e["default"] = {
        components: {
            List: u.a
        },
        data: function t() {
            return {
                currentSelect: 0,
                nBotonesMenu: 3,
                folder: ""
            }
        },
        computed: a()({}, n.i(o["b"])(["folders"]), {
            vehicles: function t() {
                var e = true;
                var n = false;
                var s = undefined;
                try {
                    for (var i = r()(this.folders), a; !(e = (a = i.next()).done); e = true) {
                        var o = a.value;
                        if (o.display === this.folder) {
                            return o.vehicles
                        }
                    }
                } catch (t) {
                    n = true;
                    s = t
                } finally {
                    try {
                        if (!e && i.return) {
                            i.return()
                        }
                    } finally {
                        if (n) {
                            throw s
                        }
                    }
                }
            }
        }),
        methods: a()({}, n.i(o["a"])(["closePhone", "setMessages"]), {
            onSelect: function t(e) {
                this.$phoneAPI.spawnvehicle(e.spawncode)
            },
            onLeft: function t() {},
            onRight: function t() {},
            onUp: function t() {},
            onDown: function t() {},
            onEnter: function t() {},
            onBack: function t() {
                this.$router.go(-1)
            }
        }),
        created: function t() {
            this.folder = this.$route.params.folder;
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowLeft", this.onLeft);
                this.$bus.$on("keyUpArrowRight", this.onRight);
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter)
            } else {
                this.currentSelect = -1
            }
            this.$bus.$on("keyUpBackspace", this.onBack)
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowLeft", this.onLeft);
            this.$bus.$off("keyUpArrowRight", this.onRight);
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.onBack)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(4);
    var a = n(14);
    var o = n.n(a);
    e["default"] = {
        components: {
            PhoneTitle: o.a
        },
        data: function t() {
            return {
                currentSelect: 0
            }
        },
        computed: r()({}, n.i(i["b"])(["IntlString", "useMouse", "bourseInfo"])),
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp)
            }
            this.$bus.$on("keyUpBackspace", this.onBackspace)
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpBackspace", this.onBackspace)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(4);
    var a = n(14);
    var o = n.n(a);
    var c = n(11);
    e["default"] = {
        components: {
            PhoneTitle: o.a
        },
        data: function t() {
            return {
                id: -1,
                currentSelect: 0,
                ignoreControls: false,
                contact: {
                    display: "",
                    number: "",
                    id: -1
                },
                typing: false
            }
        },
        computed: r()({}, n.i(i["b"])(["IntlString", "contacts", "useMouse"])),
        methods: r()({}, n.i(i["a"])(["updateContact", "addContact"]), {
            onUp: function t() {
                if (this.ignoreControls === true && !this.typing) return;
                var e = document.querySelector(".group.select");
                if (e.previousElementSibling !== null) {
                    document.querySelectorAll(".group").forEach(function(t) {
                        t.classList.remove("select")
                    });
                    e.previousElementSibling.classList.add("select");
                    var n = e.previousElementSibling.querySelector("input");
                    if (n !== null) {
                        n.focus()
                    }
                }
            },
            onDown: function t() {
                if (this.ignoreControls === true && !this.typing) return;
                var e = document.querySelector(".group.select");
                if (e === null) {
                    e = document.querySelector(".group");
                    e.classList.add("select");
                    return
                }
                while (e.nextElementSibling !== null) {
                    if (e.nextElementSibling.classList.contains("group")) {
                        break
                    }
                    e = e.nextElementSibling
                }
                if (e.nextElementSibling !== null) {
                    document.querySelectorAll(".group").forEach(function(t) {
                        t.classList.remove("select")
                    });
                    e.nextElementSibling.classList.add("select");
                    var n = e.nextElementSibling.querySelector("input");
                    if (n !== null) {
                        n.focus()
                    }
                }
            },
            onEnter: function t() {
                if (this.ignoreControls === true) return;
                var e = document.querySelector(".group.select");
                if (this.contact.display == "New Contact") {
                    this.contact.display = ""
                }
                if (e.dataset.type === "text") {
                    this.$phoneAPI.setFocus(true).then(null);
                    this.ignoreControls = true;
                    this.typing = true;
                    this.onDown();
                    this.onUp()
                }
                if (e.dataset.action && this[e.dataset.action]) {
                    this[e.dataset.action]()
                }
            },
            save: function t() {
                history.back();
                if (this.id === -1 || this.id === 0) {
                    this.addContact({
                        display: this.contact.display,
                        number: this.contact.number
                    });
                    this.$phoneAPI.setFocus(false).then(null);
                    this.ignoreControls = false;
                    this.typing = false
                } else {
                    this.updateContact({
                        id: this.id,
                        display: this.contact.display,
                        number: this.contact.number
                    });
                    this.$phoneAPI.setFocus(false).then(null);
                    this.ignoreControls = false;
                    this.typing = false
                }
            },
            cancel: function t() {
                var e = this;
                this.$phoneAPI.setFocus(false).then(null);
                this.ignoreControls = false;
                if (this.useMouse === true && document.activeElement.tagName !== "BODY") return;
                history.back();
                setTimeout(function() {
                    e.typing = false;
                    e.ignoreControls = false
                }, 100)
            },
            deleteC: function t() {
                var e = this;
                if (this.id !== -1) {
                    this.ignoreControls = true;
                    var n = [{
                        title: "Are you sure you wanted to do this?"
                    }, {
                        title: "No"
                    }, {
                        title: "Yes",
                        color: "red"
                    }];
                    c["a"].CreateModal({
                        choix: n
                    }).then(function(t) {
                        e.ignoreControls = false;
                        if (t.title === "Yes") {
                            e.$phoneAPI.deleteContact(e.id);
                            history.back()
                        }
                    })
                } else {
                    history.back()
                }
            },
            onBackspace: function t() {
                if (!this.typing && !this.ignoreControls) {
                    this.cancel()
                }
            }
        }),
        created: function t() {
            var e = this;
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter)
            } else {
                this.currentSelect = -1
            }
            this.$bus.$on("keyUpBackspace", this.onBackspace);
            this.id = parseInt(this.$route.params.id);
            this.contact.display = this.IntlString("APP_CONTACT_NEW");
            this.contact.number = this.$route.params.number;
            if (this.id !== -1) {
                var n = this.contacts.find(function(t) {
                    return t.id === e.id
                });
                if (n !== undefined) {
                    this.contact = {
                        id: n.id,
                        display: n.display,
                        number: n.number
                    }
                }
            }
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.onBackspace)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(27);
    var r = n.n(s);
    var i = n(16);
    var a = n.n(i);
    var o = n(3);
    var c = n.n(o);
    var u = n(4);
    var l = n(38);
    var f = n(25);
    var h = n.n(f);
    var p = n(11);
    e["default"] = {
        components: {
            List: h.a
        },
        data: function t() {
            return {
                disableList: false
            }
        },
        computed: c()({}, n.i(u["b"])(["IntlString", "contacts", "useMouse"]), {
            lcontacts: function t() {
                var e = {
                    display: this.IntlString("APP_CONTACT_NEW"),
                    letter: "+",
                    num: "",
                    id: -1
                };
                return [e].concat(a()(this.contacts.map(function(t) {
                    t.backgroundColor = t.backgroundColor || n.i(l["a"])(t.number);
                    return t
                })))
            }
        }),
        methods: {
            onSelect: function t(e) {
                if (e.id === -1) {
                    this.$router.push({
                        name: "contacts.view",
                        params: {
                            id: e.id
                        }
                    })
                } else {
                    this.$router.push({
                        name: "messages.view",
                        params: {
                            number: e.number,
                            display: e.display
                        }
                    })
                }
            },
            onOption: function t(e) {
                var n = this;
                if (e.id === -1 || e.id === undefined) return;
                this.disableList = true;
                p["a"].CreateModal({
                    choix: [{
                        id: 1,
                        title: this.IntlString("APP_CONTACT_EDIT"),
                        icons: "fa-circle-o",
                        color: "orange"
                    }, {
                        id: 2,
                        title: "Block Contact",
                        icons: "fa-circle-o",
                        color: "red"
                    }, {
                        id: 3,
                        title: "UnBlock Contact",
                        icons: "fa-circle-o",
                        color: "red"
                    }, {
                        id: 4,
                        title: "Abort",
                        icons: "fa-undo"
                    }]
                }).then(function(t) {
                    if (t.id === 1) {
                        n.$router.push({
                            path: "contact/" + e.id
                        })
                    } else if (t.id === 2) {
                        n.$phoneAPI.blockNumber(e.number)
                    } else if (t.id === 3) {
                        n.$phoneAPI.unblockNumber(e.number)
                    }
                    n.disableList = false
                })
            },
            back: function t() {
                if (this.disableList === true) return;
                this.$router.push({
                    name: "home"
                })
            }
        },
        created: function t() {
            console.log(r()(this.lcontacts));
            if (!this.useMouse) {
                this.$bus.$on("keyUpBackspace", this.back)
            }
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpBackspace", this.back)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(16);
    var r = n.n(s);
    var i = n(3);
    var a = n.n(i);
    var o = n(25);
    var c = n.n(o);
    var u = n(4);
    var l = n(11);
    e["default"] = {
        components: {
            List: c.a
        },
        data: function t() {
            return {}
        },
        computed: a()({}, n.i(u["b"])(["IntlString", "contacts", "useMouse"]), {
            lcontacts: function t() {
                var e = {
                    display: this.IntlString("APP_MESSAGE_CONTRACT_ENTER_NUMBER"),
                    letter: "+",
                    backgroundColor: "orange",
                    num: -1
                };
                return [e].concat(r()(this.contacts))
            }
        }),
        methods: {
            onSelect: function t(e) {
                var n = this;
                if (e.num === -1) {
                    l["a"].CreateTextModal({
                        title: this.IntlString("APP_PHONE_ENTER_NUMBER"),
                        limit: 10
                    }).then(function(t) {
                        var e = t.text.trim();
                        if (e !== "") {
                            n.$router.push({
                                name: "messages.view",
                                params: {
                                    number: e,
                                    display: e
                                }
                            })
                        }
                    })
                } else {
                    this.$router.push({
                        name: "messages.view",
                        params: e
                    })
                }
            },
            back: function t() {
                history.back()
            }
        },
        created: function t() {
            this.$bus.$on("keyUpBackspace", this.back)
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpBackspace", this.back)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(8);
    var r = n.n(s);
    var i = n(16);
    var a = n.n(i);
    var o = n(7);
    var c = n.n(o);
    var u = n(3);
    var l = n.n(u);
    var f = n(4);
    var h = n(38);
    var p = n(14);
    var d = n.n(p);
    var v = n(11);
    e["default"] = {
        data: function t() {
            return {
                ignoreControls: false,
                selectMessage: -1,
                display: "",
                phoneNumber: "",
                imgZoom: undefined,
                message: "",
                sendingMessage: false
            }
        },
        components: {
            PhoneTitle: d.a
        },
        methods: l()({}, n.i(f["a"])(["setMessageRead", "sendMessage", "deleteMessage", "startCall"]), {
            resetScroll: function t() {
                var e = this;
                this.$nextTick(function() {
                    var t = document.querySelector("#sms_list");
                    t.scrollTop = t.scrollHeight;
                    e.selectMessage = -1
                })
            },
            scrollIntoViewIfNeeded: function t() {
                var e = this;
                this.$nextTick(function() {
                    var t = e.$el.querySelector(".select");
                    if (t !== null) {
                        t.scrollIntoViewIfNeeded()
                    }
                })
            },
            quit: function t() {
                this.$router.go(-1)
            },
            onUp: function t() {
                if (this.ignoreControls === true) return;
                if (this.selectMessage === -1) {
                    this.selectMessage = this.messagesList.length - 1
                } else {
                    this.selectMessage = this.selectMessage === 0 ? 0 : this.selectMessage - 1
                }
                this.scrollIntoViewIfNeeded()
            },
            onDown: function t() {
                if (this.ignoreControls === true) return;
                if (this.selectMessage === -1) {
                    this.selectMessage = this.messagesList.length - 1
                } else {
                    this.selectMessage = this.selectMessage === this.messagesList.length - 1 ? this.selectMessage : this.selectMessage + 1
                }
                this.scrollIntoViewIfNeeded()
            },
            onEnter: function t() {
                var e = this;
                if (this.sendingMessage === true) {
                    if (this.message === "") {
                        return this.$phoneAPI.setFocus(false).then(function(t) {
                            e.ignoreControls = false
                        })
                    }
                    return
                }
                if (this.ignoreControls === true) return;
                if (this.selectMessage !== -1) {
                    this.onActionMessage(this.messagesList[this.selectMessage])
                } else {
                    this.$phoneAPI.setFocus(true).then(function(t) {
                        e.ignoreControls = true
                    });
                    this.ignoreControls = true
                }
            },
            send: function t() {
                var e = this;
                if (this.sendingMessage === true) return;
                var n = this.message.trim();
                if (n === "") {
                    this.ignoreControls = false;
                    this.sendingMessage = false;
                    return this.$phoneAPI.setFocus(false).then(function(t) {
                        e.ignoreControls = false
                    })
                }
                this.sendingMessage = true;
                this.message = "";
                this.sendMessage({
                    phoneNumber: this.phoneNumber,
                    message: n
                });
                this.$phoneAPI.setFocus(false).then(function(t) {
                    e.ignoreControls = false
                });
                this.ignoreControls = false;
                setTimeout(function() {
                    e.sendingMessage = false
                }, 1e3)
            },
            isSMSImage: function t(e) {
                return /^https?:\/\/.*\.(png|jpg|jpeg|gif)/.test(e.message)
            },
            onActionMessage: function t(e) {
                var n = this;
                return c()(r.a.mark(function t() {
                    var s, i, o, c, u, l, f;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    r.prev = 0;
                                    s = /(-?\d+(\.\d+)?), (-?\d+(\.\d+)?)/.test(e.message);
                                    i = /#([0-9]+)/.test(e.message);
                                    o = n.isSMSImage(e);
                                    c = [{
                                        id: "delete",
                                        title: n.IntlString("APP_MESSAGE_DELETE"),
                                        icons: "fa-trash"
                                    }, {
                                        id: -1,
                                        title: n.IntlString("CANCEL"),
                                        icons: "fa-undo"
                                    }];
                                    if (s === true) {
                                        c = [{
                                            id: "gps",
                                            title: n.IntlString("APP_MESSAGE_SET_GPS"),
                                            icons: "fa-location-arrow"
                                        }].concat(a()(c))
                                    }
                                    if (i === true) {
                                        u = e.message.match(/#([0-9-]*)/)[1];
                                        c = [{
                                            id: "num",
                                            title: n.IntlString("APP_MESSAGE_MESS_NUMBER") + " " + u,
                                            number: u,
                                            icons: "fa-phone"
                                        }].concat(a()(c))
                                    }
                                    if (o === true) {
                                        c = [{
                                            id: "zoom",
                                            title: n.IntlString("APP_MESSAGE_ZOOM_IMG"),
                                            icons: "fa-search"
                                        }].concat(a()(c))
                                    }
                                    n.ignoreControls = true;
                                    r.next = 11;
                                    return v["a"].CreateModal({
                                        choix: c
                                    });
                                case 11:
                                    l = r.sent;
                                    if (l.id === "delete") {
                                        n.deleteMessage({
                                            id: e.id
                                        })
                                    } else if (l.id === "gps") {
                                        f = e.message.match(/(-?\d+(\.\d+)?), (-?\d+(\.\d+)?)/);
                                        n.$phoneAPI.setGPS(f[1], f[3])
                                    } else if (l.id === "num") {
                                        n.$nextTick(function() {
                                            n.onSelectPhoneNumber(l.number)
                                        })
                                    } else if (l.id === "zoom") {
                                        n.imgZoom = e.message
                                    }
                                    r.next = 17;
                                    break;
                                case 15:
                                    r.prev = 15;
                                    r.t0 = r["catch"](0);
                                case 17:
                                    r.prev = 17;
                                    n.ignoreControls = false;
                                    n.selectMessage = -1;
                                    return r.finish(17);
                                case 21:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, n, [
                        [0, 15, 17, 21]
                    ])
                }))()
            },
            onSelectPhoneNumber: function t(e) {
                var n = this;
                return c()(r.a.mark(function t() {
                    var s, i, a;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    r.prev = 0;
                                    n.ignoreControls = true;
                                    s = [{
                                        id: "sms",
                                        title: n.IntlString("APP_MESSAGE_MESS_SMS"),
                                        icons: "fa-comment"
                                    }, {
                                        id: "call",
                                        title: n.IntlString("APP_MESSAGE_MESS_CALL"),
                                        icons: "fa-phone"
                                    }];
                                    s.push({
                                        id: "copy",
                                        title: n.IntlString("APP_MESSAGE_MESS_COPY"),
                                        icons: "fa-copy"
                                    });
                                    s.push({
                                        id: -1,
                                        title: n.IntlString("CANCEL"),
                                        icons: "fa-undo"
                                    });
                                    r.next = 7;
                                    return v["a"].CreateModal({
                                        choix: s
                                    });
                                case 7:
                                    i = r.sent;
                                    if (!(i.id === "sms")) {
                                        r.next = 13;
                                        break
                                    }
                                    n.phoneNumber = e;
                                    n.display = undefined;
                                    r.next = 31;
                                    break;
                                case 13:
                                    if (!(i.id === "call")) {
                                        r.next = 17;
                                        break
                                    }
                                    n.startCall({
                                        numero: e
                                    });
                                    r.next = 31;
                                    break;
                                case 17:
                                    if (!(i.id === "copy")) {
                                        r.next = 31;
                                        break
                                    }
                                    r.prev = 18;
                                    a = n.$refs.copyTextarea;
                                    a.value = e;
                                    a.style.height = "20px";
                                    a.focus();
                                    a.select();
                                    r.next = 26;
                                    return document.execCommand("copy");
                                case 26:
                                    a.style.height = "0";
                                    r.next = 31;
                                    break;
                                case 29:
                                    r.prev = 29;
                                    r.t0 = r["catch"](18);
                                case 31:
                                    r.next = 35;
                                    break;
                                case 33:
                                    r.prev = 33;
                                    r.t1 = r["catch"](0);
                                case 35:
                                    r.prev = 35;
                                    n.ignoreControls = false;
                                    n.selectMessage = -1;
                                    return r.finish(35);
                                case 39:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, n, [
                        [0, 33, 35, 39],
                        [18, 29]
                    ])
                }))()
            },
            onBackspace: function t() {
                var e = this;
                if (this.imgZoom !== undefined) {
                    this.imgZoom = undefined;
                    return
                }
                if (this.message === "" && this.ignoreControls === true) {
                    return this.$phoneAPI.setFocus(false).then(function(t) {
                        e.ignoreControls = false;
                        e.sendingMessage = false
                    })
                }
                if (this.ignoreControls === true) return;
                if (this.useMouse === true && document.activeElement.tagName !== "BODY") return;
                if (this.selectMessage !== -1) {
                    this.selectMessage = -1
                } else {
                    this.quit()
                }
            },
            showOptions: function t() {
                var e = this;
                return c()(r.a.mark(function t() {
                    var n, s, i, a;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    r.prev = 0;
                                    e.ignoreControls = true;
                                    n = [{
                                        id: 1,
                                        title: e.IntlString("APP_MESSAGE_SEND_GPS"),
                                        icons: "fa-location-arrow"
                                    }, {
                                        id: -1,
                                        title: e.IntlString("CANCEL"),
                                        icons: "fa-undo"
                                    }];
                                    if (e.enableTakePhoto) {
                                        n = [{
                                            id: 1,
                                            title: e.IntlString("APP_MESSAGE_SEND_GPS"),
                                            icons: "fa-location-arrow"
                                        }, {
                                            id: 2,
                                            title: e.IntlString("APP_MESSAGE_SEND_PHOTO"),
                                            icons: "fa-picture-o"
                                        }, {
                                            id: -1,
                                            title: e.IntlString("CANCEL"),
                                            icons: "fa-undo"
                                        }]
                                    }
                                    r.next = 6;
                                    return v["a"].CreateModal({
                                        choix: n
                                    });
                                case 6:
                                    s = r.sent;
                                    if (s.id === 1) {
                                        e.sendMessage({
                                            phoneNumber: e.phoneNumber,
                                            message: "%pos%"
                                        })
                                    }
                                    if (!(s.id === 2)) {
                                        r.next = 14;
                                        break
                                    }
                                    r.next = 11;
                                    return e.$phoneAPI.takePhoto();
                                case 11:
                                    i = r.sent;
                                    a = i.url;
                                    if (a !== null && a !== undefined) {
                                        e.sendMessage({
                                            phoneNumber: e.phoneNumber,
                                            message: a
                                        })
                                    }
                                case 14:
                                    e.ignoreControls = false;
                                    r.next = 19;
                                    break;
                                case 17:
                                    r.prev = 17;
                                    r.t0 = r["catch"](0);
                                case 19:
                                    r.prev = 19;
                                    e.ignoreControls = false;
                                    return r.finish(19);
                                case 22:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, e, [
                        [0, 17, 19, 22]
                    ])
                }))()
            },
            onRight: function t() {
                if (this.ignoreControls === true) return;
                if (this.selectMessage === -1) {
                    this.showOptions()
                }
            }
        }),
        computed: l()({}, n.i(f["b"])(["IntlString", "messages", "contacts", "useMouse", "enableTakePhoto"]), {
            messagesList: function t() {
                var e = this;
                return this.messages.filter(function(t) {
                    return t.transmitter === e.phoneNumber
                }).sort(function(t, e) {
                    return t.time - e.time
                })
            },
            displayContact: function t() {
                var e = this;
                if (this.display !== undefined) {
                    return this.display
                }
                var n = this.contacts.find(function(t) {
                    return t.number === e.phoneNumber
                });
                if (n !== undefined) {
                    return n.display
                }
                return this.phoneNumber
            },
            color: function t() {
                return n.i(h["a"])(this.phoneNumber)
            },
            colorSmsOwner: function t() {
                return [{
                    backgroundColor: this.color,
                    color: n.i(h["b"])(this.color)
                }, {}]
            }
        }),
        watch: {
            messagesList: function t() {
                this.setMessageRead(this.phoneNumber);
                this.resetScroll()
            }
        },
        created: function t() {
            this.display = this.$route.params.display;
            this.phoneNumber = this.$route.params.number;
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter);
                this.$bus.$on("keyUpArrowRight", this.onRight)
            }
            this.$bus.$on("keyUpBackspace", this.onBackspace)
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpArrowRight", this.onRight);
            this.$bus.$off("keyUpBackspace", this.onBackspace)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(32);
    var r = n.n(s);
    var i = n(3);
    var a = n.n(i);
    var o = n(4);
    var c = n(38);
    var u = n(11);
    var l = n(25);
    var f = n.n(l);
    e["default"] = {
        components: {
            List: f.a
        },
        data: function t() {
            return {
                disableList: false
            }
        },
        methods: a()({}, n.i(o["a"])(["deleteMessagesNumber", "deleteAllMessages", "startCall"]), {
            onSelect: function t(e) {
                if (e.id === -1) {
                    this.$router.push({
                        name: "messages.selectcontact"
                    })
                } else {
                    this.$router.push({
                        name: "messages.view",
                        params: e
                    })
                }
            },
            onOption: function t(e) {
                var n = this;
                if (e.number === undefined) return;
                this.disableList = true;
                u["a"].CreateModal({
                    choix: [{
                        id: 4,
                        title: this.IntlString("APP_PHONE_CALL"),
                        icons: "fa-phone"
                    }, {
                        id: 5,
                        title: this.IntlString("APP_PHONE_CALL_ANONYMOUS"),
                        icons: "fa-mask"
                    }, {
                        id: 6,
                        title: this.IntlString("APP_MESSAGE_NEW_MESSAGE"),
                        icons: "fa-sms"
                    }, {
                        id: 1,
                        title: this.IntlString("APP_MESSAGE_ERASE_CONVERSATION"),
                        icons: "fa-trash",
                        color: "orange"
                    }, {
                        id: 2,
                        title: this.IntlString("APP_MESSAGE_ERASE_ALL_CONVERSATIONS"),
                        icons: "fa-trash",
                        color: "red"
                    }].concat(e.unknowContact ? [{
                        id: 7,
                        title: this.IntlString("APP_MESSAGE_SAVE_CONTACT"),
                        icons: "fa-save"
                    }] : []).concat([{
                        id: 3,
                        title: this.IntlString("CANCEL"),
                        icons: "fa-undo"
                    }])
                }).then(function(t) {
                    if (t.id === 1) {
                        n.deleteMessagesNumber({
                            num: e.number
                        })
                    } else if (t.id === 2) {
                        n.deleteAllMessages()
                    } else if (t.id === 4) {
                        n.startCall({
                            numero: e.number
                        })
                    } else if (t.id === 5) {
                        n.startCall({
                            numero: e.number
                        })
                    } else if (t.id === 6) {
                        n.$router.push({
                            name: "messages.view",
                            params: e
                        })
                    } else if (t.id === 7) {
                        n.$router.push({
                            name: "contacts.view",
                            params: {
                                id: 0,
                                number: e.number
                            }
                        })
                    }
                    n.disableList = false
                })
            },
            back: function t() {
                if (this.disableList === true) return;
                this.$router.push({
                    name: "home"
                })
            }
        }),
        computed: a()({}, n.i(o["b"])(["IntlString", "useMouse", "contacts", "messages"]), {
            messagesData: function t() {
                var e = this.messages;
                var s = this.contacts;
                var i = e.reduce(function(t, e) {
                    if (t[e["transmitter"]] === undefined) {
                        var r = {
                            noRead: 0,
                            lastMessage: 0,
                            display: e.transmitter
                        };
                        var i = s.find(function(t) {
                            return t.number === e.transmitter
                        });
                        r.unknowContact = i === undefined;
                        if (i !== undefined) {
                            r.display = i.display;
                            r.backgroundColor = i.backgroundColor || n.i(c["a"])(e.transmitter);
                            r.letter = i.letter;
                            r.icon = i.icon
                        } else {
                            r.backgroundColor = n.i(c["a"])(e.transmitter)
                        }
                        t[e["transmitter"]] = r
                    }
                    if (e.isRead === 0) {
                        t[e["transmitter"]].noRead += 1
                    }
                    if (e.time >= t[e["transmitter"]].lastMessage) {
                        t[e["transmitter"]].lastMessage = e.time;
                        t[e["transmitter"]].keyDesc = e.message
                    }
                    return t
                }, {});
                var a = [];
                r()(i).forEach(function(t) {
                    a.push({
                        display: i[t].display,
                        puce: i[t].noRead,
                        number: t,
                        lastMessage: i[t].lastMessage,
                        keyDesc: i[t].keyDesc,
                        backgroundColor: i[t].backgroundColor,
                        icon: i[t].icon,
                        letter: i[t].letter,
                        unknowContact: i[t].unknowContact
                    })
                });
                a.sort(function(t, e) {
                    return e.lastMessage - t.lastMessage
                });
                return [this.newMessageOption].concat(a)
            },
            newMessageOption: function t() {
                return {
                    backgroundColor: "#C0C0C0",
                    display: this.IntlString("APP_MESSAGE_NEW_MESSAGE"),
                    letter: "+",
                    id: -1
                }
            }
        }),
        created: function t() {
            this.$bus.$on("keyUpBackspace", this.back)
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpBackspace", this.back)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(8);
    var r = n.n(s);
    var i = n(7);
    var a = n.n(i);
    var o = n(32);
    var c = n.n(o);
    var u = n(3);
    var l = n.n(u);
    var f = n(4);
    var h = n(14);
    var p = n.n(h);
    var d = n(11);
    var v = n(21);
    e["default"] = {
        components: {
            PhoneTitle: p.a
        },
        data: function t() {
            return {
                ignoreControls: false,
                currentSelect: 0
            }
        },
        computed: l()({}, n.i(f["b"])(["IntlString", "useMouse", "myPhoneNumber", "backgroundLabel", "coqueLabel", "ringtoneLabel", "zoom", "config", "volume", "availableLanguages", "dnd", "setDND", "dndText"]), {
            paramList: function t() {
                var e = this.IntlString("CANCEL");
                var n = this.IntlString("APP_CONFIG_RESET_CONFIRM");
                var s = {};
                var r = {};
                s[e] = "cancel";
                r[n] = "accept";
                return [{
                    icons: "fa-phone",
                    title: this.IntlString("APP_CONFIG_MY_MUNBER"),
                    value: this.myPhoneNumber
                }, {
                    icons: "fa-bell-o",
                    title: "Do Not Disturb",
                    value: this.dnd,
                    values: {
                        Enabled: true,
                        Disabled: false
                    },
                    onValid: "setDoNotDisturb"
                }, {
                    icons: "fa-picture-o",
                    title: this.IntlString("APP_CONFIG_WALLPAPER"),
                    value: this.backgroundLabel,
                    onValid: "onChangeBackground",
                    values: this.config.background
                }, {
                    icons: "fa-bell-o",
                    title: this.IntlString("APP_CONFIG_SOUND"),
                    value: this.ringtoneLabel,
                    onValid: "onChangeringtone",
                    values: this.config.ringtone
                }, {
                    icons: "fa-search",
                    title: this.IntlString("APP_CONFIG_ZOOM"),
                    value: this.zoom,
                    onValid: "setZoom",
                    onLeft: this.ajustZoom(-1),
                    onRight: this.ajustZoom(1),
                    values: {
                        "125 %": "125%",
                        "100 %": "100%",
                        "80 %": "80%",
                        "75 %": "75%",
                        "70 %": "70%",
                        "60 %": "60%",
                        "40 %": "40%",
                        "20 %": "20%"
                    }
                }, {
                    icons: "fa-volume-down",
                    title: this.IntlString("APP_CONFIG_VOLUME"),
                    value: this.valumeDisplay,
                    onValid: "setPhoneVolume",
                    onLeft: this.ajustVolume(-.01),
                    onRight: this.ajustVolume(.01),
                    values: {
                        "100 %": 1,
                        "80 %": .8,
                        "75 %": .75,
                        "70 %": .7,
                        "60 %": .6,
                        "40 %": .4,
                        "20 %": .2,
                        "0 %": 0
                    }
                }, {
                    icons: "fa-mouse-pointer",
                    title: this.IntlString("APP_CONFIG_MOUSE_SUPPORT"),
                    onValid: "onChangeMouseSupport",
                    values: l()({
                        Yes: true,
                        No: false
                    }, s)
                }, {
                    icons: "fa-exclamation-triangle",
                    color: "#ee3838",
                    title: this.IntlString("APP_CONFIG_RESET"),
                    onValid: "resetPhone",
                    values: l()({}, r, s)
                }]
            },
            valumeDisplay: function t() {
                return Math.floor(this.volume * 100) + " %"
            }
        }),
        methods: l()({}, n.i(f["a"])(["getIntlString", "setZoon", "setBackground", "setCoque", "setringtone", "setVolume", "setLanguage", "setMouseSupport", "setDND"]), {
            scrollIntoViewIfNeeded: function t() {
                this.$nextTick(function() {
                    document.querySelector(".select").scrollIntoViewIfNeeded()
                })
            },
            onBackspace: function t() {
                if (this.ignoreControls === true) return;
                this.$router.push({
                    name: "home"
                })
            },
            onUp: function t() {
                if (this.ignoreControls === true) return;
                this.currentSelect = this.currentSelect === 0 ? 0 : this.currentSelect - 1;
                this.scrollIntoViewIfNeeded()
            },
            onDown: function t() {
                if (this.ignoreControls === true) return;
                this.currentSelect = this.currentSelect === this.paramList.length - 1 ? this.currentSelect : this.currentSelect + 1;
                this.scrollIntoViewIfNeeded()
            },
            onRight: function t() {
                if (this.ignoreControls === true) return;
                var e = this.paramList[this.currentSelect];
                if (e.onRight !== undefined) {
                    e.onRight(e)
                }
            },
            onLeft: function t() {
                if (this.ignoreControls === true) return;
                var e = this.paramList[this.currentSelect];
                if (e.onLeft !== undefined) {
                    e.onLeft(e)
                }
            },
            actionItem: function t(e) {
                var n = this;
                if (e.values !== undefined) {
                    this.ignoreControls = true;
                    var s = c()(e.values).map(function(t) {
                        return {
                            title: t,
                            value: e.values[t],
                            picto: e.values[t]
                        }
                    });
                    d["a"].CreateModal({
                        choix: s
                    }).then(function(t) {
                        n.ignoreControls = false;
                        if (t.title === "cancel") return;
                        n[e.onValid](e, t)
                    })
                }
            },
            onPressItem: function t(e) {
                this.actionItem(this.paramList[e])
            },
            onEnter: function t() {
                if (this.ignoreControls === true) return;
                this.actionItem(this.paramList[this.currentSelect])
            },
            onChangeBackground: function t(e, n) {
                var s = this;
                return a()(r.a.mark(function t() {
                    var e;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    e = n.value;
                                    if (e === "URL") {
                                        s.ignoreControls = true;
                                        d["a"].CreateTextModal({
                                            text: "https://i.imgur.com/"
                                        }).then(function(t) {
                                            if (t.text !== "" && t.text !== undefined && t.text !== null && t.text !== "https://i.imgur.com/") {
                                                s.setBackground({
                                                    label: "Custom",
                                                    value: t.text
                                                })
                                            }
                                        }).finally(function() {
                                            s.ignoreControls = false
                                        })
                                    } else {
                                        s.setBackground({
                                            label: n.title,
                                            value: n.value
                                        })
                                    }
                                case 2:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, s)
                }))()
            },
            onChangeCoque: function t(e, n) {
                this.setCoque({
                    label: n.title,
                    value: n.value
                })
            },
            onChangeringtone: function t(e, n) {
                var s = this;
                var r = n.value;
                if (r === "URL") {
                    this.ignoreControls = true;
                    d["a"].CreateTextModal({
                        text: ""
                    }).then(function(t) {
                        if (t.text !== "" && t.text !== undefined && t.text !== null && t.text !== "https://i.imgur.com/") {
                            s.setringtone({
                                label: "Custom",
                                value: t.text
                            })
                        }
                    }).finally(function() {
                        s.ignoreControls = false
                    })
                } else {
                    this.setringtone({
                        label: n.title,
                        value: n.value
                    })
                }
            },
            setZoom: function t(e, n) {
                this.setZoon(n.value)
            },
            ajustZoom: function t(e) {
                var n = this;
                return function() {
                    var t = Math.max(10, (parseInt(n.zoom) || 100) + e);
                    n.setZoon(t + "%")
                }
            },
            setPhoneVolume: function t(e, n) {
                this.setVolume(n.value)
            },
            ajustVolume: function t(e) {
                var n = this;
                return function() {
                    var t = Math.max(0, Math.min(1, parseFloat(n.volume) + e));
                    n.setVolume(t)
                }
            },
            onChangeLanguages: function t(e, n) {
                if (n.value !== "cancel") {
                    this.setLanguage(n.value)
                }
            },
            onChangeMouseSupport: function t(e, n) {
                if (n.value !== "cancel") {
                    this.setMouseSupport(n.value);
                    this.onBackspace()
                }
            },
            resetPhone: function t(e, n) {
                var s = this;
                if (n.value !== "cancel") {
                    this.ignoreControls = true;
                    var r = this.IntlString("CANCEL");
                    var i = this.IntlString("APP_CONFIG_RESET_CONFIRM");
                    var a = [{
                        title: r
                    }, {
                        title: r
                    }, {
                        title: i,
                        color: "red",
                        reset: true
                    }, {
                        title: r
                    }, {
                        title: r
                    }];
                    d["a"].CreateModal({
                        choix: a
                    }).then(function(t) {
                        s.ignoreControls = false;
                        if (t.reset === true) {
                            s.$phoneAPI.deleteALL()
                        }
                    })
                }
            },
            setDoNotDisturb: function t(e, n) {
                if (typeof n.value === "boolean") {
                    v["a"].dispatch("setDND", n.value)
                }
            }
        }),
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowRight", this.onRight);
                this.$bus.$on("keyUpArrowLeft", this.onLeft);
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter)
            } else {
                this.currentSelect = -1
            }
            this.$bus.$on("keyUpBackspace", this.onBackspace)
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowRight", this.onRight);
            this.$bus.$off("keyUpArrowLeft", this.onLeft);
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.onBackspace)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(8);
    var r = n.n(s);
    var i = n(7);
    var a = n.n(i);
    var o = n(3);
    var c = n.n(o);
    var u = n(201);
    var l = n.n(u);
    var f = n(4);
    var h = n(11);
    var p = l()({
        MENU: 0,
        NEW_ACCOUNT: 1,
        LOGIN: 2,
        ACCOUNT: 3,
        NOTIFICATION: 4
    });
    e["default"] = {
        components: {},
        data: function t() {
            return {
                STATES: p,
                state: p.MENU,
                localAccount: {
                    username: "",
                    password: "",
                    passwordConfirm: "",
                    avatarUrl: "https://gcphone.nyc3.cdn.digitaloceanspaces.com/default_profile.png",
                    typing: false
                },
                notification: 0,
                notificationSound: false
            }
        },
        computed: c()({}, n.i(f["b"])(["IntlString", "useMouse", "twitterUsername", "twitterPassword", "twitterAvatarUrl", "twitterNotification", "twitterNotificationSound"]), {
            isLogin: function t() {
                return this.twitterUsername !== undefined && this.twitterUsername !== ""
            },
            validAccount: function t() {
                return this.localAccount.username.length >= 4 && this.localAccount.password.length >= 6 && this.localAccount.password === this.localAccount.passwordConfirm
            }
        }),
        methods: c()({}, n.i(f["a"])(["twitterLogin", "twitterChangePassword", "twitterLogout", "twitterSetAvatar", "twitterCreateNewAccount", "setTwitterNotification", "setTwitterNotificationSound"]), {
            onUp: function t() {
                if (this.ignoreControls === true && !this.typing) return;
                var e = document.querySelector(".group.select");
                if (e === null) {
                    e = document.querySelector(".group");
                    e.classList.add("select");
                    return
                }
                while (e.previousElementSibling !== null) {
                    if (e.previousElementSibling.classList.contains("group")) {
                        break
                    }
                    e = e.previousElementSibling
                }
                if (e.previousElementSibling !== null) {
                    document.querySelectorAll(".group").forEach(function(t) {
                        t.classList.remove("select")
                    });
                    e.previousElementSibling.classList.add("select");
                    var n = e.previousElementSibling.querySelector("input");
                    if (n !== null) {
                        n.focus()
                    }
                }
            },
            onDown: function t() {
                if (this.ignoreControls === true && !this.typing) return;
                var e = document.querySelector(".group.select");
                if (e === null) {
                    e = document.querySelector(".group");
                    e.classList.add("select");
                    return
                }
                while (e.nextElementSibling !== null) {
                    if (e.nextElementSibling.classList.contains("group")) {
                        break
                    }
                    e = e.nextElementSibling
                }
                if (e.nextElementSibling !== null) {
                    document.querySelectorAll(".group").forEach(function(t) {
                        t.classList.remove("select")
                    });
                    e.nextElementSibling.classList.add("select");
                    var n = e.nextElementSibling.querySelector("input");
                    if (n !== null) {
                        n.focus()
                    }
                }
            },
            onEnter: function t() {
                var e = this;
                if (this.ignoreControls === true && !this.typing) return;
                var n = document.querySelector(".group.select");
                if (n === null) return;
                if (n.dataset !== null) {
                    if (n.dataset.type === "text") {
                        var s = n.querySelector("input");
                        this.$phoneAPI.setFocus(true).then(function(t) {
                            e.ignoreControls = true;
                            e.typing = true
                        })
                    }
                    if (n.dataset.type === "button") {
                        n.click()
                    }
                }
            },
            onBack: function t() {
                var e = this;
                if (this.ignoreControls === true && !this.typing) return;
                if (this.localAccount.username.length === 0 && this.typing) {
                    this.typing = false;
                    return this.$phoneAPI.setFocus(false).then(function(t) {
                        e.ignoreControls = false
                    })
                }
                if (this.typing) return;
                if (this.state !== this.STATES.MENU) {
                    this.state = this.STATES.MENU
                } else {
                    this.$bus.$emit("twitterHome")
                }
            },
            setLocalAccount: function t(e, n) {
                this.localAccount[n] = e.target.value
            },
            setLocalAccountAvartarTake: function t(e) {
                var n = this;
                return a()(r.a.mark(function t() {
                    var e, s;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    r.prev = 0;
                                    r.next = 3;
                                    return n.$phoneAPI.takePhoto();
                                case 3:
                                    e = r.sent;
                                    s = e.url;
                                    if (s !== null && s !== undefined) {
                                        n.localAccount.avatarUrl = s
                                    }
                                    r.next = 10;
                                    break;
                                case 8:
                                    r.prev = 8;
                                    r.t0 = r["catch"](0);
                                case 10:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, n, [
                        [0, 8]
                    ])
                }))()
            },
            setLocalAccountAvartar: function t(e) {
                var n = this;
                return a()(r.a.mark(function t() {
                    var e;
                    return r.a.wrap(function t(s) {
                        while (1) {
                            switch (s.prev = s.next) {
                                case 0:
                                    s.prev = 0;
                                    s.next = 3;
                                    return h["a"].CreateTextModal({
                                        text: n.twitterAvatarUrl || "https://i.imgur.com/"
                                    });
                                case 3:
                                    e = s.sent;
                                    n.localAccount.avatarUrl = e.text;
                                    s.next = 9;
                                    break;
                                case 7:
                                    s.prev = 7;
                                    s.t0 = s["catch"](0);
                                case 9:
                                case "end":
                                    return s.stop()
                            }
                        }
                    }, t, n, [
                        [0, 7]
                    ])
                }))()
            },
            onPressChangeAvartartake: function t() {
                var e = this;
                return a()(r.a.mark(function t() {
                    var n, s;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    r.prev = 0;
                                    r.next = 3;
                                    return e.$phoneAPI.takePhoto();
                                case 3:
                                    n = r.sent;
                                    s = n.url;
                                    if (s !== null && s !== undefined) {
                                        e.twitterSetAvatar({
                                            avatarUrl: s
                                        })
                                    }
                                    r.next = 10;
                                    break;
                                case 8:
                                    r.prev = 8;
                                    r.t0 = r["catch"](0);
                                case 10:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, e, [
                        [0, 8]
                    ])
                }))()
            },
            onPressChangeAvartar: function t() {
                var e = this;
                return a()(r.a.mark(function t() {
                    var n;
                    return r.a.wrap(function t(s) {
                        while (1) {
                            switch (s.prev = s.next) {
                                case 0:
                                    s.prev = 0;
                                    s.next = 3;
                                    return h["a"].CreateTextModal({
                                        text: e.twitterAvatarUrl || "https://i.imgur.com/"
                                    });
                                case 3:
                                    n = s.sent;
                                    e.twitterSetAvatar({
                                        avatarUrl: n.text
                                    });
                                    s.next = 9;
                                    break;
                                case 7:
                                    s.prev = 7;
                                    s.t0 = s["catch"](0);
                                case 9:
                                case "end":
                                    return s.stop()
                            }
                        }
                    }, t, e, [
                        [0, 7]
                    ])
                }))()
            },
            login: function t() {
                this.twitterLogin({
                    username: this.localAccount.username,
                    password: this.localAccount.password
                });
                this.state = p.MENU
            },
            logout: function t() {
                this.twitterLogout()
            },
            createAccount: function t() {
                if (this.validAccount === true) {
                    this.twitterCreateNewAccount(this.localAccount);
                    this.localAccount = {
                        username: "",
                        password: "",
                        passwordConfirm: "",
                        avatarUrl: null
                    };
                    this.state = this.STATES.MENU
                }
            },
            cancel: function t() {
                this.state = p.MENU
            },
            setNotification: function t(e) {
                this.setTwitterNotification(e)
            },
            setNotificationSound: function t(e) {
                this.setTwitterNotificationSound(e)
            },
            changePassword: function t(e) {
                var n = this;
                return a()(r.a.mark(function t() {
                    var e, s;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    r.prev = 0;
                                    r.next = 3;
                                    return h["a"].CreateTextModal({
                                        limit: 30
                                    });
                                case 3:
                                    e = r.sent;
                                    if (!(e.text === "")) {
                                        r.next = 6;
                                        break
                                    }
                                    return r.abrupt("return");
                                case 6:
                                    r.next = 8;
                                    return h["a"].CreateTextModal({
                                        limit: 30
                                    });
                                case 8:
                                    s = r.sent;
                                    if (!(s.text === "")) {
                                        r.next = 11;
                                        break
                                    }
                                    return r.abrupt("return");
                                case 11:
                                    if (!(s.text !== e.text)) {
                                        r.next = 16;
                                        break
                                    }
                                    n.$notify({
                                        title: n.IntlString("APP_TWITTER_NAME"),
                                        message: n.IntlString("APP_TWITTER_NOTIF_NEW_PASSWORD_MISS_MATCH"),
                                        icon: "twitter",
                                        backgroundColor: "#e0245e80"
                                    });
                                    return r.abrupt("return");
                                case 16:
                                    if (!(s.text.length < 6)) {
                                        r.next = 19;
                                        break
                                    }
                                    n.$notify({
                                        title: n.IntlString("APP_TWITTER_NAME"),
                                        message: n.IntlString("APP_TWITTER_NOTIF_NEW_PASSWORD_LENGTH_ERROR"),
                                        icon: "twitter",
                                        backgroundColor: "#e0245e80"
                                    });
                                    return r.abrupt("return");
                                case 19:
                                    n.twitterChangePassword(s.text);
                                    r.next = 25;
                                    break;
                                case 22:
                                    r.prev = 22;
                                    r.t0 = r["catch"](0);
                                    console.error(r.t0);
                                case 25:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, n, [
                        [0, 22]
                    ])
                }))()
            }
        }),
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter);
                this.$bus.$on("keyUpBackspace", this.onBack)
            }
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.onBack)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(8);
    var r = n.n(s);
    var i = n(7);
    var a = n.n(i);
    var o = n(3);
    var c = n.n(o);
    var u = n(4);
    e["default"] = {
        components: {},
        data: function t() {
            return {
                message: "",
                writing_tweet: false,
                selectedButton: false,
                down: false
            }
        },
        computed: c()({}, n.i(u["b"])(["IntlString", "useMouse"])),
        watch: {},
        methods: c()({}, n.i(u["a"])(["twitterPostTweet"]), {
            onEnter: function t() {
                var e = this;
                return a()(r.a.mark(function t() {
                    return r.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    try {
                                        if (e.selectedButton === false) {
                                            e.$phoneAPI.setFocus(true).then(function(t) {
                                                e.ignoreControls = true;
                                                e.writing_tweet = true
                                            })
                                        }
                                        if (e.selectedButton) {
                                            e.tweeter();
                                            e.$phoneAPI.setFocus(false).then(function(t) {
                                                e.ignoreControls = false
                                            })
                                        }
                                    } catch (t) {}
                                case 1:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, e)
                }))()
            },
            tweeter: function t() {
                var e = this;
                return a()(r.a.mark(function t() {
                    return r.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    if (!(e.message === "")) {
                                        n.next = 2;
                                        break
                                    }
                                    return n.abrupt("return");
                                case 2:
                                    n.next = 4;
                                    return e.twitterPostTweet({
                                        message: e.message
                                    });
                                case 4:
                                    e.message = "";
                                case 5:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, e)
                }))()
            },
            onBack: function t() {
                var e = this;
                if (this.message === "" && this.writing_tweet === true) {
                    this.$phoneAPI.setFocus(false).then(function(t) {
                        e.ignoreControls = false
                    });
                    setTimeout(function() {
                        e.writing_tweet = false
                    }, 1e3)
                }
                if (this.ignoreControls === true) return;
                if (this.useMouse === true && document.activeElement.tagName !== "BODY") return;
                this.$bus.$emit("twitterHome")
            },
            onUp: function t() {
                this.selectedButton = false
            },
            onDown: function t() {
                var e = this;
                if (this.down) return;
                this.down = true;
                var n = !this.selectedButton;
                this.selectedButton = n;
                this.$phoneAPI.setFocus(false).then(function(t) {
                    e.ignoreControls = false
                });
                setTimeout(function() {
                    e.down = false
                }, 500)
            }
        }),
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpEnter", this.onEnter);
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp)
            }
            this.$bus.$on("keyUpBackspace", this.onBack)
        },
        mounted: function t() {
            var e = this;
            return a()(r.a.mark(function t() {
                return r.a.wrap(function t(e) {
                    while (1) {
                        switch (e.prev = e.next) {
                            case 0:
                            case "end":
                                return e.stop()
                        }
                    }
                }, t, e)
            }))()
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpBackspace", this.onBack);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpArrowUp", this.onUp)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(3);
    var r = n.n(s);
    var i = n(14);
    var a = n.n(i);
    var o = n(316);
    var c = n.n(o);
    var u = n(312);
    var l = n.n(u);
    var f = n(311);
    var h = n.n(f);
    var p = n(315);
    var d = n.n(p);
    var v = n(4);
    e["default"] = {
        components: {
            PhoneTitle: a.a
        },
        data: function t() {
            return {
                currentScreenIndex: 0
            }
        },
        computed: r()({}, n.i(v["b"])(["IntlString", "useMouse"]), {
            screen: function t() {
                return [{
                    title: this.IntlString("APP_TWITTER_VIEW_TWITTER"),
                    component: c.a,
                    icon: "fa-home"
                }, {
                    title: this.IntlString("APP_TWITTER_VIEW_TOP_TWEETS"),
                    component: d.a,
                    icon: "fa-heart"
                }, {
                    title: this.IntlString("APP_TWITTER_VIEW_TWEETER"),
                    component: l.a,
                    icon: " fa-comment-o"
                }, {
                    title: this.IntlString("APP_TWITTER_VIEW_SETTING"),
                    component: h.a,
                    icon: "fa-cog"
                }]
            },
            currentScreen: function t() {
                return this.screen[this.currentScreenIndex]
            }
        }),
        watch: {},
        methods: {
            onLeft: function t() {
                this.currentScreenIndex = Math.max(0, this.currentScreenIndex - 1)
            },
            onRight: function t() {
                this.currentScreenIndex = Math.min(this.screen.length - 1, this.currentScreenIndex + 1)
            },
            home: function t() {
                this.currentScreenIndex = 0
            },
            openMenu: function t(e) {
                this.currentScreenIndex = e
            },
            quit: function t() {
                if (this.currentScreenIndex === 0) {
                    this.$router.push({
                        name: "home"
                    })
                } else {
                    this.currentScreenIndex = 0
                }
            }
        },
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowLeft", this.onLeft);
                this.$bus.$on("keyUpArrowRight", this.onRight)
            }
            this.$bus.$on("twitterHome", this.home)
        },
        mounted: function t() {},
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowLeft", this.onLeft);
            this.$bus.$off("keyUpArrowRight", this.onRight);
            this.$bus.$off("twitterHome", this.home)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    e["default"] = {
        created: function t() {
            var e = this;
            setTimeout(function() {
                e.$router.push({
                    name: "twitter.screen"
                })
            }, 500)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(8);
    var r = n.n(s);
    var i = n(16);
    var a = n.n(i);
    var o = n(7);
    var c = n.n(o);
    var u = n(3);
    var l = n.n(u);
    var f = n(4);
    var h = n(11);
    e["default"] = {
        components: {},
        data: function t() {
            return {
                selectMessage: -1,
                ignoreControls: false,
                imgZoom: undefined
            }
        },
        computed: l()({}, n.i(f["b"])(["favoriteTweets", "IntlString", "useMouse"]), {
            tweets: function t() {
                return this.favoriteTweets
            }
        }),
        watch: {},
        methods: l()({}, n.i(f["a"])(["twitterLogin", "twitterPostTweet", "twitterToogleLike", "fetchFavoriteTweets"]), {
            showOption: function t() {
                var e = this;
                return c()(r.a.mark(function t() {
                    var n, s, i;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    e.ignoreControls = true;
                                    n = e.tweets[e.selectMessage];
                                    s = [{
                                        id: 1,
                                        title: "Like / Unlike",
                                        icons: "fa-heart"
                                    }, {
                                        id: 2,
                                        title: "Répondre",
                                        icons: "fa-reply"
                                    }, {
                                        id: -1,
                                        title: e.IntlString("CANCEL"),
                                        icons: "fa-undo"
                                    }];
                                    if (e.isImage(n.message)) {
                                        s = [{
                                            id: 3,
                                            title: e.IntlString("APP_MESSAGE_ZOOM_IMG"),
                                            icons: "fa-search"
                                        }].concat(a()(s))
                                    }
                                    r.next = 6;
                                    return h["a"].CreateModal({
                                        choix: s
                                    });
                                case 6:
                                    i = r.sent;
                                    e.ignoreControls = false;
                                    r.t0 = i.id;
                                    r.next = r.t0 === 1 ? 11 : r.t0 === 2 ? 13 : r.t0 === 3 ? 15 : 17;
                                    break;
                                case 11:
                                    e.twitterToogleLike({
                                        tweetId: n.id
                                    });
                                    return r.abrupt("break", 17);
                                case 13:
                                    e.reply(n);
                                    return r.abrupt("break", 17);
                                case 15:
                                    e.imgZoom = n.message;
                                    return r.abrupt("break", 17);
                                case 17:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, e)
                }))()
            },
            isImage: function t(e) {
                return /^https?:\/\/.*\.(png|jpg|jpeg|gif)/.test(e)
            },
            reply: function t(e) {
                var n = this;
                return c()(r.a.mark(function t() {
                    var s, i, a;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    s = e.author;
                                    r.prev = 1;
                                    n.ignoreControls = true;
                                    r.next = 5;
                                    return h["a"].CreateTextModal({
                                        title: "Répondre",
                                        text: "@" + s + " "
                                    });
                                case 5:
                                    i = r.sent;
                                    if (i !== undefined && i.text !== undefined) {
                                        a = i.text.trim();
                                        if (a.length !== 0) {
                                            n.twitterPostTweet({
                                                message: a
                                            })
                                        }
                                    }
                                    r.next = 11;
                                    break;
                                case 9:
                                    r.prev = 9;
                                    r.t0 = r["catch"](1);
                                case 11:
                                    r.prev = 11;
                                    n.ignoreControls = false;
                                    return r.finish(11);
                                case 14:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, n, [
                        [1, 9, 11, 14]
                    ])
                }))()
            },
            resetScroll: function t() {
                var e = this;
                this.$nextTick(function() {
                    var t = document.querySelector("#tweets");
                    t.scrollTop = t.scrollHeight;
                    e.selectMessage = -1
                })
            },
            scrollIntoViewIfNeeded: function t() {
                var e = this;
                this.$nextTick(function() {
                    var t = e.$el.querySelector(".select");
                    if (t !== null) {
                        t.scrollIntoViewIfNeeded()
                    }
                })
            },
            onUp: function t() {
                if (this.ignoreControls === true) return;
                if (this.selectMessage === -1) {
                    this.selectMessage = 0
                } else {
                    this.selectMessage = this.selectMessage === 0 ? 0 : this.selectMessage - 1
                }
                this.scrollIntoViewIfNeeded()
            },
            onDown: function t() {
                if (this.ignoreControls === true) return;
                if (this.selectMessage === -1) {
                    this.selectMessage = 0
                } else {
                    this.selectMessage = this.selectMessage === this.tweets.length - 1 ? this.selectMessage : this.selectMessage + 1
                }
                this.scrollIntoViewIfNeeded()
            },
            onEnter: function t() {
                var e = this;
                return c()(r.a.mark(function t() {
                    return r.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    if (!(e.ignoreControls === true)) {
                                        n.next = 2;
                                        break
                                    }
                                    return n.abrupt("return");
                                case 2:
                                    if (e.selectMessage === -1) {
                                        e.newTweet()
                                    } else {
                                        e.showOption()
                                    }
                                case 3:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, e)
                }))()
            },
            onBack: function t() {
                if (this.imgZoom !== undefined) {
                    this.imgZoom = undefined;
                    return
                }
                if (this.ignoreControls === true) return;
                if (this.selectMessage !== -1) {
                    this.selectMessage = -1
                } else {
                    this.$bus.$emit("twitterHome")
                }
            },
            formatTime: function t(e) {
                var n = new Date(e);
                return n.toLocaleTimeString()
            }
        }),
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter)
            }
            this.$bus.$on("keyUpBackspace", this.onBack)
        },
        mounted: function t() {
            this.fetchFavoriteTweets()
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.onBack)
        }
    }
}, function(t, e, n) {
    "use strict";
    Object.defineProperty(e, "__esModule", {
        value: true
    });
    var s = n(8);
    var r = n.n(s);
    var i = n(16);
    var a = n.n(i);
    var o = n(7);
    var c = n.n(o);
    var u = n(3);
    var l = n.n(u);
    var f = n(4);
    var h = n(11);
    e["default"] = {
        components: {},
        data: function t() {
            return {
                selectMessage: -1,
                ignoreControls: false,
                imgZoom: undefined
            }
        },
        computed: l()({}, n.i(f["b"])(["tweets", "IntlString", "useMouse"])),
        watch: {},
        methods: l()({}, n.i(f["a"])(["twitterLogin", "twitterPostTweet", "twitterToogleLike", "fetchTweets"]), {
            showOption: function t() {
                var e = this;
                return c()(r.a.mark(function t() {
                    var n, s, i;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    e.ignoreControls = true;
                                    n = e.tweets[e.selectMessage];
                                    s = [{
                                        id: 1,
                                        title: "Like / Unlike",
                                        icons: "fa-heart"
                                    }, {
                                        id: 2,
                                        title: "Reply",
                                        icons: "fa-reply"
                                    }, {
                                        id: -1,
                                        title: e.IntlString("CANCEL"),
                                        icons: "fa-undo"
                                    }];
                                    if (e.isImage(n.message)) {
                                        s = [{
                                            id: 3,
                                            title: e.IntlString("APP_MESSAGE_ZOOM_IMG"),
                                            icons: "fa-search"
                                        }].concat(a()(s))
                                    }
                                    r.next = 6;
                                    return h["a"].CreateModal({
                                        choix: s
                                    });
                                case 6:
                                    i = r.sent;
                                    e.ignoreControls = false;
                                    r.t0 = i.id;
                                    r.next = r.t0 === 1 ? 11 : r.t0 === 2 ? 13 : r.t0 === 3 ? 15 : 17;
                                    break;
                                case 11:
                                    e.twitterToogleLike({
                                        tweetId: n.id
                                    });
                                    return r.abrupt("break", 17);
                                case 13:
                                    e.reply(n);
                                    return r.abrupt("break", 17);
                                case 15:
                                    e.imgZoom = n.message;
                                    return r.abrupt("break", 17);
                                case 17:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, e)
                }))()
            },
            isImage: function t(e) {
                return /^https?:\/\/.*\.(png|jpg|jpeg|gif)/.test(e)
            },
            reply: function t(e) {
                var n = this;
                return c()(r.a.mark(function t() {
                    var s, i, a;
                    return r.a.wrap(function t(r) {
                        while (1) {
                            switch (r.prev = r.next) {
                                case 0:
                                    s = e.author;
                                    r.prev = 1;
                                    n.ignoreControls = true;
                                    r.next = 5;
                                    return h["a"].CreateTextModal({
                                        title: "Répondre",
                                        text: "@" + s + " "
                                    });
                                case 5:
                                    i = r.sent;
                                    if (i !== undefined && i.text !== undefined) {
                                        a = i.text.trim();
                                        if (a.length !== 0) {
                                            n.twitterPostTweet({
                                                message: a
                                            })
                                        }
                                    }
                                    r.next = 11;
                                    break;
                                case 9:
                                    r.prev = 9;
                                    r.t0 = r["catch"](1);
                                case 11:
                                    r.prev = 11;
                                    n.ignoreControls = false;
                                    return r.finish(11);
                                case 14:
                                case "end":
                                    return r.stop()
                            }
                        }
                    }, t, n, [
                        [1, 9, 11, 14]
                    ])
                }))()
            },
            resetScroll: function t() {
                var e = this;
                this.$nextTick(function() {
                    var t = document.querySelector("#tweets");
                    t.scrollTop = t.scrollHeight;
                    e.selectMessage = -1
                })
            },
            scrollIntoViewIfNeeded: function t() {
                var e = this;
                this.$nextTick(function() {
                    var t = e.$el.querySelector(".select");
                    if (t !== null) {
                        t.scrollIntoViewIfNeeded()
                    }
                })
            },
            onUp: function t() {
                if (this.ignoreControls === true) return;
                if (this.selectMessage === -1) {
                    this.selectMessage = 0
                } else {
                    this.selectMessage = this.selectMessage === 0 ? 0 : this.selectMessage - 1
                }
                this.scrollIntoViewIfNeeded()
            },
            onDown: function t() {
                if (this.ignoreControls === true) return;
                if (this.selectMessage === -1) {
                    this.selectMessage = 0
                } else {
                    this.selectMessage = this.selectMessage === this.tweets.length - 1 ? this.selectMessage : this.selectMessage + 1
                }
                this.scrollIntoViewIfNeeded()
            },
            onEnter: function t() {
                var e = this;
                return c()(r.a.mark(function t() {
                    return r.a.wrap(function t(n) {
                        while (1) {
                            switch (n.prev = n.next) {
                                case 0:
                                    if (!(e.ignoreControls === true)) {
                                        n.next = 2;
                                        break
                                    }
                                    return n.abrupt("return");
                                case 2:
                                    if (e.selectMessage === -1) {
                                        e.newTweet()
                                    } else {
                                        e.showOption()
                                    }
                                case 3:
                                case "end":
                                    return n.stop()
                            }
                        }
                    }, t, e)
                }))()
            },
            onBack: function t() {
                if (this.imgZoom !== undefined) {
                    this.imgZoom = undefined;
                    return
                }
                if (this.ignoreControls === true) return;
                if (this.selectMessage !== -1) {
                    this.selectMessage = -1
                } else {
                    this.$router.push({
                        name: "home"
                    })
                }
            },
            formatTime: function t(e) {
                var n = new Date(e);
                return n.toLocaleTimeString()
            }
        }),
        created: function t() {
            if (!this.useMouse) {
                this.$bus.$on("keyUpArrowDown", this.onDown);
                this.$bus.$on("keyUpArrowUp", this.onUp);
                this.$bus.$on("keyUpEnter", this.onEnter)
            }
            this.$bus.$on("keyUpBackspace", this.onBack)
        },
        mounted: function t() {
            this.fetchTweets()
        },
        beforeDestroy: function t() {
            this.$bus.$off("keyUpArrowDown", this.onDown);
            this.$bus.$off("keyUpArrowUp", this.onUp);
            this.$bus.$off("keyUpEnter", this.onEnter);
            this.$bus.$off("keyUpBackspace", this.onBack)
        }
    }
}, , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, function(t, e) {}, , , , , , function(t, e, n) {
    function s(t) {
        n(269)
    }
    var r = n(1)(n(165), n(337), s, "data-v-64f456c2", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(273)
    }
    var r = n(1)(n(166), n(341), s, "data-v-821f15d4", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(280)
    }
    var r = n(1)(n(167), n(348), s, "data-v-e5131126", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(254)
    }
    var r = n(1)(n(168), n(322), s, "data-v-235696e8", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(252)
    }
    var r = n(1)(n(171), n(320), s, "data-v-1c547768", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(270)
    }
    var r = n(1)(n(172), n(338), s, "data-v-6cc9c1b2", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(251)
    }
    var r = n(1)(n(173), n(319), s, "data-v-17cee085", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(256)
    }
    var r = n(1)(n(174), n(324), s, "data-v-2cbc2b79", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(258)
    }
    var r = n(1)(n(175), n(326), s, "data-v-2f4ae706", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(253)
    }
    var r = n(1)(n(177), n(321), s, "data-v-20074174", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(281)
    }
    var r = n(1)(n(178), n(349), s, "data-v-f183d6cc", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(259)
    }
    var r = n(1)(n(179), n(327), s, "data-v-317a0f32", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(274)
    }
    var r = n(1)(n(180), n(342), s, "data-v-a6352176", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(250)
    }
    var r = n(1)(n(181), n(318), s, "data-v-13ecd146", null);
    t.exports = r.exports
}, function(t, e, n) {
    var s = n(1)(n(182), null, null, null, null);
    t.exports = s.exports
}, function(t, e, n) {
    function s(t) {
        n(275)
    }
    var r = n(1)(n(183), n(343), s, "data-v-a81d7b90", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(268)
    }
    var r = n(1)(n(184), n(336), s, "data-v-61da367d", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(279)
    }
    var r = n(1)(n(185), n(347), s, "data-v-e492be16", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(257)
    }
    var r = n(1)(n(186), n(325), s, "data-v-2e18afa6", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(260)
    }
    var r = n(1)(n(187), n(328), s, "data-v-392cfe96", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(262)
    }
    var r = n(1)(n(188), n(330), s, "data-v-3bd73f1c", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(277)
    }
    var r = n(1)(n(189), n(345), s, "data-v-d7a21294", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(264)
    }
    var r = n(1)(n(190), n(332), s, "data-v-48096518", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(263)
    }
    var r = n(1)(n(191), n(331), s, "data-v-417a4896", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(266)
    }
    var r = n(1)(n(192), n(334), s, "data-v-4f9e50c2", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(271)
    }
    var r = n(1)(n(193), n(339), s, "data-v-7163c2ba", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(276)
    }
    var r = n(1)(n(194), n(344), s, "data-v-bbe95f2c", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(249)
    }
    var r = n(1)(n(195), n(317), s, "data-v-0ff47592", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(267)
    }
    var r = n(1)(n(196), n(335), s, "data-v-5d20189a", null);
    t.exports = r.exports
}, function(t, e, n) {
    function s(t) {
        n(265)
    }
    var r = n(1)(n(197), n(333), s, "data-v-48f6b0ba", null);
    t.exports = r.exports
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return t._m(0)
        },
        staticRenderFns: [function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "splash",
                staticStyle: {
                    width: "326px",
                    height: "743px"
                }
            }, [n("img", {
                attrs: {
                    src: "/html/static/img/twitter/bird.png"
                }
            })])
        }]
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_app"
            }, [n("PhoneTitle", {
                attrs: {
                    title: t.IntlString("APP_PHONE_TITLE")
                },
                on: {
                    back: t.quit
                }
            }), t._v(" "), n("div", {
                staticClass: "content"
            }, [n("div", {
                staticClass: "number"
            }, [t._v("\n     " + t._s(t.numeroFormat) + "\n     "), n("span", {
                staticClass: "deleteNumber",
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.deleteNumber.apply(null, arguments)
                    }
                }
            })]), t._v(" "), n("div", {
                staticClass: "keyboard"
            }, t._l(t.keyInfo, function(e, s) {
                return n("div", {
                    key: e.primary,
                    staticClass: "key",
                    class: {
                        "key-select": s === t.keySelect,
                        keySpe: e.isNotNumber === true
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.onPressKey(e)
                        }
                    }
                }, [n("span", {
                    staticClass: "key-primary",
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.onPressKey(e)
                        }
                    }
                }, [t._v(t._s(e.primary))]), t._v(" "), n("span", {
                    staticClass: "key-secondary",
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.onPressKey(e)
                        }
                    }
                }, [t._v(t._s(e.secondary))])])
            }), 0), t._v(" "), n("div", {
                staticClass: "call"
            }, [n("div", {
                staticClass: "call-btn",
                class: {
                    active: t.keySelect === 12
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.onPressCall.apply(null, arguments)
                    }
                }
            }, [n("svg", {
                attrs: {
                    viewBox: "0 0 24 24"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.onPressCall.apply(null, arguments)
                    }
                }
            }, [n("g", {
                attrs: {
                    transform: "rotate(0, 12, 12)"
                }
            }, [n("path", {
                attrs: {
                    d: "M6.62,10.79C8.06,13.62 10.38,15.94 13.21,17.38L15.41,15.18C15.69,14.9 16.08,14.82 16.43,14.93C17.55,15.3 18.75,15.5 20,15.5A1,1 0 0,1 21,16.5V20A1,1 0 0,1 20,21A17,17 0 0,1 3,4A1,1 0 0,1 4,3H7.5A1,1 0 0,1 8.5,4C8.5,5.25 8.7,6.45 9.07,7.57C9.18,7.92 9.1,8.31 8.82,8.59L6.62,10.79Z"
                }
            })])])])])])], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("transition", {
                attrs: {
                    name: "modal"
                }
            }, [n("div", {
                staticClass: "modal-mask"
            }, [n("div", {
                staticClass: "modal-container",
                on: {
                    click: function(t) {
                        t.stopPropagation()
                    }
                }
            }, [n("h2", {
                style: {
                    color: t.color
                }
            }, [t._v(t._s(t.title))]), t._v(" "), n("textarea", {
                directives: [{
                    name: "model",
                    rawName: "v-model",
                    value: t.inputText,
                    expression: "inputText"
                }],
                ref: "textarea",
                staticClass: "modal-textarea",
                class: {
                    oneline: t.limit <= 18
                },
                style: {
                    borderColor: t.color
                },
                attrs: {
                    maxlength: t.limit
                },
                domProps: {
                    value: t.inputText
                },
                on: {
                    input: function(e) {
                        if (e.target.composing) {
                            return
                        }
                        t.inputText = e.target.value
                    }
                }
            }), t._v(" "), n("div", {
                staticClass: "botton-container"
            }, [n("button", {
                style: {
                    color: t.color
                },
                on: {
                    click: t.cancel
                }
            }, [t._v("\r\n              " + t._s(t.IntlString("CANCEL")) + "\r\n            ")]), t._v(" "), n("button", {
                style: {
                    color: t.color
                },
                on: {
                    click: t.valide
                }
            }, [t._v("\r\n              " + t._s(t.IntlString("OK")) + "\r\n            ")])])])])])
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_app",
                staticStyle: {
                    width: "326px",
                    height: "743px"
                }
            }, [n("div", {
                staticClass: "backblur",
                staticStyle: {
                    width: "342px",
                    height: "756px"
                },
                style: {
                    background: "url(" + t.backgroundURL + ")"
                }
            }), t._v(" "), n("InfoBare", {
                staticClass: "infobare"
            }), t._v(" "), n("div", {
                staticClass: "menu",
                on: {
                    click: t.onBack
                }
            }, [n("div", {
                staticClass: "menu_content"
            }, [n("div", {
                staticClass: "menu_buttons"
            }, t._l(t.Apps, function(e, s) {
                return n("button", {
                    key: e.name,
                    staticClass: "letra",
                    class: {
                        select: s === t.currentSelect
                    },
                    style: {
                        backgroundImage: "url(" + e.icons + ")"
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.openApp(e)
                        }
                    }
                }, [t._v("\n              " + t._s(e.intlName) + "\n              "), e.puce !== undefined && e.puce !== 0 ? n("span", {
                    staticClass: "puce"
                }, [t._v(t._s(e.puce))]) : t._e()])
            }), 0)])])], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_app",
                staticStyle: {
                    width: "326px",
                    height: "743px"
                }
            }, [n("PhoneTitle", {
                attrs: {
                    title: t.IntlString("APP_PHONE_TITLE")
                },
                on: {
                    back: t.onBackspace
                }
            }), t._v(" "), n("div", {
                staticClass: "content"
            }, [n(t.subMenu[t.currentMenuIndex].Comp, {
                tag: "component"
            })], 1), t._v(" "), n("div", {
                staticClass: "subMenu"
            }, t._l(t.subMenu, function(e, s) {
                return n("div", {
                    key: s,
                    staticClass: "subMenu-elem",
                    style: t.getColorItem(s),
                    on: {
                        click: function(e) {
                            return t.swapMenu(s)
                        }
                    }
                }, [n("i", {
                    staticClass: "subMenu-icon fa",
                    class: ["fa-" + e.icon],
                    on: {
                        click: function(e) {
                            e.stopPropagation();
                            return t.swapMenu(s)
                        }
                    }
                }), t._v(" "), n("span", {
                    staticClass: "subMenu-name",
                    on: {
                        click: function(e) {
                            e.stopPropagation();
                            return t.swapMenu(s)
                        }
                    }
                }, [t._v(t._s(e.name))])])
            }), 0)], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "home",
                staticStyle: {
                    width: "326px",
                    height: "743px"
                },
                style: {
                    background: "url(" + t.backgroundURL + ")"
                }
            }, [n("InfoBare"), t._v(" "), t.messages.length >= t.warningMessageCount ? n("span", {
                staticClass: "warningMess"
            }, [t._m(0), t._v(" "), n("span", {
                staticClass: "warningMess_content"
            }, [n("span", {
                staticClass: "warningMess_title"
            }, [t._v(t._s(t.IntlString("PHONE_WARNING_MESSAGE")))]), n("br"), t._v(" "), n("span", {
                staticClass: "warningMess_mess"
            }, [t._v(t._s(t.messages.length) + " / " + t._s(t.warningMessageCount) + " " + t._s(t.IntlString("PHONE_WARNING_MESSAGE_MESS")))])])]) : t._e(), t._v(" "), n("div", {
                staticClass: "time"
            }), t._v(" "), n("div", {
                staticClass: "time-display"
            }, [t._v(t._s(t.timeDisplay))]), t._v(" "), n("div", {
                staticClass: "menu",
                on: {
                    click: t.onBack
                }
            }, [n("div", {
                staticClass: "menu_content"
            }, [n("div", {
                staticClass: "menu_buttons"
            }, t._l(t.Apps.filter(function(t) {
                return !t.inHomePage
            }), function(e, s) {
                return n("button", {
                    key: e.name,
                    staticClass: "letra",
                    class: {
                        select: s === t.currentSelect
                    },
                    style: {
                        backgroundImage: "url(" + e.icons + ")"
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.openApp(e)
                        },
                        keypress: function(n) {
                            if (!n.type.indexOf("key") && t._k(n.keyCode, "enter", 13, n.key, "Enter")) {
                                return null
                            }
                            return t.openApp(e)
                        }
                    }
                }, [t._v("\n              " + t._s(e.intlName) + "\n              "), e.puce !== undefined && e.puce !== 0 ? n("span", {
                    staticClass: "puce"
                }, [t._v(t._s(e.puce))]) : t._e()])
            }), 0)])]), t._v(" "), n("div", {
                staticClass: "home_buttons"
            }, t._l(t.AppsHome, function(e, s) {
                return n("button", {
                    key: e.name,
                    class: {
                        select_home: s + "_home" === t.currentSelect
                    },
                    staticStyle: {
                        top: "73px",
                        "font-family": "initial",
                        "margin-left": "10px",
                        "margin-right": "10px"
                    },
                    style: {
                        backgroundImage: "url(" + e.icons + ")"
                    },
                    on: {
                        click: function(n) {
                            return t.openApp(e)
                        },
                        keypress: function(n) {
                            if (!n.type.indexOf("key") && t._k(n.keyCode, "enter", 13, n.key, "Enter")) {
                                return null
                            }
                            return t.openApp(e)
                        }
                    }
                }, [e.puce !== undefined && e.puce !== 0 ? n("span", {
                    staticClass: "puce"
                }, [t._v(t._s(e.puce))]) : t._e()])
            }), 0)], 1)
        },
        staticRenderFns: [function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "warningMess_icon"
            }, [n("i", {
                staticClass: "fa fa-warning"
            })])
        }]
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_infoBare barre-header",
                staticStyle: {
                    width: "326px",
                    top: "4px"
                }
            }, [n("span", {
                staticClass: "reseau"
            }, [t._v(t._s(t.config.reseau))]), t._v(" "), n("span", {
                staticClass: "time"
            }, [n("current-time", {
                staticStyle: {
                    "font-size": "12px",
                    "margin-right": "7px"
                }
            })], 1), t._v(" "), n("hr", {
                staticClass: "barre1"
            }), t._v(" "), n("hr", {
                staticClass: "barre2"
            }), t._v(" "), n("hr", {
                staticClass: "barre3"
            }), t._v(" "), n("hr", {
                staticClass: "barre4"
            })])
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_app",
                staticStyle: {
                    width: "334px",
                    height: "742px",
                    color: "white"
                }
            }, [n("PhoneTitle", {
                attrs: {
                    title: t.IntlString("APP_NOTES"),
                    backgroundColor: "#f8d344",
                    color: "white"
                },
                on: {
                    back: t.onBack
                }
            }), t._v(" "), n("div", {
                staticClass: "elements",
                staticStyle: {
                    backgroundColor: "white"
                },
                on: {
                    contextmenu: function(e) {
                        e.preventDefault();
                        return t.addChannelOption.apply(null, arguments)
                    }
                }
            }, [n("div", t._l(t.notesChannels, function(e, s) {
                return n("div", {
                    key: e.channel,
                    staticClass: "elem-title",
                    class: {
                        select: s === t.currentSelect
                    }
                }, [n("h3", {
                    staticStyle: {
                        "margin-left": "7px",
                        "font-size": "16px",
                        "font-weight": "400"
                    }
                }, [t._v(" " + t._s(e.channel))])])
            }), 0)])], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_app",
                staticStyle: {
                    width: "326px",
                    height: "743px"
                }
            }, [n("PhoneTitle", {
                attrs: {
                    title: t.contact.display
                }
            }), t._v(" "), n("div", {
                staticClass: "phone_content content inputText"
            }, [n("div", {
                staticClass: "group inputText",
                attrs: {
                    "data-type": "text",
                    "data-model": "display",
                    "data-maxlength": "64"
                }
            }, [n("input", {
                directives: [{
                    name: "model",
                    rawName: "v-model",
                    value: t.contact.display,
                    expression: "contact.display"
                }],
                attrs: {
                    type: "text"
                },
                domProps: {
                    value: t.contact.display
                },
                on: {
                    input: function(e) {
                        if (e.target.composing) {
                            return
                        }
                        t.$set(t.contact, "display", e.target.value)
                    }
                }
            }), t._v(" "), n("span", {
                staticClass: "highlight"
            }), t._v(" "), n("span", {
                staticClass: "bar"
            }), t._v(" "), n("label", [t._v("Contact Name")])]), t._v(" "), n("div", {
                staticClass: "group inputText",
                attrs: {
                    "data-type": "text",
                    "data-maxlength": "16",
                    "data-model": "number"
                }
            }, [n("input", {
                directives: [{
                    name: "model",
                    rawName: "v-model",
                    value: t.contact.number,
                    expression: "contact.number"
                }],
                attrs: {
                    type: "text"
                },
                domProps: {
                    value: t.contact.number,
                    value: t.contact.number
                },
                on: {
                    input: function(e) {
                        if (e.target.composing) {
                            return
                        }
                        t.$set(t.contact, "number", e.target.value)
                    }
                }
            }), t._v(" "), n("span", {
                staticClass: "highlight"
            }), t._v(" "), n("span", {
                staticClass: "bar"
            }), t._v(" "), n("label", [t._v("Contact Number")])]), t._v(" "), n("div", {
                staticClass: "group",
                staticStyle: {
                    "margin-top": "23px",
                    width: "263px",
                    "margin-left": "23px"
                },
                attrs: {
                    "data-type": "button",
                    "data-action": "save"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.save.apply(null, arguments)
                    }
                }
            }, [n("input", {
                staticClass: "btn btn-green",
                staticStyle: {
                    "font-weight": "100"
                },
                attrs: {
                    type: "button",
                    value: t.IntlString("APP_CONTACT_SAVE")
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.save.apply(null, arguments)
                    }
                }
            })]), t._v(" "), n("div", {
                staticClass: "group",
                staticStyle: {
                    "margin-top": "23px",
                    width: "263px",
                    "margin-left": "23px"
                },
                attrs: {
                    "data-type": "button",
                    "data-action": "cancel"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.cancel.apply(null, arguments)
                    }
                }
            }, [n("input", {
                staticClass: "btn btn-red",
                staticStyle: {
                    "font-weight": "100"
                },
                attrs: {
                    type: "button",
                    value: t.IntlString("APP_CONTACT_CANCEL")
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.cancel.apply(null, arguments)
                    }
                }
            })]), t._v(" "), n("div", {
                staticClass: "group",
                staticStyle: {
                    "margin-top": "23px",
                    width: "263px",
                    "margin-left": "23px"
                },
                attrs: {
                    "data-type": "button",
                    "data-action": "deleteC"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.deleteC.apply(null, arguments)
                    }
                }
            }, [n("input", {
                staticClass: "btn btn-red",
                staticStyle: {
                    "font-weight": "100"
                },
                attrs: {
                    type: "button",
                    value: t.IntlString("APP_CONTACT_DELETE")
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.deleteC.apply(null, arguments)
                    }
                }
            })])])], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_app",
                staticStyle: {
                    width: "334px",
                    height: "742px",
                    background: "white"
                }
            }, [n("PhoneTitle", {
                attrs: {
                    title: t.channelName,
                    backgroundColor: "#f8d344"
                },
                on: {
                    back: t.onQuit
                }
            }), t._v(" "), n("div", {
                staticClass: "phone_content"
            }, [n("div", {
                ref: "elementsDiv",
                staticClass: "elements"
            }, t._l(t.notesMessages, function(e) {
                return n("div", {
                    key: e.id,
                    staticClass: "element"
                }, [n("div", {
                    staticClass: "time"
                }, [t._v(t._s(t.formatTime(e.time)))]), t._v(" "), n("div", {
                    staticClass: "message"
                }, [t._v("\n            " + t._s(e.message) + "\n          ")])])
            }), 0), t._v(" "), n("div", {
                staticClass: "notes_write"
            }, [n("input", {
                directives: [{
                    name: "model",
                    rawName: "v-model",
                    value: t.message,
                    expression: "message"
                }],
                attrs: {
                    type: "text",
                    placeholder: "..."
                },
                domProps: {
                    value: t.message
                },
                on: {
                    keyup: function(e) {
                        if (!e.type.indexOf("key") && t._k(e.keyCode, "enter", 13, e.key, "Enter")) {
                            return null
                        }
                        e.preventDefault();
                        return t.sendMessage.apply(null, arguments)
                    },
                    input: function(e) {
                        if (e.target.composing) {
                            return
                        }
                        t.message = e.target.value
                    }
                }
            }), t._v(" "), n("span", {
                staticClass: "notes_send",
                on: {
                    click: t.sendMessage
                }
            }, [t._v(">")])])])], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticStyle: {
                    width: "326px",
                    height: "743px"
                }
            }, [n("list", {
                attrs: {
                    list: t.contactsList,
                    showHeader: false
                },
                on: {
                    select: t.onSelect
                }
            })], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "contact",
                staticStyle: {
                    width: "326px",
                    height: "743px",
                    backgroundColor: "white"
                }
            }, [n("list", {
                attrs: {
                    list: t.lcontacts,
                    disable: t.disableList,
                    title: "Contacts"
                },
                on: {
                    back: t.back,
                    select: t.onSelect,
                    option: t.onOption
                }
            })], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_title_content",
                class: {
                    hasInfoBare: t.showInfoBare
                },
                style: t.style
            }, [t.showInfoBare ? n("InfoBare") : t._e(), t._v(" "), n("div", {
                staticClass: "phone_title",
                style: {
                    backgroundColor: t.backgroundColor
                }
            }, [n("button", {
                staticClass: "btn-back",
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.back.apply(null, arguments)
                    }
                }
            }, [n("i", {
                staticClass: "fas fa-angle-left",
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.back.apply(null, arguments)
                    }
                }
            })]), t._v("\n    " + t._s(t.title) + "\n  ")])], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "contact",
                staticStyle: {
                    width: "326px",
                    height: "743px",
                    backgroundColor: "white"
                }
            }, [n("list", {
                attrs: {
                    list: t.lcontacts,
                    title: t.IntlString("APP_MESSAGE_CONTACT_TITLE")
                },
                on: {
                    select: t.onSelect,
                    back: t.back
                }
            })], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_app"
            }, [n("PhoneTitle", {
                attrs: {
                    title: t.IntlString("APP_CONFIG_TITLE")
                },
                on: {
                    back: t.onBackspace
                }
            }), t._v(" "), n("div", {
                staticClass: "phone_content elements"
            }, t._l(t.paramList, function(e, s) {
                return n("div", {
                    key: s,
                    staticClass: "element",
                    class: {
                        select: s === t.currentSelect
                    },
                    on: {
                        click: function(e) {
                            e.stopPropagation();
                            return t.onPressItem(s)
                        }
                    }
                }, [n("i", {
                    staticClass: "fa",
                    class: e.icons,
                    style: {
                        color: e.color
                    },
                    on: {
                        click: function(e) {
                            e.stopPropagation();
                            return t.onPressItem(s)
                        }
                    }
                }), t._v(" "), n("div", {
                    staticClass: "element-content",
                    on: {
                        click: function(e) {
                            e.stopPropagation();
                            return t.onPressItem(s)
                        }
                    }
                }, [n("span", {
                    staticClass: "element-title",
                    on: {
                        click: function(e) {
                            e.stopPropagation();
                            return t.onPressItem(s)
                        }
                    }
                }, [t._v(t._s(e.title))]), t._v(" "), e.value ? n("span", {
                    staticClass: "element-value",
                    on: {
                        click: function(e) {
                            e.stopPropagation();
                            return t.onPressItem(s)
                        }
                    }
                }, [t._v(t._s(e.value))]) : t._e()])])
            }), 0)], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "screen",
                staticStyle: {
                    width: "326px",
                    height: "743px"
                }
            }, [n("list", {
                staticStyle: {
                    color: "black"
                },
                attrs: {
                    list: t.messagesData,
                    disable: t.disableList,
                    title: t.IntlString("APP_MESSAGE_TITLE")
                },
                on: {
                    back: t.back,
                    select: t.onSelect,
                    option: t.onOption
                }
            })], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_content",
                staticStyle: {
                    width: "326px",
                    height: "743px"
                }
            }, [t.imgZoom !== undefined ? n("div", {
                staticClass: "img-fullscreen",
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        t.imgZoom = undefined
                    }
                }
            }, [n("img", {
                attrs: {
                    src: t.imgZoom
                }
            })]) : t._e(), t._v(" "), n("div", {
                ref: "elementsDiv",
                staticClass: "tweets-wrapper"
            }, t._l(t.tweets, function(e, s) {
                return n("div", {
                    key: e.id,
                    staticClass: "tweet",
                    class: {
                        select: s === t.selectMessage
                    }
                }, [n("div", {
                    staticClass: "tweet-img"
                }, [n("img", {
                    staticStyle: {
                        "max-width": "48px",
                        "max-height": "48px"
                    },
                    attrs: {
                        src: e.authorIcon || "https://gcphone.nyc3.cdn.digitaloceanspaces.com/default_profile.png"
                    }
                })]), t._v(" "), n("div", {
                    staticClass: "tweet-content"
                }, [n("div", {
                    staticClass: "tweet-head"
                }, [n("div", {
                    staticClass: "tweet-head-author"
                }, [t._v(t._s(e.author))]), t._v(" "), n("div", {
                    staticClass: "tweet-head-time"
                }, [t._v(t._s(t.formatTime(e.time)))])]), t._v(" "), n("div", {
                    staticClass: "tweet-message"
                }, [!t.isImage(e.message) ? [t._v(t._s(e.message))] : n("img", {
                    staticClass: "tweet-attachement-img",
                    attrs: {
                        src: e.message
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            t.imgZoom = e.message
                        }
                    }
                })], 2), t._v(" "), n("div", {
                    staticClass: "tweet-like"
                }, [n("div", {
                    staticClass: "item svgreply",
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.reply(e)
                        }
                    }
                }, [n("svg", {
                    attrs: {
                        xmlns: "http://www.w3.org/2000/svg",
                        width: "12",
                        height: "12",
                        viewBox: "0 0 24 24"
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.reply(e)
                        }
                    }
                }, [n("path", {
                    attrs: {
                        fill: "none",
                        d: "M0 0h24v24H0V0z"
                    }
                }), n("path", {
                    attrs: {
                        d: "M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H6l-2 2V4h16v12z"
                    }
                })])]), t._v(" "), n("div", {
                    staticClass: "item"
                }), t._v(" "), e.isLikes ? n("div", {
                    staticClass: "item svgdislike",
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.twitterToogleLike({
                                tweetId: e.id
                            })
                        }
                    }
                }, [n("svg", {
                    attrs: {
                        xmlns: "http://www.w3.org/2000/svg",
                        width: "12",
                        height: "12",
                        viewBox: "0 0 24 24"
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.twitterToogleLike({
                                tweetId: e.id
                            })
                        }
                    }
                }, [n("path", {
                    attrs: {
                        d: "M0 0h24v24H0z",
                        fill: "none"
                    }
                }), n("path", {
                    attrs: {
                        d: "M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"
                    }
                })]), t._v(" "), n("span", {
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.twitterToogleLike({
                                tweetId: e.id
                            })
                        }
                    }
                }, [t._v(t._s(e.likes))])]) : n("div", {
                    staticClass: "svglike",
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.twitterToogleLike({
                                tweetId: e.id
                            })
                        }
                    }
                }, [n("svg", {
                    attrs: {
                        xmlns: "http://www.w3.org/2000/svg",
                        width: "12",
                        height: "12",
                        viewBox: "0 0 24 24"
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.twitterToogleLike({
                                tweetId: e.id
                            })
                        }
                    }
                }, [n("path", {
                    attrs: {
                        d: "M0 0h24v24H0z",
                        fill: "none"
                    }
                }), n("path", {
                    attrs: {
                        d: "M16.5 3c-1.74 0-3.41.81-4.5 2.09C10.91 3.81 9.24 3 7.5 3 4.42 3 2 5.42 2 8.5c0 3.78 3.4 6.86 8.55 11.54L12 21.35l1.45-1.32C18.6 15.36 22 12.28 22 8.5 22 5.42 19.58 3 16.5 3zm-4.4 15.55l-.1.1-.1-.1C7.14 14.24 4 11.39 4 8.5 4 6.5 5.5 5 7.5 5c1.54 0 3.04.99 3.57 2.36h1.87C13.46 5.99 14.96 5 16.5 5c2 0 3.5 1.5 3.5 3.5 0 2.89-3.14 5.74-7.9 10.05z"
                    }
                })]), t._v(" "), n("span", {
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.twitterToogleLike({
                                tweetId: e.id
                            })
                        }
                    }
                }, [t._v(t._s(e.likes))])]), t._v(" "), n("div", {
                    staticClass: "item"
                })])])])
            }), 0)])
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_content content inputText",
                staticStyle: {
                    width: "314px",
                    height: "577px"
                }
            }, [t.state === t.STATES.MENU ? [!t.isLogin ? [n("div", {
                staticClass: "group",
                attrs: {
                    "data-type": "button"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        t.state = t.STATES.NOTIFICATION
                    }
                }
            }, [n("input", {
                staticClass: "btn btn-blue",
                attrs: {
                    type: "button",
                    value: t.IntlString("APP_TWITTER_NOTIFICATION")
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        t.state = t.STATES.NOTIFICATION
                    }
                }
            })])] : t._e(), t._v(" "), t.isLogin ? [n("img", {
                staticStyle: {
                    "align-self": "center"
                },
                attrs: {
                    src: t.twitterAvatarUrl,
                    height: "128",
                    width: "128"
                }
            }), t._v(" "), n("div", {
                staticClass: "group",
                attrs: {
                    "data-type": "button"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        t.state = t.STATES.ACCOUNT
                    }
                }
            }, [n("input", {
                staticClass: "btn btn-blue",
                attrs: {
                    type: "button",
                    value: t.IntlString("APP_TWITTER_ACCOUNT_PARAM")
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        t.state = t.STATES.ACCOUNT
                    }
                }
            })]), t._v(" "), n("div", {
                staticClass: "group",
                attrs: {
                    "data-type": "button"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        t.state = t.STATES.NOTIFICATION
                    }
                }
            }, [n("input", {
                staticClass: "btn btn-blue",
                attrs: {
                    type: "button",
                    value: t.IntlString("APP_TWITTER_NOTIFICATION")
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        t.state = t.STATES.NOTIFICATION
                    }
                }
            })])] : t._e()] : t.state === t.STATES.LOGIN ? [n("div", {
                staticClass: "group inputText",
                attrs: {
                    "data-type": "text",
                    "data-maxlength": "64",
                    "data-defaultValue": t.localAccount.username
                }
            }, [n("input", {
                attrs: {
                    type: "text"
                },
                domProps: {
                    value: t.localAccount.username
                },
                on: {
                    change: function(e) {
                        return t.setLocalAccount(e, "username")
                    }
                }
            }), t._v(" "), n("span", {
                staticClass: "highlight"
            }), t._v(" "), n("span", {
                staticClass: "bar"
            }), t._v(" "), n("label", [t._v(t._s(t.IntlString("APP_TWITTER_ACCOUNT_USERNAME")))])]), t._v(" "), n("div", {
                staticClass: "group inputText",
                attrs: {
                    "data-type": "text",
                    "data-model": "password",
                    "data-maxlength": "30"
                }
            }, [n("input", {
                attrs: {
                    autocomplete: "new-password",
                    type: "password"
                },
                domProps: {
                    value: t.localAccount.password
                },
                on: {
                    change: function(e) {
                        return t.setLocalAccount(e, "password")
                    }
                }
            }), t._v(" "), n("span", {
                staticClass: "highlight"
            }), t._v(" "), n("span", {
                staticClass: "bar"
            }), t._v(" "), n("label", [t._v(t._s(t.IntlString("APP_TWITTER_ACCOUNT_PASSWORD")))])]), t._v(" "), n("div", {
                staticClass: "group",
                attrs: {
                    "data-type": "button"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.login.apply(null, arguments)
                    }
                }
            }, [n("input", {
                staticClass: "btn btn-blue",
                attrs: {
                    type: "button",
                    value: t.IntlString("APP_TWITTER_ACCOUNT_LOGIN")
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.login.apply(null, arguments)
                    }
                }
            })])] : t.state === t.STATES.NOTIFICATION ? [n("div", {
                staticClass: "groupCheckBoxTitle"
            }, [n("label", [t._v(t._s(t.IntlString("APP_TWITTER_NOTIFICATION_WHEN")))])]), t._v(" "), n("label", {
                staticClass: "group checkbox",
                attrs: {
                    "data-type": "button"
                },
                on: {
                    click: function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        return t.setNotification(2)
                    }
                }
            }, [n("input", {
                attrs: {
                    type: "checkbox"
                },
                domProps: {
                    checked: t.twitterNotification === 2
                },
                on: {
                    click: function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        return t.setNotification(2)
                    }
                }
            }), t._v("\n      " + t._s(t.IntlString("APP_TWITTER_NOTIFICATION_ALL")) + "\n    ")]), t._v(" "), n("label", {
                staticClass: "group checkbox",
                attrs: {
                    "data-type": "button"
                },
                on: {
                    click: function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        return t.setNotification(1)
                    }
                }
            }, [n("input", {
                attrs: {
                    type: "checkbox"
                },
                domProps: {
                    checked: t.twitterNotification === 1
                },
                on: {
                    click: function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        return t.setNotification(1)
                    }
                }
            }), t._v("\n      " + t._s(t.IntlString("APP_TWITTER_NOTIFICATION_MENTION")) + "\n    ")]), t._v(" "), n("label", {
                staticClass: "group checkbox",
                attrs: {
                    "data-type": "button"
                },
                on: {
                    click: function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        return t.setNotification(0)
                    }
                }
            }, [n("input", {
                attrs: {
                    type: "checkbox"
                },
                domProps: {
                    checked: t.twitterNotification === 0
                },
                on: {
                    click: function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        return t.setNotification(0)
                    }
                }
            }), t._v("\n      " + t._s(t.IntlString("APP_TWITTER_NOTIFICATION_NEVER")) + "\n    ")]), t._v(" "), n("div", {
                staticClass: "groupCheckBoxTitle"
            }, [n("label", [t._v(t._s(t.IntlString("APP_TWITTER_NOTIFICATION_SOUND")))])]), t._v(" "), n("label", {
                staticClass: "group checkbox",
                attrs: {
                    "data-type": "button"
                },
                on: {
                    click: function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        return t.setNotificationSound(true)
                    }
                }
            }, [n("input", {
                attrs: {
                    type: "checkbox"
                },
                domProps: {
                    checked: t.twitterNotificationSound
                },
                on: {
                    click: function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        return t.setNotificationSound(true)
                    }
                }
            }), t._v("\n      " + t._s(t.IntlString("APP_TWITTER_NOTIFICATION_SOUND_YES")) + "\n    ")]), t._v(" "), n("label", {
                staticClass: "group checkbox",
                attrs: {
                    "data-type": "button"
                },
                on: {
                    click: function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        return t.setNotificationSound(false)
                    }
                }
            }, [n("input", {
                attrs: {
                    type: "checkbox"
                },
                domProps: {
                    checked: !t.twitterNotificationSound
                },
                on: {
                    click: function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        return t.setNotificationSound(false)
                    }
                }
            }), t._v("\n      " + t._s(t.IntlString("APP_TWITTER_NOTIFICATION_SOUND_NO")) + "\n    ")])] : t.state === t.STATES.ACCOUNT ? [n("img", {
                staticStyle: {
                    "align-self": "center"
                },
                attrs: {
                    src: t.twitterAvatarUrl,
                    height: "128",
                    width: "128"
                }
            }), t._v(" "), n("div", {
                staticClass: "group",
                attrs: {
                    "data-type": "button"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.onPressChangeAvartar.apply(null, arguments)
                    }
                }
            }, [n("input", {
                staticClass: "btn btn-blue",
                attrs: {
                    type: "button",
                    value: t.IntlString("APP_TWITTER_ACCOUNT_AVATAR")
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.onPressChangeAvartar.apply(null, arguments)
                    }
                }
            })]), t._v(" "), n("div", {
                staticClass: "group",
                attrs: {
                    "data-type": "button"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.onPressChangeAvartartake.apply(null, arguments)
                    }
                }
            }, [n("input", {
                staticClass: "btn btn-blue",
                attrs: {
                    type: "button",
                    value: t.IntlString("APP_TWITTER_ACCOUNT_AVATAR_TAKE")
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.onPressChangeAvartartake.apply(null, arguments)
                    }
                }
            })])] : t._e()], 2)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_content",
                staticStyle: {
                    width: "326px",
                    height: "743px"
                }
            }, [t.imgZoom !== undefined ? n("div", {
                staticClass: "img-fullscreen",
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        t.imgZoom = undefined
                    }
                }
            }, [n("img", {
                attrs: {
                    src: t.imgZoom
                }
            })]) : t._e(), t._v(" "), n("div", {
                ref: "elementsDiv",
                staticClass: "tweets-wrapper"
            }, t._l(t.tweets, function(e, s) {
                return n("div", {
                    key: e.id,
                    staticClass: "tweet",
                    class: {
                        select: s === t.selectMessage
                    }
                }, [n("div", {
                    staticClass: "tweet-img"
                }, [n("img", {
                    staticStyle: {
                        "max-width": "48px",
                        "max-height": "48px"
                    },
                    attrs: {
                        src: e.authorIcon || "https://gcphone.nyc3.cdn.digitaloceanspaces.com/default_profile.png"
                    }
                })]), t._v(" "), n("div", {
                    staticClass: "tweet-content"
                }, [n("div", {
                    staticClass: "tweet-head"
                }, [n("div", {
                    staticClass: "tweet-head-author"
                }, [t._v(t._s(e.author))]), t._v(" "), n("div", {
                    staticClass: "tweet-head-time"
                }, [t._v(t._s(t.formatTime(e.time)))])]), t._v(" "), n("div", {
                    staticClass: "tweet-message"
                }, [!t.isImage(e.message) ? [t._v(t._s(e.message))] : n("img", {
                    staticClass: "tweet-attachement-img",
                    attrs: {
                        src: e.message
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            t.imgZoom = e.message
                        }
                    }
                })], 2), t._v(" "), n("div", {
                    staticClass: "tweet-like"
                }, [n("div", {
                    staticClass: "item svgreply",
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.reply(e)
                        }
                    }
                }, [n("svg", {
                    attrs: {
                        xmlns: "http://www.w3.org/2000/svg",
                        width: "12",
                        height: "12",
                        viewBox: "0 0 24 24"
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.reply(e)
                        }
                    }
                }, [n("path", {
                    attrs: {
                        fill: "none",
                        d: "M0 0h24v24H0V0z"
                    }
                }), n("path", {
                    attrs: {
                        d: "M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H6l-2 2V4h16v12z"
                    }
                })])]), t._v(" "), n("div", {
                    staticClass: "item"
                }, [n("svg", {
                    attrs: {
                        xmlns: "http://www.w3.org/2000/svg",
                        width: "12",
                        height: "12",
                        viewBox: "0 0 24 24"
                    }
                }, [n("path", {
                    attrs: {
                        d: "M0 0h24v24H0z",
                        fill: "none"
                    }
                }), n("path", {
                    attrs: {
                        d: "M7 7h10v3l4-4-4-4v3H5v6h2V7zm10 10H7v-3l-4 4 4 4v-3h12v-6h-2v4z"
                    }
                })])]), t._v(" "), e.isLikes ? n("div", {
                    staticClass: "item svgdislike",
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.twitterToogleLike({
                                tweetId: e.id
                            })
                        }
                    }
                }, [n("svg", {
                    attrs: {
                        xmlns: "http://www.w3.org/2000/svg",
                        width: "12",
                        height: "12",
                        viewBox: "0 0 24 24"
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.twitterToogleLike({
                                tweetId: e.id
                            })
                        }
                    }
                }, [n("path", {
                    attrs: {
                        d: "M0 0h24v24H0z",
                        fill: "none"
                    }
                }), n("path", {
                    attrs: {
                        d: "M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"
                    }
                })]), t._v(" "), n("span", {
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.twitterToogleLike({
                                tweetId: e.id
                            })
                        }
                    }
                }, [t._v(t._s(e.likes))])]) : n("div", {
                    staticClass: "svglike",
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.twitterToogleLike({
                                tweetId: e.id
                            })
                        }
                    }
                }, [n("svg", {
                    attrs: {
                        xmlns: "http://www.w3.org/2000/svg",
                        width: "12",
                        height: "12",
                        viewBox: "0 0 24 24"
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.twitterToogleLike({
                                tweetId: e.id
                            })
                        }
                    }
                }, [n("path", {
                    attrs: {
                        d: "M0 0h24v24H0z",
                        fill: "none"
                    }
                }), n("path", {
                    attrs: {
                        d: "M16.5 3c-1.74 0-3.41.81-4.5 2.09C10.91 3.81 9.24 3 7.5 3 4.42 3 2 5.42 2 8.5c0 3.78 3.4 6.86 8.55 11.54L12 21.35l1.45-1.32C18.6 15.36 22 12.28 22 8.5 22 5.42 19.58 3 16.5 3zm-4.4 15.55l-.1.1-.1-.1C7.14 14.24 4 11.39 4 8.5 4 6.5 5.5 5 7.5 5c1.54 0 3.04.99 3.57 2.36h1.87C13.46 5.99 14.96 5 16.5 5c2 0 3.5 1.5 3.5 3.5 0 2.89-3.14 5.74-7.9 10.05z"
                    }
                })]), t._v(" "), n("span", {
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.twitterToogleLike({
                                tweetId: e.id
                            })
                        }
                    }
                }, [t._v(t._s(e.likes))])]), t._v(" "), n("div", {
                    staticClass: "item"
                }, [n("svg", {
                    attrs: {
                        xmlns: "http://www.w3.org/2000/svg",
                        width: "12",
                        height: "12",
                        viewBox: "0 0 24 24"
                    }
                }, [n("path", {
                    attrs: {
                        fill: "none",
                        d: "M0 0h24v24H0V0z"
                    }
                }), n("path", {
                    attrs: {
                        d: "M18 16.08c-.76 0-1.44.3-1.96.77L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.7l7.05-4.11c.54.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.47.09.7L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.12 4.16c-.05.21-.08.43-.08.65 0 1.61 1.31 2.92 2.92 2.92s2.92-1.31 2.92-2.92-1.31-2.92-2.92-2.92z"
                    }
                })])])])])])
            }), 0)])
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "folders",
                staticStyle: {
                    width: "326px",
                    height: "743px",
                    backgroundColor: "white"
                }
            }, [n("list", {
                attrs: {
                    list: t.vehicles,
                    disable: false,
                    title: t.folder
                },
                on: {
                    select: t.onSelect
                }
            })], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "notifications"
            }, t._l(t.list, function(e) {
                return n("div", {
                    key: e.id,
                    staticClass: "notification",
                    style: t.style(e)
                }, [n("div", {
                    staticClass: "title"
                }, [e.icon ? n("i", {
                    staticClass: "fa",
                    class: "fa-" + e.icon
                }) : t._e(), t._v(" " + t._s(e.title) + "\n    ")]), t._v(" "), n("div", {
                    staticClass: "message"
                }, [t._v(t._s(e.message))])])
            }), 0)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("transition", {
                attrs: {
                    name: "modal"
                }
            }, [n("div", {
                staticClass: "modal-mask",
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.cancel.apply(null, arguments)
                    }
                }
            }, [n("div", {
                staticClass: "modal-container"
            }, t._l(t.choix, function(e, s) {
                return n("div", {
                    key: s,
                    staticClass: "modal-choix",
                    class: {
                        select: s === t.currentSelect
                    },
                    style: {
                        color: e.color
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.selectItem(e)
                        }
                    }
                }, [n("i", {
                    staticClass: "fas",
                    class: e.icons,
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.selectItem(e)
                        }
                    }
                }), t._v(t._s(e.title) + "\r\n            ")])
            }), 0)])])
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_content",
                staticStyle: {
                    width: "326px",
                    height: "743px"
                }
            }, [n("div", {
                staticClass: "tweet_write"
            }, [n("textarea", {
                directives: [{
                    name: "model",
                    rawName: "v-model.trim",
                    value: t.message,
                    expression: "message",
                    modifiers: {
                        trim: true
                    }
                }, {
                    name: "autofocus",
                    rawName: "v-autofocus"
                }],
                staticClass: "textarea-input",
                class: {
                    outlinebl: t.selectedButton === false
                },
                attrs: {
                    placeholder: "Whats Happening? (Press Enter)"
                },
                domProps: {
                    value: t.message
                },
                on: {
                    input: function(e) {
                        if (e.target.composing) {
                            return
                        }
                        t.message = e.target.value.trim()
                    },
                    blur: function(e) {
                        return t.$forceUpdate()
                    }
                }
            }), t._v(" "), n("span", {
                staticClass: "tweet_send",
                class: {
                    btnblue: t.selectedButton === true
                },
                on: {
                    click: t.tweeter
                }
            }, [t._v("Post Tweet")])])])
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticStyle: {
                    height: "100vh",
                    width: "100vw"
                },
                on: {
                    contextmenu: t.closePhone
                }
            }, [n("notification"), t._v(" "), t.show === true && t.tempoHide === false ? n("div", {
                style: {
                    zoom: t.zoom
                },
                on: {
                    contextmenu: function(t) {
                        t.stopPropagation()
                    }
                }
            }, [n("div", {
                staticClass: "phone_wrapper"
            }, [t.coque ? n("div", {
                staticClass: "phone_coque",
                style: {
                    backgroundImage: "url(/html/static/img/coque/" + t.coque.value + ")"
                }
            }) : t._e(), t._v(" "), n("div", {
                staticClass: "phone_screen",
                attrs: {
                    id: "app"
                }
            }, [n("router-view")], 1)])]) : t._e()], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "screen",
                staticStyle: {
                    width: "326px",
                    height: "743px"
                }
            }, [n("div", {
                staticClass: "elements"
            }, [n("InfoBare", {
                staticStyle: {
                    width: "326px",
                    top: "-204px",
                    "margin-left": "-18px"
                }
            }), t._v(" "), n("img", {
                staticClass: "logo_maze",
                attrs: {
                    src: "/html/static/img/app_bank/fleeca_tar.png"
                }
            }), t._v(" "), n("div", {
                staticClass: "num-tarj"
            }, [n("span", {
                staticClass: "moneyTitle"
            }, [t._v(t._s(t.IntlString("APP_BANK_TITLE_BALANCE")))]), t._v(" "), n("span", {
                staticClass: "moneyTitle"
            }, [t._v("£" + t._s(t.bankAmontFormat))])]), t._v(" "), n("div", {
                staticClass: "hr"
            }), t._v(" "), n("div", {
                staticClass: "element"
            }, [n("div", {
                staticClass: "element-content"
            }), t._v(" "), n("div", {
                ref: "form",
                staticClass: "element-content"
            }, [n("input", {
                directives: [{
                    name: "autofocus",
                    rawName: "v-autofocus"
                }, {
                    name: "model",
                    rawName: "v-model",
                    value: t.id,
                    expression: "id"
                }],
                ref: "form0",
                staticClass: "paragonder",
                class: {
                    select: 0 === t.currentSelect
                },
                staticStyle: {
                    "border-radius": "23px",
                    "font-size": "16px"
                },
                attrs: {
                    oninput: "this.value = this.value.replace(/[^0-9.]/g, ''); this.value = this.value.replace(/(\\..*)\\./g, '$1');",
                    placeholder: "Perm ID:"
                },
                domProps: {
                    value: t.id
                },
                on: {
                    input: function(e) {
                        if (e.target.composing) {
                            return
                        }
                        t.id = e.target.value
                    }
                }
            })]), t._v(" "), n("div", {
                staticClass: "element-content"
            }, [n("input", {
                directives: [{
                    name: "model",
                    rawName: "v-model",
                    value: t.paratutar,
                    expression: "paratutar"
                }],
                ref: "form1",
                staticClass: "paragonder",
                class: {
                    select: 1 === t.currentSelect
                },
                staticStyle: {
                    "border-radius": "23px",
                    "font-size": "16px"
                },
                attrs: {
                    oninput: "this.value = this.value.replace(/[^0-9.]/g, ''); this.value = this.value.replace(/(\\..*)\\./g, '$1');",
                    placeholder: "£"
                },
                domProps: {
                    value: t.paratutar
                },
                on: {
                    input: function(e) {
                        if (e.target.composing) {
                            return
                        }
                        t.paratutar = e.target.value
                    }
                }
            }), t._v(" "), n("button", {
                ref: "form2",
                staticClass: "buton-transfer",
                class: {
                    select: 2 === t.currentSelect
                },
                attrs: {
                    id: "gonder"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.paragonder.apply(null, arguments)
                    }
                }
            }, [t._v(t._s(t.IntlString("APP_BANK_BUTTON_TRANSFER")))]), n("br"), t._v(" "), n("button", {
                ref: "form3",
                staticClass: "buton-cancel",
                class: {
                    select: 3 === t.currentSelect
                },
                attrs: {
                    id: "iptal"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.iptal.apply(null, arguments)
                    }
                }
            }, [t._v(t._s(t.IntlString("APP_BANK_BUTTON_CANCEL")))])])])], 1), t._v(" "), n("img", {
                staticClass: "logo_tarj_end",
                attrs: {
                    src: "/html/static/img/app_bank/tarjetas.png"
                }
            })])
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", [n("list", {
                attrs: {
                    list: t.callList,
                    showHeader: false,
                    disable: t.ignoreControls
                },
                on: {
                    select: t.onSelect
                }
            })], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "folders",
                staticStyle: {
                    width: "326px",
                    height: "743px",
                    backgroundColor: "white"
                }
            }, [n("list", {
                attrs: {
                    list: t.folders,
                    disable: false,
                    title: "Valet"
                },
                on: {
                    select: t.onSelect
                }
            })], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_app",
                staticStyle: {
                    width: "326px",
                    height: "743px"
                }
            }, [n("PhoneTitle", {
                attrs: {
                    title: t.currentScreen.title,
                    backgroundColor: "white"
                },
                on: {
                    back: t.quit
                }
            }), t._v(" "), n("div", {
                staticClass: "phone_content"
            }, [n(t.currentScreen.component, {
                tag: "component"
            })], 1), t._v(" "), n("div", {
                staticClass: "twitter_menu"
            }, t._l(t.screen, function(e, s) {
                return n("div", {
                    key: s,
                    staticClass: "twitter_menu-item",
                    class: {
                        select: s === t.currentScreenIndex
                    },
                    on: {
                        click: function(e) {
                            e.stopPropagation();
                            return t.openMenu(s)
                        }
                    }
                }, [n("i", {
                    staticClass: "fa",
                    class: e.icon,
                    on: {
                        click: function(e) {
                            e.stopPropagation();
                            return t.openMenu(s)
                        }
                    }
                })])
            }), 0)], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_app messages",
                staticStyle: {
                    width: "330px",
                    height: "743px",
                    backgroundColor: "white"
                }
            }, [n("PhoneTitle", {
                staticStyle: {
                    backgroundColor: "#F1F1F1",
                    color: "black"
                },
                attrs: {
                    title: t.displayContact
                },
                on: {
                    back: t.quit
                }
            }), t._v(" "), t.imgZoom !== undefined ? n("div", {
                staticClass: "img-fullscreen",
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        t.imgZoom = undefined
                    }
                }
            }, [n("img", {
                attrs: {
                    src: t.imgZoom
                }
            })]) : t._e(), t._v(" "), n("textarea", {
                ref: "copyTextarea",
                staticClass: "copyTextarea"
            }), t._v(" "), n("div", {
                staticStyle: {
                    width: "326px",
                    height: "678px",
                    backgroundColor: "white"
                },
                attrs: {
                    id: "sms_list"
                },
                on: {
                    contextmenu: function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        return t.showOptions.apply(null, arguments)
                    }
                }
            }, t._l(t.messagesList, function(e, s) {
                return n("div", {
                    key: e.id,
                    staticClass: "sms",
                    class: {
                        select: s === t.selectMessage
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.onActionMessage(e)
                        },
                        contextmenu: function(e) {
                            e.preventDefault();
                            e.stopPropagation();
                            return t.showOptions.apply(null, arguments)
                        }
                    }
                }, [n("div", {
                    staticClass: "sms_message_time"
                }, [n("h6", {
                    staticClass: "name_other_sms_me",
                    class: {
                        sms_me: e.owner === 1
                    }
                }, [t._v(t._s(t.displayContact))]), t._v(" "), n("h6", {
                    staticClass: "name_other_sms_other",
                    class: {
                        sms_me: e.owner === 1
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.onActionMessage(e)
                        }
                    }
                }, [n("timeago", {
                    staticClass: "sms_time",
                    staticStyle: {
                        "font-weight": "500"
                    },
                    attrs: {
                        since: e.time,
                        "auto-update": 20
                    }
                })], 1)]), t._v(" "), n("span", {
                    staticClass: "sms_message sms_me",
                    class: {
                        sms_other: e.owner === 0
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.onActionMessage(e)
                        }
                    }
                }, [t.isSMSImage(e) ? n("img", {
                    staticClass: "sms-img",
                    attrs: {
                        src: e.message
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.onActionMessage(e)
                        }
                    }
                }) : n("span", {
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.onActionMessage(e)
                        }
                    }
                }, [t._v(t._s(e.message))])])])
            }), 0), t._v(" "), n("div", {
                class: {
                    outlinebl: this.selectMessage === -1
                },
                staticStyle: {
                    width: "306px"
                },
                attrs: {
                    id: "sms_write"
                },
                on: {
                    contextmenu: function(e) {
                        e.preventDefault();
                        return t.showOptions.apply(null, arguments)
                    }
                }
            }, [n("input", {
                directives: [{
                    name: "model",
                    rawName: "v-model",
                    value: t.message,
                    expression: "message"
                }, {
                    name: "autofocus",
                    rawName: "v-autofocus"
                }],
                attrs: {
                    type: "text",
                    placeholder: t.IntlString("APP_MESSAGE_PLACEHOLDER_ENTER_MESSAGE")
                },
                domProps: {
                    value: t.message
                },
                on: {
                    keyup: function(e) {
                        if (!e.type.indexOf("key") && t._k(e.keyCode, "enter", 13, e.key, "Enter")) {
                            return null
                        }
                        e.preventDefault();
                        return t.send.apply(null, arguments)
                    },
                    input: function(e) {
                        if (e.target.composing) {
                            return
                        }
                        t.message = e.target.value
                    }
                }
            }), t._v(" "), n("div", {
                staticClass: "sms_send",
                staticStyle: {
                    "font-size": "10px"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.send.apply(null, arguments)
                    }
                }
            }, [n("svg", {
                class: {
                    selectfill: t.selectMessage === -1
                },
                attrs: {
                    height: "24",
                    viewBox: "0 0 24 24",
                    width: "24"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.send.apply(null, arguments)
                    }
                }
            }, [n("path", {
                attrs: {
                    d: "M2.01 21L23 12 2.01 3 2 10l15 2-15 2z"
                }
            }), t._v(" "), n("path", {
                attrs: {
                    d: "M0 0h24v24H0z",
                    fill: "none"
                }
            })])])])], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_app"
            }, [t.showHeader ? n("PhoneTitle", {
                attrs: {
                    title: t.title,
                    showInfoBare: t.showInfoBare
                },
                on: {
                    back: t.back
                }
            }) : t._e(), t._v(" "), n("div", {
                staticClass: "phone_content elements",
                staticStyle: {
                    width: "324px",
                    height: "595px"
                }
            }, t._l(t.list, function(e, s) {
                return n("div", {
                    key: e[t.keyDispay],
                    staticClass: "element",
                    class: {
                        select: s === t.currentSelect
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.selectItem(e)
                        },
                        contextmenu: function(n) {
                            n.preventDefault();
                            n.stopPropagation();
                            return t.optionItem(e)
                        }
                    }
                }, [n("div", {
                    staticClass: "elem-pic",
                    style: t.stylePuce(e),
                    attrs: {
                        "v-if": t.showIcons
                    },
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.selectItem(e)
                        }
                    }
                }, [t._v("\n            " + t._s(e.letter || e[t.keyDispay][0]) + "\n          ")]), t._v(" "), e.puce !== undefined && e.puce !== 0 ? n("div", {
                    staticClass: "elem-puce",
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.selectItem(e)
                        },
                        contextmenu: function(n) {
                            n.preventDefault();
                            n.stopPropagation();
                            return t.optionItem(e)
                        }
                    }
                }, [t._v(t._s(e.puce.length > 24 ? e.puce.slice(0, e.puce.length - 30) : e.puce))]) : t._e(), t._v(" "), e.keyDesc === undefined || e.keyDesc === "" ? n("div", {
                    staticClass: "elem-title",
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.selectItem(e)
                        },
                        contextmenu: function(n) {
                            n.preventDefault();
                            n.stopPropagation();
                            return t.optionItem(e)
                        }
                    }
                }, [t._v(t._s(e[t.keyDispay].length >= 24 ? e[t.keyDispay].slice(0, -10) : e[t.keyDispay]) + " ")]) : t._e(), t._v(" "), e.keyDesc !== undefined && e.keyDesc !== "" ? n("div", {
                    staticClass: "elem-title-has-desc",
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.selectItem(e)
                        },
                        contextmenu: function(n) {
                            n.preventDefault();
                            n.stopPropagation();
                            return t.optionItem(e)
                        }
                    }
                }, [t._v(t._s(e[t.keyDispay]))]) : t._e(), t._v(" "), e.keyDesc !== undefined && e.keyDesc !== "" ? n("div", {
                    staticClass: "elem-description",
                    on: {
                        click: function(n) {
                            n.stopPropagation();
                            return t.selectItem(e)
                        },
                        contextmenu: function(n) {
                            n.preventDefault();
                            n.stopPropagation();
                            return t.optionItem(e)
                        }
                    }
                }, [t._v(t._s(e.keyDesc))]) : t._e()])
            }), 0)], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_app"
            }, [n("PhoneTitle", {
                attrs: {
                    title: "AQUA Trader"
                },
                on: {
                    back: t.onBackspace
                }
            }), t._v(" "), n("div", {
                staticClass: "elements"
            }, [n("center", [n("div", [t._v("Coming Soon to AQUA")])])], 1)], 1)
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("span", [t._v(t._s(t.time))])
        },
        staticRenderFns: []
    }
}, function(t, e) {
    t.exports = {
        render: function() {
            var t = this;
            var e = t.$createElement;
            var n = t._self._c || e;
            return n("div", {
                staticClass: "phone_app",
                staticStyle: {
                    width: "326px",
                    height: "743px"
                }
            }, [n("div", {
                staticClass: "backblur",
                style: {
                    background: "url(" + t.backgroundURL + ")"
                }
            }), t._v(" "), n("InfoBare"), t._v(" "), n("div", {
                staticClass: "num"
            }, [t._v(t._s(t.appelsDisplayNumber))]), t._v(" "), n("div", {
                staticClass: "contactName"
            }, [t._v(t._s(t.appelsDisplayName))]), t._v(" "), n("div", {
                staticClass: "time"
            }), t._v(" "), n("div", {
                staticClass: "time-display"
            }, [t._v(t._s(t.timeDisplay))]), t._v(" "), t.useMouse && t.status === 0 ? n("div", {
                staticClass: "ignore",
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.onIgnoreCall.apply(null, arguments)
                    }
                }
            }, [t._v("\n   " + t._s(t.IntlString("APP_PHONE_CALL_IGNORE")) + "\n ")]) : t._e(), t._v(" "), n("div", {
                staticClass: "actionbox"
            }, [n("div", {
                staticClass: "action raccrocher",
                class: {
                    disableTrue: t.status === 0 && t.select !== 0
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.raccrocher.apply(null, arguments)
                    }
                }
            }, [n("svg", {
                attrs: {
                    viewBox: "0 0 24 24"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.raccrocher.apply(null, arguments)
                    }
                }
            }, [n("g", {
                attrs: {
                    transform: "rotate(135, 12, 12)"
                }
            }, [n("path", {
                attrs: {
                    d: "M6.62,10.79C8.06,13.62 10.38,15.94 13.21,17.38L15.41,15.18C15.69,14.9 16.08,14.82 16.43,14.93C17.55,15.3 18.75,15.5 20,15.5A1,1 0 0,1 21,16.5V20A1,1 0 0,1 20,21A17,17 0 0,1 3,4A1,1 0 0,1 4,3H7.5A1,1 0 0,1 8.5,4C8.5,5.25 8.7,6.45 9.07,7.57C9.18,7.92 9.1,8.31 8.82,8.59L6.62,10.79Z"
                }
            })])])]), t._v(" "), t.status === 0 ? n("div", {
                staticClass: "action deccrocher",
                class: {
                    disableFalse: t.status === 0 && t.select !== 1
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.deccrocher.apply(null, arguments)
                    }
                }
            }, [n("svg", {
                attrs: {
                    viewBox: "0 0 24 24"
                },
                on: {
                    click: function(e) {
                        e.stopPropagation();
                        return t.deccrocher.apply(null, arguments)
                    }
                }
            }, [n("g", {
                attrs: {
                    transform: "rotate(0, 12, 12)"
                }
            }, [n("path", {
                attrs: {
                    d: "M6.62,10.79C8.06,13.62 10.38,15.94 13.21,17.38L15.41,15.18C15.69,14.9 16.08,14.82 16.43,14.93C17.55,15.3 18.75,15.5 20,15.5A1,1 0 0,1 21,16.5V20A1,1 0 0,1 20,21A17,17 0 0,1 3,4A1,1 0 0,1 4,3H7.5A1,1 0 0,1 8.5,4C8.5,5.25 8.7,6.45 9.07,7.57C9.18,7.92 9.1,8.31 8.82,8.59L6.62,10.79Z"
                }
            })])])]) : t._e()])], 1)
        },
        staticRenderFns: []
    }
}, , , function(t, e) {
    t.exports = {
        100: "💯",
        1234: "🔢",
        grinning: "😀",
        grimacing: "😬",
        grin: "😁",
        joy: "😂",
        rofl: "🤣",
        partying: "🥳",
        smiley: "😃",
        smile: "😄",
        sweat_smile: "😅",
        laughing: "😆",
        innocent: "😇",
        wink: "😉",
        blush: "😊",
        slightly_smiling_face: "🙂",
        upside_down_face: "🙃",
        relaxed: "☺️",
        yum: "😋",
        relieved: "😌",
        heart_eyes: "😍",
        smiling_face_with_three_hearts: "🥰",
        kissing_heart: "😘",
        kissing: "😗",
        kissing_smiling_eyes: "😙",
        kissing_closed_eyes: "😚",
        stuck_out_tongue_winking_eye: "😜",
        zany: "🤪",
        raised_eyebrow: "🤨",
        monocle: "🧐",
        stuck_out_tongue_closed_eyes: "😝",
        stuck_out_tongue: "😛",
        money_mouth_face: "🤑",
        nerd_face: "🤓",
        sunglasses: "😎",
        star_struck: "🤩",
        clown_face: "🤡",
        cowboy_hat_face: "🤠",
        hugs: "🤗",
        smirk: "😏",
        no_mouth: "😶",
        neutral_face: "😐",
        expressionless: "😑",
        unamused: "😒",
        roll_eyes: "🙄",
        thinking: "🤔",
        lying_face: "🤥",
        hand_over_mouth: "🤭",
        shushing: "🤫",
        symbols_over_mouth: "🤬",
        exploding_head: "🤯",
        flushed: "😳",
        disappointed: "😞",
        worried: "😟",
        angry: "😠",
        rage: "😡",
        pensive: "😔",
        confused: "😕",
        slightly_frowning_face: "🙁",
        frowning_face: "☹",
        persevere: "😣",
        confounded: "😖",
        tired_face: "😫",
        weary: "😩",
        pleading: "🥺",
        triumph: "😤",
        open_mouth: "😮",
        scream: "😱",
        fearful: "😨",
        cold_sweat: "😰",
        hushed: "😯",
        frowning: "😦",
        anguished: "😧",
        cry: "😢",
        disappointed_relieved: "😥",
        drooling_face: "🤤",
        sleepy: "😪",
        sweat: "😓",
        hot: "🥵",
        cold: "🥶",
        sob: "😭",
        dizzy_face: "😵",
        astonished: "😲",
        zipper_mouth_face: "🤐",
        nauseated_face: "🤢",
        sneezing_face: "🤧",
        vomiting: "🤮",
        mask: "😷",
        face_with_thermometer: "🤒",
        face_with_head_bandage: "🤕",
        woozy: "🥴",
        sleeping: "😴",
        zzz: "💤",
        poop: "💩",
        smiling_imp: "😈",
        imp: "👿",
        japanese_ogre: "👹",
        japanese_goblin: "👺",
        skull: "💀",
        ghost: "👻",
        alien: "👽",
        robot: "🤖",
        smiley_cat: "😺",
        smile_cat: "😸",
        joy_cat: "😹",
        heart_eyes_cat: "😻",
        smirk_cat: "😼",
        kissing_cat: "😽",
        scream_cat: "🙀",
        crying_cat_face: "😿",
        pouting_cat: "😾",
        palms_up: "🤲",
        raised_hands: "🙌",
        clap: "👏",
        wave: "👋",
        call_me_hand: "🤙",
        "\\+1": "👍",
        "-1": "👎",
        facepunch: "👊",
        fist: "✊",
        fist_left: "🤛",
        fist_right: "🤜",
        v: "✌",
        ok_hand: "👌",
        raised_hand: "✋",
        raised_back_of_hand: "🤚",
        open_hands: "👐",
        muscle: "💪",
        pray: "🙏",
        foot: "🦶",
        leg: "🦵",
        handshake: "🤝",
        point_up: "☝",
        point_up_2: "👆",
        point_down: "👇",
        point_left: "👈",
        point_right: "👉",
        fu: "🖕",
        raised_hand_with_fingers_splayed: "🖐",
        love_you: "🤟",
        metal: "🤘",
        crossed_fingers: "🤞",
        vulcan_salute: "🖖",
        writing_hand: "✍",
        selfie: "🤳",
        nail_care: "💅",
        lips: "👄",
        tooth: "🦷",
        tongue: "👅",
        ear: "👂",
        nose: "👃",
        eye: "👁",
        eyes: "👀",
        brain: "🧠",
        bust_in_silhouette: "👤",
        busts_in_silhouette: "👥",
        speaking_head: "🗣",
        baby: "👶",
        child: "🧒",
        boy: "👦",
        girl: "👧",
        adult: "🧑",
        man: "👨",
        woman: "👩",
        blonde_woman: "👱‍♀️",
        blonde_man: "👱",
        bearded_person: "🧔",
        older_adult: "🧓",
        older_man: "👴",
        older_woman: "👵",
        man_with_gua_pi_mao: "👲",
        woman_with_headscarf: "🧕",
        woman_with_turban: "👳‍♀️",
        man_with_turban: "👳",
        policewoman: "👮‍♀️",
        policeman: "👮",
        construction_worker_woman: "👷‍♀️",
        construction_worker_man: "👷",
        guardswoman: "💂‍♀️",
        guardsman: "💂",
        female_detective: "🕵️‍♀️",
        male_detective: "🕵",
        woman_health_worker: "👩‍⚕️",
        man_health_worker: "👨‍⚕️",
        woman_farmer: "👩‍🌾",
        man_farmer: "👨‍🌾",
        woman_cook: "👩‍🍳",
        man_cook: "👨‍🍳",
        woman_student: "👩‍🎓",
        man_student: "👨‍🎓",
        woman_singer: "👩‍🎤",
        man_singer: "👨‍🎤",
        woman_teacher: "👩‍🏫",
        man_teacher: "👨‍🏫",
        woman_factory_worker: "👩‍🏭",
        man_factory_worker: "👨‍🏭",
        woman_technologist: "👩‍💻",
        man_technologist: "👨‍💻",
        woman_office_worker: "👩‍💼",
        man_office_worker: "👨‍💼"
    }
}], [154]);