! function(e) {
    var t = {};

    function r(n) {
        if (t[n]) return t[n].exports;
        var i = t[n] = {
            i: n,
            l: !1,
            exports: {}
        };
        return e[n].call(i.exports, i, i.exports, r), i.l = !0, i.exports
    }
    r.m = e, r.c = t, r.d = function(e, t, n) {
        r.o(e, t) || Object.defineProperty(e, t, {
            enumerable: !0,
            get: n
        })
    }, r.r = function(e) {
        "undefined" != typeof Symbol && Symbol.toStringTag && Object.defineProperty(e, Symbol.toStringTag, {
            value: "Module"
        }), Object.defineProperty(e, "__esModule", {
            value: !0
        })
    }, r.t = function(e, t) {
        if (1 & t && (e = r(e)), 8 & t) return e;
        if (4 & t && "object" == typeof e && e && e.__esModule) return e;
        var n = Object.create(null);
        if (r.r(n), Object.defineProperty(n, "default", {
                enumerable: !0,
                value: e
            }), 2 & t && "string" != typeof e)
            for (var i in e) r.d(n, i, function(t) {
                return e[t]
            }.bind(null, i));
        return n
    }, r.n = function(e) {
        var t = e && e.__esModule ? function() {
            return e.default
        } : function() {
            return e
        };
        return r.d(t, "a", t), t
    }, r.o = function(e, t) {
        return Object.prototype.hasOwnProperty.call(e, t)
    }, r.p = "", r(r.s = 0)
}([function(e, t, r) {
    (function(e) {
        const t = e.exports;
        RegisterNuiCallbackType("screenshot_created"), RegisterNuiCallbackType("video_created"), RegisterNuiCallbackType("keep_alive");
        const r = {};
        let n = 0;

        function i(e) {
            const t = n.toString();
            return r[t] = {
                cb: e
            }, n++, t
        }
        on("__cfx_nui:screenshot_created", (e, t) => {
            t(!0), void 0 !== e.id && r[e.id] && (r[e.id].cb(e.data), delete r[e.id])
        }), on("__cfx_nui:video_created", (e, t) => {
            t(!0), void 0 !== e.id && r[e.id] && (r[e.id].cb(e.currentVideo, e.previousVideo), delete r[e.id])
        }), on("__cfx_nui:keep_alive", (e, t) => {
            t(!0), void 0 !== e.id && r[e.id] && (r[e.id].cb(e.failReason), delete r[e.id])
        }), t("requestScreenshot", (e, t) => {
            const r = void 0 !== t ? e : {
                    encoding: "jpg"
                },
                n = void 0 !== t ? t : e;
            r.resultURL = null, r.targetField = null, r.targetURL = `http://${GetCurrentResourceName()}/screenshot_created`, r.correlation = i(n), SendNuiMessage(JSON.stringify({
                request: r
            }))
        }), t("requestScreenshotUpload", (e, t, r, n) => {
            const o = void 0 !== n ? r : {
                    headers: {},
                    encoding: "jpg"
                },
                u = void 0 !== n ? n : r;
            o.targetURL = e, o.targetField = t, o.resultURL = `http://${GetCurrentResourceName()}/screenshot_created`, o.correlation = i(u), SendNuiMessage(JSON.stringify({
                request: o
            }))
        }), onNet("screenshot_basic:requestScreenshot", (e, t) => {
            e.encoding = e.encoding || "jpg", e.targetURL = `http://${GetCurrentServerEndpoint()}${t}`, e.targetField = "file", e.resultURL = null, e.correlation = i(() => {}), SendNuiMessage(JSON.stringify({
                request: e
            }))
        }), t("requestVideoUpload", (e, t, r, n) => {
            const o = void 0 !== n ? r : {
                    headers: {},
                    isVideo: !0,
                    isManual: !1,
                    encoding: "mp4"
                },
                u = void 0 !== n ? n : r;
            o.targetURL = e, o.targetField = t, o.resultURL = `http://${GetCurrentResourceName()}/video_created`, o.correlation = i(u), SendNuiMessage(JSON.stringify({
                request: o
            }))
        }), onNet("screenshot_basic:requestVideo", (e, t) => {
            e.isVideo = !0, e.duration = e.duration || 1e3, e.encoding = e.encoding || "webm", e.targetURL = `http://${GetCurrentServerEndpoint()}${t}`, e.targetField = "file", e.resultURL = null, e.correlation = i(() => {}), SendNuiMessage(JSON.stringify({
                request: e
            }))
        }), t("requestKeepAlive", e => {
            const t = {
                isKeepAlive: !0,
                correlation: i(e),
                resultURL: `http://${GetCurrentResourceName()}/keep_alive`
            };
            SendNuiMessage(JSON.stringify({
                request: t
            }))
        })
    }).call(this, r(1))
}, function(e, t) {
    var r;
    r = function() {
        return this
    }();
    try {
        r = r || new Function("return this")()
    } catch (e) {
        "object" == typeof window && (r = window)
    }
    e.exports = r
}]);